# Bug: Implementación de Patrón Híbrido SSR/Vue para PRONTO-EMPLOYEES

**ID:** BUG-20250209-005-HYBRID-SSR-VUE
**FECHA:** 2026-02-09
**PROYECTO:** pronto-employees, pronto-static
**SEVERIDAD:** alta
**PRIORIDAD:** P1
**ESTADO:** ABIERTO

---

## DATOS TÉCNICOS OBTENIDOS

| Dato | Valor | Fuente |
|------|-------|--------|
| Dominios | Distintos (`localhost:9088` vs `localhost:6081`) | docker-compose.yml |
| Static Path | `/assets/...` (no prefix employees) | .env |
| Roles | `waiter`, `chef`, `cashier`, `admin`, `system` | AGENTS.md |
| Red | `pronto_net` (compartida) | docker-compose.yml |

---

## ARQUITECTURA ELEGIDA: Opción B (Proxy / Mismo Origin)

**Recomendación:** Unificar origins vía reverse-proxy para evitar cookies cross-origin.

### Arquitectura Objetivo

```
Browser (localhost:6081)
│
├─► GET /waiter/login ──► nginx proxy ──► Flask (5000)
│                                        │
│                            ┌───────────┴───────────┐
│                            ▼                       ▼
│                    Static assets           Flask backend
│                    (/assets/*)                  │
│                                                 │
│                            ┌─────────────────────┘
│                            ▼
│                    Vue SPA mounts
│                    desde /assets/js/employees/*
│
├─► POST /api/auth/login ──► Flask (set JWT cookies)
│
└─► GET /api/* ──► Flask (JSON APIs)
```

### Beneficios de Unificar Origins

1. **Cookies same-site** (`SameSite=Lax`) funcionan en dev HTTP
2. **Sin CORS** - elimina preflight + credentials bugs
3. **CSRF simplificado** - tokens normales funcionan
4. **Pattern estable para prod**

---

## IMPLEMENTACIÓN REQUERIDA

### Fase 0: Reverse Proxy (Bloqueante)

**Objetivo:** Unificar `localhost:6081` como único origin.

```nginx
# nginx.conf para employees (resumen)
upstream static_backend {
    server static:80;
}

upstream employees_backend {
    server 127.0.0.1:5000;
}

server {
    listen 80;

    # Assets: proxy a static (mismo origin)
    location /assets/ {
        proxy_pass http://static_backend/assets/;
    }

    # Employees routes: proxy a Flask
    location /employees/ {
        proxy_pass http://employees_backend/employees/;
    }

    # API routes: proxy a Flask
    location /api/ {
        proxy_pass http://employees_backend/api/;
    }
}
```

### Fase 1: Vue Router

```javascript
// pronto-static/src/vue/employees/router/index.js
const routes = [
  { path: '/employees/:scope/login', component: Login },
  { path: '/employees/:scope/dashboard', component: Dashboard },
  { path: '/employees/:scope/logout', component: Logout },
]
```

### Fase 2: Flask Routes

```python
# Routes web (empleados)
GET  /<scope>/login   → 302 → /employees/<scope>/login
POST /<scope>/login    → API, set cookies JWT
POST /<scope>/logout   → clear cookies, 302 → login
GET  /employees/<scope>/* → render shell (SSR mínimo)
GET  /api/* → JSON APIs
```

### Fase 3: Eliminación Templates Legacy

Eliminar solo cuando:
- Login/logout funcione
- Dashboard funcione
- Playwright tests pasen

---

## COOKIES: CONFIGUREACIÓN

### En Mismo Origin (Proxy)

```python
# Flask cookies (SameSite=Lax funciona en HTTP dev)
response.set_cookie(
    "access_token",
    token,
    httponly=True,
    secure=False,  # False para dev HTTP
    samesite="Lax",  # Same-site cookies
    path="/",
)
```

### Si Se Usa Cross-Origin (No Recomendado)

```python
# Solo si no se implementa proxy
response.set_cookie(
    "access_token",
    token,
    httponly=True,
    secure=True,  # HTTPS requerido
    samesite="none",  # Cross-origin
    path="/",
)
```

---

## VERIFICACIONES REQUERIDAS

```bash
# 1. Assets accesibles
curl -I http://localhost:6081/assets/js/employees/app.js

# 2. Login redirige correctamente
curl -I http://localhost:6081/waiter/login

# 3. Cookies seteadas en mismo domain
curl -v -X POST http://localhost:6081/waiter/login \
  -d "email=test&password=pass"

# 4. Playwright tests
cd pronto-tests && npx playwright test employees/
```

---

## DEPENDENCIAS

| Componente | Acción Requerida |
|------------|------------------|
| `nginx.conf` | Crear en `pronto-employees/src/pronto_employees/` |
| `Dockerfile employees` | Modificar para usar nginx como entrypoint |
| `docker-compose.yml` | Agregar proxy/nginx sidecar |
| Vue routes | Configurar bajo `/employees/:scope/*` |
| Flask routes | Ajustar redirects a `/employees/<scope>/*` |

---

## RIESGOS Y MITIGACIONES

| Riesgo | Probabilidad | Impacto | Mitigación |
|--------|--------------|---------|------------|
| Cookies cross-origin | Media | Login falla | Usar proxy (mismo origin) |
| CORS errors | Media | API calls fallan | Proxy unifica origin |
| Asset 404s | Baja | Vue no carga | Verificar paths en nginx |
| Bundle grande | Media | UX lenta | Code splitting por rol |

---

## CRITERIOS DE ÉXITO

- [ ] Mismo origin para employees y assets
- [ ] Login/logout funcionan con cookies same-site
- [ ] Dashboard carga desde assets locales
- [ ] Playwright tests pasan
- [ ] Templates legacy eliminados

---

## NOTAS

Ver también:
- `pronto-docs/errors/BUG-20250209-002-BUSINESS-LOGIC-REVIEW.md`
- `pronto-docs/errors/BUG-20250209-003-CODE-DEDUPLICATION.md`
- AGENTS.md raíz y pronto-employees

---

**ÚLTIMA ACTUALIZACIÓN:** 2026-02-09
**ASIGNADO:** Por determinar
**ESTADO:** ABIERTO
