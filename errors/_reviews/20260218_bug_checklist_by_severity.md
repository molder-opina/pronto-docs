# Checklist de Bugs por Severidad

Fuente: pronto-docs/resueltos.txt + severidad extraída de expedientes en pronto-docs/resolved/

## Resumen
- Total bugs (BUG/ERR): 59
- bloqueante: 12
- alta: 24
- media: 16
- baja: 3
- desconocida: 4

## bloqueante
- Total: 12
- [x] ERR-20260213-LOGIN-SCOPE-403 | Login de empleados retorna 403 por validación de scope incompleta | estado=RESUELTO | pronto-libs, pronto-employees, pronto-static
- [x] BUG-20260214-001 | notifications.py usa JWT (modelo incorrecto para clientes) | estado=RESUELTO | pronto-client
- [x] BUG-20260214-002 | Password hashing usa SHA256 con pepper estático | estado=RESUELTO | pronto-libs
- [x] BUG-20260214-007 | waiter_calls.py name shadowing flask.session vs SQLAlchemy session | estado=RESUELTO | pronto-client
- [x] BUG-20250215-001 | Endpoints de pagos sin autenticación de cliente | estado=RESUELTO | pronto-client
- [x] ERR-20260219-UUID-IMPORT-MISSING | customer_service.py usa UUID sin importarlo | estado=RESUELTO | pronto-libs
- [x] ERR-20260219-MENU-MAPPER-PAYMENT | /api/menu retorna 500 por mapper SQLAlchemy (Payment no resuelto) | estado=RESUELTO | pronto-libs, pronto-client
- [x] ERR-20260218-OSM-HANDLERS | OrderStateMachine handlers no cambian workflow_status | estado=RESUELTO | pronto-libs
- [x] ERR-20260219-MISSING-BACKEND-ENDPOINTS | Endpoints de API no encontrados (falso positivo) | estado=RESUELTO | pronto-employees
- [x] ERR-20260218-001 | Endpoints de orders sin autenticación JWT | estado=RESUELTO | pronto-api
- [x] ERR-20260219-CHECKOUT-POST-CSRF | Checkout cliente falla por mutaciones POST sin token CSRF | estado=RESUELTO | pronto-client
- [x] ERR-20260219-EMPLOYEES-AUTH-LOGIN-CSRF-EXEMPT | Endpoint de login de employees usa @csrf.exempt fuera de excepción permitida | estado=RESUELTO | pronto-api

## alta
- Total: 24
- [x] ERR-20260213-VALIDATE-SEED-SCRIPT | validate-seed.sh reporta éxito falso y apunta a contenedor incorrecto | estado=RESUELTO | pronto-scripts
- [x] ERR-20260213-STATIC-DOCKERFILE-LEGACY-SCRIPT | Rebuild de static falla por script faltante en Docker image build context | estado=RESUELTO | pronto-static
- [x] BUG-20260214-003 | /api/me no verifica revocación de customer_ref | estado=RESUELTO | pronto-client
- [x] BUG-20260214-005 | waiter_calls.py sin auth guard | estado=RESUELTO | pronto-client
- [x] BUG-20260214-006 | split_bills.py sin auth guard | estado=RESUELTO | pronto-client
- [x] BUG-20250215-002 | Feedback usa JWT de empleados en lugar de customer session | estado=RESUELTO | pronto-client
- [x] BUG-20260215-001 | Rutas API usan <int:id> para entidades que deben usar UUID | estado=RESUELTO | pronto-employees
- [x] ERR-20260218-CLIENT-UUID-ROUTES-SYNTAX | Rutas API cliente desalineadas (int vs UUID) y error de sintaxis en shortcuts.py | estado=RESUELTO | pronto-client
- [x] ERR-20260218-PARITY-ROUTE-ALIGNMENT-P1 | API parity desalineado por rutas frontend/backend y login cliente faltante | estado=RESUELTO | pronto-client, pronto-static, pronto-employees
- [x] ERR-20260218-GATE-VALIDATION-RESOLVED-CONSISTENCY | Incumplimiento de gate de converters int+_id y archivos en resolved con ESTADO ABIERTO | estado=RESUELTO | pronto-client, pronto-employees, pronto-docs
- [x] BUG-20260210-001-TEMPLATE-CLEANUP | Template cleanup in-place (employees) para eliminar inline CSS/JS legacy | estado=RESUELTO | pronto-employees
- [x] ERR-20260218-EMPLOYEES-ORDERS-500-CUSTOMER-EMAIL | GET /api/orders en employees falla 500 por columna customer.email inexistente | estado=RESUELTO | pronto-libs, pronto-employees, pronto-tests
- [x] ERR-20260218-MIGR-20260218-06-NONIDEMPOTENT-INDEX | Migración 20260218_06 falla por CREATE INDEX no idempotente | estado=RESUELTO | pronto-scripts
- [x] ERR-20260218-EMPLOYEES-MISSING-APP-CONTEXT | Template index.html no incluye window.APP_CONTEXT para Vue app | estado=RESUELTO | pronto-employees
- [x] ERR-20260219-INITIALIZE-APP-UNDEFINED | menu.ts llama a funcion initializeApp que no existe | estado=RESUELTO | pronto-static
- [x] ERR-20260218-MAGIC-STRINGS | Strings mágicos de estados en lugar de enums canónicos | estado=RESUELTO | pronto-libs, pronto-api
- [x] ERR-20260219-HARDCODED-HOSTS | Hosts y puertos hardcodeados impiden despliegue en produccion | estado=RESUELTO | pronto-client, pronto-employees, pronto-static
- [x] ERR-20260219-EMPLOYEES-AUTH-REFRESH-MISSING | Interceptor de auth llama endpoint /api/employees/auth/refresh inexistente | estado=RESUELTO | pronto-static, pronto-employees
- [x] ERR-20260219-EMPLOYEES-REALTIME-ENDPOINTS-MISSING | Endpoints realtime de employees faltantes generan 404 | estado=RESUELTO | pronto-employees, pronto-static
- [x] ERR-20260219-HARDCODED-HOSTS | Hosts hardcodeados (falso positivo - ya usa variables de entorno) | estado=RESUELTO | pronto-client, pronto-static, pronto-api
- [x] ERR-20260219-MENU-MAP-NOT-FUNCTION | use-menu.ts falla con TypeError: e.value.map is not a function | estado=RESUELTO | pronto-static
- [x] ERR-20260219-FEEDBACK-FORM-UUID | Ruta web de feedback parsea session_id y employee_id como int en dominio UUID | estado=RESUELTO | pronto-client
- [x] ERR-20260219-FEEDBACK-BULK-CROSS-HOST | Formulario feedback usa endpoint cross-host sin contrato de auth/CSRF | estado=RESUELTO | pronto-client
- [x] ERR-20260219-SYSTEMSETTING-ATTRIBUTE-NAMES | settings_service.py usa nombres de atributos incorrectos | estado=RESUELTO | pronto-libs

