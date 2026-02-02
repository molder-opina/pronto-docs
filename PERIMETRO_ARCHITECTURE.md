# Arquitectura Perímetro/Núcleo - Implementación Completa

## Resumen

Se ha implementado exitosamente la arquitectura de **perímetro por scope** con **núcleo compartido** para las APIs del sistema Pronto. Esta arquitectura separa las rutas API por scope mientras mantiene controladores y servicios compartidos.

## Fecha de Implementación

**2026-01-26**

## Arquitectura

### Perímetro (URLs separadas por scope)

Cada scope tiene su propia ruta API que valida la cookie y sesión correspondiente:

```
/waiter/api/*   → Usa cookie sess_waiter, valida active_scope == "waiter"
/chef/api/*     → Usa cookie sess_chef, valida active_scope == "chef"
/cashier/api/*  → Usa cookie sess_cashier, valida active_scope == "cashier"
/admin/api/*    → Usa cookie sess_admin, valida active_scope == "admin"
/system/api/*   → Usa cookie sess_system, valida active_scope == "system"
/api/*          → Legacy (sin validación de scope)
```

### Núcleo (Controladores compartidos)

Los handlers y servicios son los mismos para todos los scopes:
- `build/pronto_employees/routes/api/*.py` - Controladores API
- `build/shared/services/*.py` - Lógica de negocio

## Cambios Implementados

### 1. Scope Guard Middleware (`build/shared/scope_guard.py`)

Se agregaron funciones de validación de scope a nivel API:

**`extract_scope_from_path(path: str)`**
- Extrae el scope de la URL
- Ejemplo: `/waiter/api/orders` → `"waiter"`

**`apply_api_scope_guard(app)`**
- Middleware global que valida antes de cada request API
- Verifica que el scope de la URL coincida con `session.active_scope`
- Retorna 401 si no hay sesión
- Retorna 403 si hay mismatch de scope

**Código clave:**
```python
if session_scope != url_scope:
    logger.warning(
        f"API Scope Guard - Mismatch: URL={url_scope}, "
        f"session={session_scope}, path={request.path}"
    )
    return jsonify({
        'error': f'Scope mismatch: URL requires {url_scope}, '
                 f'but session is {session_scope}',
        'code': 'SCOPE_MISMATCH'
    }), 403
```

### 2. API Scoped Registration (`build/pronto_employees/routes/api_scoped.py`)

Nuevo módulo que registra el mismo blueprint múltiples veces con diferentes prefijos:

**`register_scoped_apis(app, shared_api_blueprint)`**
- Registra el blueprint `api_bp` cinco veces
- Cada registro usa un nombre único (`waiter_api`, `chef_api`, etc.)
- Cada registro usa un prefijo de URL único (`/waiter/api`, `/chef/api`, etc.)

**Código:**
```python
scopes = ['waiter', 'chef', 'cashier', 'admin', 'system']

for scope in scopes:
    app.register_blueprint(
        shared_api_blueprint,
        name=f'{scope}_api',
        url_prefix=f'/{scope}/api'
    )
```

### 3. App Configuration (`build/pronto_employees/app.py`)

Se integró la arquitectura perímetro en la configuración de la app:

**Cambios:**
```python
# Importar helper de registro scoped
from routes.api_scoped import register_scoped_apis

# Registrar rutas legacy /api/* (sin validación)
app.register_blueprint(api_bp)

# Registrar rutas scoped /<scope>/api/* (con validación)
register_scoped_apis(app, api_bp)

# Exentar de CSRF
csrf.exempt(api_bp)

# Aplicar middleware de validación
from shared.scope_guard import apply_api_scope_guard
apply_api_scope_guard(app)
```

### 4. Frontend URL Rewriting (`build/pronto_employees/static/js/src/core/http.ts`)

El frontend ahora reescribe automáticamente las URLs de API según el scope actual:

**`authenticatedFetch()`:**
```typescript
const currentScope = getCurrentScope();  // "/waiter", "/chef", etc.
let url = typeof input === 'string' ? input : input.toString();

// Reescribir /api/* a /<scope>/api/*
if (currentScope && url.startsWith('/api/')) {
  url = `${currentScope}${url}`;  // /api/orders → /waiter/api/orders
  input = url;
}
```

**`requestJSON()`:**
```typescript
const currentScope = getCurrentScope();
let finalEndpoint = endpoint;

if (currentScope && endpoint.startsWith('/api/')) {
  finalEndpoint = `${currentScope}${endpoint}`;
}
```

## Flujo de Validación

### Ejemplo: Mesero llamando /api/orders

1. **Frontend detecta scope**:
   - URL actual: `http://localhost:6081/waiter/dashboard`
   - `getCurrentScope()` retorna `"/waiter"`

