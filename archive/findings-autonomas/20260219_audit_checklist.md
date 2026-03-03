# Auditoría Completa PRONTO - 2026-02-19

## Resumen de Archivos por Proyecto

| Proyecto | Python | Vue/TS/JS | Total |
|----------|--------|-----------|-------|
| pronto-api | 42 | - | 109 |
| pronto-employees | 45 | - | 165 |
| pronto-client | 25 | - | 94 |
| pronto-static | - | 182 | 500 |
| **TOTAL** | **112** | **182** | **868** |

---

## Checklist de Auditoría

### 1. PRONTO-API (42 archivos Python)

#### 1.1 Estructura
- [ ] `app.py` - Configuración principal
- [ ] `routes/` - Endpoints API
- [ ] Modelos usados correctamente
- [ ] Sin `flask.session` (P0)

#### 1.2 Seguridad
- [ ] JWT implementado correctamente
- [ ] CSRF para mutaciones
- [ ] Sin secrets hardcodeados
- [ ] Validación de inputs

#### 1.3 Código Legacy
- [ ] Sin imports de `legacy_*`
- [ ] Sin funciones deprecated
- [ ] Sin código comentado

---

### 2. PRONTO-EMPLOYEES (45 archivos Python)

#### 2.1 Estructura
- [ ] `app.py` - Configuración principal
- [ ] `routes/` - Web routes + API routes
- [ ] `routes/api/` - Todos los blueprints
- [ ] `templates/` - Jinja templates

#### 2.2 Seguridad
- [ ] JWT para auth (no session)
- [ ] CSRF token en templates
- [ ] `static_folder=None`
- [ ] Scope guards correctos

#### 2.3 Reglas AGENTS.md
- [ ] Sin `/static` local
- [ ] Roles canónicos únicamente
- [ ] Scopes: waiter, chef, cashier, admin, system

---

### 3. PRONTO-CLIENT (25 archivos Python)

#### 3.1 Estructura
- [ ] `app.py` - Configuración
- [ ] `routes/` - Web routes
- [ ] `templates/` - Jinja templates
- [ ] Sin endpoints `/api/*` (P0)

#### 3.2 Seguridad
- [ ] Session allowlist: `dining_session_id`, `customer_ref`
- [ ] PII en Redis con TTL
- [ ] Sin auth en session

#### 3.3 Integración
- [ ] Llamadas a pronto-api correctas
- [ ] Variables de entorno configuradas

---

### 4. PRONTO-STATIC (182 archivos Vue/TS/JS)

#### 4.1 Estructura Vue
- [ ] `vue/employees/` - App empleados
- [ ] `vue/clients/` - App clientes
- [ ] `vue/shared/` - Componentes compartidos

#### 4.2 Reglas Frontend
- [ ] Sin `fetch` directo (usar wrapper)
- [ ] `credentials: 'include'` (no 'same-origin')
- [ ] CSRF en todas las mutaciones
- [ ] `/api/*` relativo (sin host hardcode)

#### 4.3 Assets
- [ ] CSS en `static_content/assets/css/`
- [ ] JS compilado en `static_content/assets/js/`
- [ ] Imágenes en `static_content/assets/images/`

---

## Verificaciones Automatizadas

### Gate A: flask.session (P0)
```bash
rg -n "flask.session|from flask import.*session" pronto-api/src pronto-employees/src
```
**Esperado:** 0 resultados (excepto pronto-client allowlist)

### Gate B: Roles canónicos (P0)
```bash
rg -n "'(cook|kitchen|manager|supervisor)'" pronto-libs/src pronto-employees/src
```
**Esperado:** 0 resultados

### Gate C: Estáticos locales (P0)
```bash
rg -n "static_folder=" pronto-employees/src
```
**Esperado:** `static_folder=None`

### Gate D: Fetch directo (P1)
```bash
rg -n "fetch\(" pronto-static/src/vue --type ts --type vue | grep -v "http.ts"
```
**Esperado:** 0 resultados

### Gate E: Credentials same-origin (P0)
```bash
rg -n "credentials.*same-origin" pronto-static/src/vue
```
**Esperado:** 0 resultados

### Gate F: API scoped (P0)
```bash
rg -n '"/(waiter|chef|cashier|admin|system)/api/' pronto-employees/src pronto-client/src
```
**Esperado:** 0 resultados

---

## Ejecutar Auditoría

```bash
# Ejecutar todos los gates
./pronto-scripts/bin/pronto-full-audit.sh

# Verificar inconsistencias
./pronto-scripts/bin/pronto-inconsistency-check

# Paridad API
./pronto-scripts/bin/pronto-api-parity-check employees
./pronto-scripts/bin/pronto-api-parity-check clients
```

---

## Estado: PENDIENTE

Generado: 2026-02-19