## media
- Total: 16
- [x] ERR-20260213-LOGIN-LAYOUT-VERSION | Login de empleados desproporcionado y versión fuera de viewport | estado=RESUELTO | pronto-employees, pronto-static
- [x] ERR-20260213-AUTH-ERROR-404 | Redirección a /authorization-error retorna 404 en employees | estado=RESUELTO | pronto-employees, pronto-static
- [x] BUG-20260213-PLACEHOLDER-RESTAURANT-404 | Placeholder de menú cliente apunta a ruta de restaurante inexistente y genera 404/ORB | estado=RESUELTO | pronto-static
- [x] BUG-20260214-004 | auth.py usa auth_bp = api_bp (blueprint frágil) + doble import en __init__.py | estado=RESUELTO | pronto-client
- [x] BUG-20250215-003 | Datos de usuario en localStorage vulnerable a XSS | estado=RESUELTO | pronto-static
- [x] BUG-20260215-002 | Uso de current_app.logger en lugar de StructuredLogger | estado=RESUELTO | pronto-employees, pronto-client
- [x] BUG-2026-0216-001 | Memory leak en event listeners de checkout (rebinding sin cleanup) | estado=RESUELTO | pronto-static
- [x] BUG-2026-0216-003 | Bloque grande de estilos inline en index-alt.html (checkout-offers) | estado=RESUELTO | pronto-client, pronto-static
- [x] ERR-20260219-MISSING-PLACEHOLDER-ASSET | Asset placeholder-food.png no existe | estado=RESUELTO | pronto-static
- [x] ERR-20260219-EMPLOYEES-ORDER-HEAD-MISSING | Validación HEAD /api/orders/{id} en employees usa endpoint inexistente | estado=RESUELTO | pronto-employees, pronto-static
- [x] ERR-20260219-CLIENTS-TEMPLATE-HOST-API-CALLS | Templates de cliente usan `${window.API_BASE}` en llamadas API y generan ruido parity | estado=RESUELTO | pronto-client
- [x] ERR-20260219-PLACEHOLDER-STATIC-HOST | Imagenes placeholder usan path relativo en lugar de static_host_url | estado=RESUELTO | pronto-static, pronto-client, pronto-employees
- [x] ERR-20260219-EMPLOYEE-API-ENV-KEY-MISMATCH | Inconsistencia entre variable de entorno documentada y variable leída en app cliente | estado=RESUELTO | pronto-client
- [x] ERR-20260219-KIOSK-PASSWORD-HARDCODED | Password de kiosk hardcodeado | estado=RESUELTO | pronto-client, pronto-employees
- [x] ERR-20260219-USEFETCH-CREDENTIALS | useFetch.ts sin credentials | estado=RESUELTO | pronto-static
- [x] ERR-20260219-PUBLIC-AUTH-ROUTE-CONVENTION | Rutas públicas y de autenticación fuera de la convención /public y /auth | estado=RESUELTO | pronto-api, pronto-employees, pronto-client, pronto-static

## baja
- Total: 3
- [x] BUG-20260215-003 | Archivos de backup en directorio de templates | estado=RESUELTO | pronto-client
- [x] ERR-20260219-FEEDBACK-TODO-PARSE-DATES | TODO sin resolver en feedback.py | estado=RESUELTO | pronto-api
- [x] ERR-20260219-CHEF-NOTIFICATIONS-TEST-FAIL | Test chef_notifications.spec.ts falla con timeout | estado=RESUELTO | pronto-tests

## desconocida
- Total: 4
- [x] BUG-20250209-005-HYBRID-SSR-VUE | Implementación de patrón híbrido SSR/Vue en employees (same-origin proxy) | estado=RESUELTO | pronto-employees, pronto-static
- [x] BUG-20250209-004-LEGACY-TEMPLATES | Consolidación de templates legacy de employees a shell SPA único | estado=RESUELTO | pronto-employees, pronto-static
- [x] BUG-20250209-002-BUSINESS-LOGIC-REVIEW | Revisión completa de lógica de negocio en todos los archivos Python | estado=RESUELTO | PRONTO-System
- [x] ERR-20260218-002 | Auditoría general de pronto-api - Gate H compliance | estado=RESUELTO | pronto-api