2. **Frontend reescribe URL**:
   - Llamada original: `fetch('/api/orders')`
   - URL reescrita: `fetch('/waiter/api/orders')`

3. **Backend recibe request**:
   - Path: `/waiter/api/orders`
   - Cookie: `sess_waiter`

4. **MultiScopeSessionInterface carga sesión**:
   - Detecta path `/waiter/api/orders`
   - Extrae scope `waiter`
   - Lee cookie `sess_waiter`
   - Carga sesión correspondiente

5. **API Scope Guard valida**:
   - Extrae scope de URL: `waiter`
   - Lee `session.active_scope`: `waiter`
   - Compara: `waiter == waiter` ✅
   - Permite continuar

6. **Controller ejecuta**:
   - Handler en `routes/api/orders.py`
   - Lógica compartida en `shared/services/order_service.py`

### Ejemplo: Ataque de scope confusion

Si un mesero intenta acceder a `/admin/api/menu/edit`:

1. **Frontend reescribe URL**:
   - Path actual: `/waiter/dashboard`
   - Scope actual: `waiter`
   - URL reescrita: `/waiter/api/menu/edit`

2. **Si el atacante manipula manualmente la URL**:
   - Fuerza navegador a `/admin/api/menu/edit`
   - Cookie enviada: `sess_waiter` (única que tiene)

3. **Backend valida**:
   - Scope de URL: `admin`
   - Scope de sesión: `waiter`
   - Mismatch: `admin != waiter` ❌
   - Retorna: `403 Forbidden`

## Seguridad

### ✅ Ventajas de esta arquitectura

1. **URL como perímetro**: El scope se determina por la URL, no por headers del cliente
2. **Validación server-side**: El backend valida el match scope-sesión
3. **Cookies aisladas**: Cada scope usa su propia cookie
4. **Imposible falsificar**: No se puede enviar cookie de un scope a URL de otro scope
5. **Defense in depth**: Múltiples capas de validación (cookie + session + scope guard)

### ❌ Vulnerabilidades prevenidas

1. **Scope confusion**: No se puede usar sesión de mesero para llamar APIs de admin
2. **Session hijacking cross-scope**: Las cookies están aisladas por Path
3. **Client header manipulation**: No confiamos en headers del cliente
4. **CSRF**: APIs están exentas pero las páginas tienen protección CSRF

## Testing

### Casos de prueba recomendados

#### 1. Login normal en cada scope

```bash
# Mesero
curl -X POST http://localhost:6081/waiter/process-login \
  -d "employee_id=1&password=pass" \
  -c cookies_waiter.txt

# Verificar que se creó cookie sess_waiter
curl http://localhost:6081/waiter/api/orders \
  -b cookies_waiter.txt
```

#### 2. Cross-scope rejection

```bash
# Login como mesero
curl -X POST http://localhost:6081/waiter/process-login \
  -d "employee_id=1&password=pass" \
  -c cookies_waiter.txt

# Intentar acceder a admin API (debe fallar con 403)
curl http://localhost:6081/admin/api/menu/categories \
  -b cookies_waiter.txt
```

#### 3. Frontend rewriting

1. Abrir DevTools → Network
2. Login en `/waiter/login`
3. Navegar al dashboard
4. Observar que las llamadas fetch son a `/waiter/api/*` no `/api/*`

## Limpieza de Sesiones

**IMPORTANTE**: Los usuarios deben limpiar sus cookies antes de probar:

```bash
# Opción 1: Desde el navegador
# DevTools → Application → Cookies → localhost:6081 → Delete All

# Opción 2: Endpoint de limpieza
curl http://localhost:6081/api/debug/cleanup?confirm=yes
```

## Próximos Pasos

### Opcional: Eliminar código legacy

Una vez validado que la arquitectura funciona, se puede:

1. Eliminar el registro legacy `/api/*` routes
2. Remover header `X-Pronto-Scope` del frontend (ya no se usa)
3. Actualizar CORS para incluir rutas scoped

### Migración completa

Para migración completa a apps modulares:
- Ver `docs/RESUMEN_FINAL_EJECUTIVO.md`
- Ver `MIGRACION_COMPLETADA_FINAL.md`

## Referencias

- **Diseño original**: Discusión del 2026-01-26 sobre perímetro/núcleo
- **Multi-scope sessions**: `build/shared/multi_scope_session.py`
- **Permissions system**: `build/shared/permissions.py`
- **CSRF fix**: `docs/CSRF_SESSION_FIX.md`

## Contacto

Para reportar problemas con esta arquitectura, consultar:
- `build/shared/scope_guard.py:92-229` (API scope validation)
- `build/pronto_employees/routes/api_scoped.py` (Blueprint registration)
- `build/pronto_employees/static/js/src/core/http.ts` (Frontend URL rewriting)
