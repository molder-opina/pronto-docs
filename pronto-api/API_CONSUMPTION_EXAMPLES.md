## Guía de muestra para ejecutar y consumir APIs PRONTO

### Fuentes de verdad
- API canónica: `pronto-api` en `http://localhost:6082/api/*`
- OpenAPI actual: `pronto-docs/contracts/pronto-api/openapi.yaml`
- Cookies API: `pronto-docs/contracts/pronto-api/cookies.md`
- CSRF API: `pronto-docs/contracts/pronto-api/csrf.md`

### Base URLs locales
- API directa: `http://localhost:6082`
- Cliente SSR/BFF: `http://localhost:6080`
- Employees SSR/proxy scope-aware: `http://localhost:6081`

### Reglas rápidas de consumo
- `GET /health` es público.
- `POST /api/sessions/open` es la excepción pública controlada para abrir sesión con `table_id` válido.
- Casi toda mutación `POST|PUT|PATCH|DELETE` requiere `X-CSRFToken`.
- Si llamas directo a `pronto-api` en flujos cliente, propaga `X-PRONTO-CUSTOMER-REF` cuando aplique.
- Para employees, el consumo browser recomendado es vía `/<scope>/api/*` en `pronto-employees`.
- Recomendado en todas las llamadas: `X-Correlation-ID: <uuid>`.

### Headers útiles
- `Content-Type: application/json`
- `X-CSRFToken: <token>`
- `X-Correlation-ID: <uuid>`
- `X-PRONTO-CUSTOMER-REF: <uuid>` (cliente directo contra `:6082`)

### Ejemplos directos contra `pronto-api`

#### 1) Health check
```bash
curl -s http://localhost:6082/health
```

#### 2) Abrir sesión de mesa (excepción pública controlada)
```bash
curl -s -X POST http://localhost:6082/api/sessions/open \
  -H 'Content-Type: application/json' \
  -H 'X-Correlation-ID: test-open-session-001' \
  -d '{"table_id":"11111111-1111-1111-1111-111111111111"}'
```

#### 3) Menú runtime
```bash
curl -s http://localhost:6082/api/menu
```

#### 4) Crear orden cliente (directo a API)
```bash
curl -s -X POST http://localhost:6082/api/customer/orders \
  -H 'Content-Type: application/json' \
  -H 'X-CSRFToken: <csrf_token>' \
  -H 'X-PRONTO-CUSTOMER-REF: <customer_ref>' \
  -H 'X-Correlation-ID: test-order-001' \
  -b cookies.txt -c cookies.txt \
  -d '{"items":[{"menu_item_id":"22222222-2222-2222-2222-222222222222","quantity":1}]}'
```

#### 5) Pedir cuenta de una sesión cliente
```bash
curl -s -X POST http://localhost:6082/api/customer/orders/session/<session_id>/request-check \
  -H 'Content-Type: application/json' \
  -H 'X-CSRFToken: <csrf_token>' \
  -H 'X-PRONTO-CUSTOMER-REF: <customer_ref>' \
  -b cookies.txt -c cookies.txt \
  -d '{}'
```

#### 6) Login employee contra API canónica
```bash
curl -s -X POST http://localhost:6082/api/auth/login \
  -H 'Content-Type: application/json' \
  -H 'X-Correlation-ID: test-admin-login-001' \
  -c cookies.txt \
  -d '{"email":"admin@pronto.local","password":"<secret>","scope":"admin"}'
```

#### 7) Leer órdenes employee ya autenticado
```bash
curl -s http://localhost:6082/api/orders \
  -b cookies.txt \
  -H 'X-Correlation-ID: test-orders-001'
```

### Ejemplos vía `pronto-client` (`:6080`)

#### 1) Obtener token CSRF del cliente
```bash
curl -s http://localhost:6080/api/client-auth/csrf -c cookies.txt
```

#### 2) Registro cliente
```bash
curl -s -X POST http://localhost:6080/api/client-auth/register \
  -H 'Content-Type: application/json' \
  -H 'X-CSRFToken: <csrf_token>' \
  -b cookies.txt -c cookies.txt \
  -d '{"name":"Cliente Demo","email":"demo@example.com","password":"<secret>"}'
```

#### 3) Login cliente
```bash
curl -s -X POST http://localhost:6080/api/client-auth/login \
  -H 'Content-Type: application/json' \
  -H 'X-CSRFToken: <csrf_token>' \
  -b cookies.txt -c cookies.txt \
  -d '{"email":"demo@example.com","password":"<secret>"}'
```

#### 4) Business info desde BFF cliente
```bash
curl -s http://localhost:6080/api/business-info -b cookies.txt
```

#### 5) Flujo cliente típico
```bash
curl -s http://localhost:6080/api/menu -b cookies.txt
curl -s -X POST http://localhost:6080/api/sessions/open -H 'Content-Type: application/json' -d '{"table_id":"<uuid>"}' -b cookies.txt -c cookies.txt
curl -s -X POST http://localhost:6080/api/customer/orders -H 'Content-Type: application/json' -H 'X-CSRFToken: <csrf_token>' -b cookies.txt -c cookies.txt -d '{"items":[{"menu_item_id":"<uuid>","quantity":1}]}'
curl -s -X POST http://localhost:6080/api/customer/orders/session/<session_id>/request-check -H 'X-CSRFToken: <csrf_token>' -b cookies.txt -c cookies.txt -d '{}'
curl -s -X POST http://localhost:6080/api/sessions/<uuid:session_id>/pay/stripe -H 'Content-Type: application/json' -H 'X-CSRFToken: <csrf_token>' -b cookies.txt -c cookies.txt -d '{"tip":20}'
```

### Ejemplos vía `pronto-employees` (`:6081`)

#### Scopes soportados
- `waiter`
- `chef`
- `cashier`
- `admin`
- `system`

#### 1) Login por consola
```bash
curl -s -X POST http://localhost:6081/admin/api/auth/login \
  -H 'Content-Type: application/json' \
  -c cookies.txt \
  -d '{"email":"admin@pronto.local","password":"<secret>","scope":"admin"}'
```

#### 2) Listar órdenes como waiter
```bash
curl -s http://localhost:6081/waiter/api/orders -b cookies.txt
```

#### 3) Aceptar orden como waiter
```bash
curl -s -X POST http://localhost:6081/waiter/api/orders/<order_id>/accept \
  -H 'X-CSRFToken: <csrf_token>' \
  -b cookies.txt -c cookies.txt
```

#### 4) Publicar módulos de home como admin
```bash
curl -s -X POST http://localhost:6081/admin/api/menu-home-modules/publish \
  -H 'Content-Type: application/json' \
  -H 'X-CSRFToken: <csrf_token>' \
  -b cookies.txt -c cookies.txt \
  -d '{}'
```

### Familias API que debes revisar
- Salud y bootstrap: `/health`, `/api/public/*`, `/api/config/*`
- Cliente/auth: `/api/client-auth/*`, `/api/sessions/*`, `/api/customer/*`
- Catálogo: `/api/menu*`, `/api/modifiers*`, `/api/products`
- Órdenes: `/api/orders*`, `/api/modifications*`
- Pagos y facturación: `/api/payments*`, `/api/customer/payments*`, `/api/client/invoices*`
- Feedback/soporte/notificaciones: `/api/feedback*`, `/api/support-tickets`, `/api/notifications*`
- Operación employees: `/api/tables*`, `/api/table-assignments*`, `/api/employees*`, `/api/reports*`, `/api/analytics*`, `/api/admin*`

### Cómo listar todas las APIs registradas desde código

#### `pronto-api`
```bash
cd pronto-api && PRONTO_ROUTES_ONLY=1 PYTHONPATH=src:../pronto-libs/src .venv/bin/python - <<'PY'
import sys, types
flask_wtf_module = types.ModuleType('flask_wtf'); csrf_module = types.ModuleType('flask_wtf.csrf')
class _CSRFProtect: 
    def init_app(self, _app): return None
    def protect(self): return None
    def exempt(self, func): return func
csrf_module.CSRFProtect = _CSRFProtect; csrf_module.generate_csrf = lambda: 'test-csrf-token'
flask_wtf_module.csrf = csrf_module; sys.modules['flask_wtf']=flask_wtf_module; sys.modules['flask_wtf.csrf']=csrf_module
from api_app.app import create_app
app = create_app()
for rule in sorted(app.url_map.iter_rules(), key=lambda r: r.rule):
    if rule.rule.startswith('/api') or rule.rule == '/health':
        print(','.join(sorted(m for m in rule.methods if m not in {'HEAD','OPTIONS'})), rule.rule)
PY
```

#### `pronto-client`
```bash
cd pronto-client && PRONTO_ROUTES_ONLY=1 PYTHONPATH=src:../pronto-libs/src ../pronto-api/.venv/bin/python - <<'PY'
import sys, types
flask_wtf_module = types.ModuleType('flask_wtf'); csrf_module = types.ModuleType('flask_wtf.csrf')
class _CSRFProtect: 
    def init_app(self, _app): return None
    def protect(self): return None
    def exempt(self, func): return func
csrf_module.CSRFProtect = _CSRFProtect; csrf_module.generate_csrf = lambda: 'test-csrf-token'
flask_wtf_module.csrf = csrf_module; sys.modules['flask_wtf']=flask_wtf_module; sys.modules['flask_wtf.csrf']=csrf_module
from pronto_clients.app import create_app
app = create_app()
for rule in sorted(app.url_map.iter_rules(), key=lambda r: r.rule):
    if rule.rule.startswith('/api'): print(rule.rule)
PY
```

#### `pronto-employees`
```bash
cd pronto-employees && PRONTO_ROUTES_ONLY=1 PYTHONPATH=src:../pronto-libs/src ../pronto-api/.venv/bin/python - <<'PY'
from pronto_employees.routes.api.proxy_console_api import proxy_bp
print('Scopes proxy soportados: /waiter/api/* /chef/api/* /cashier/api/* /admin/api/* /system/api/*')
print('Blueprint:', proxy_bp.name)
PY
```

### Recomendación final
- Para contratos exactos de request/response usa primero `pronto-docs/contracts/pronto-api/openapi.yaml`.
- Usa esta guía como plantilla de consumo local, smoke tests y troubleshooting.
- Si necesitas un catálogo endpoint-por-endpoint, el siguiente paso correcto es generar una tabla derivada del `url_map` de `pronto-api` y del `openapi.yaml` actual.