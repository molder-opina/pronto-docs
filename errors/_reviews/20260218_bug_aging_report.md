# Reporte Aging de Bugs

Fuente: pronto-docs/resueltos.txt (BUG/ERR) + fechas de expedientes

## Resumen
- Total tickets BUG/ERR: 59
- 0-7: 55
- 8-30: 1
- 31-90: 0
- 90+: 3
- sin-dato: 0

## Bucket 0-7
- Total: 55
- [x] ERR-20260213-LOGIN-LAYOUT-VERSION | dias=0 | sev=media | pronto-employees, pronto-static
  Login de empleados desproporcionado y versión fuera de viewport
- [x] ERR-20260213-LOGIN-SCOPE-403 | dias=0 | sev=bloqueante | pronto-libs, pronto-employees, pronto-static
  Login de empleados retorna 403 por validación de scope incompleta
- [x] ERR-20260213-VALIDATE-SEED-SCRIPT | dias=0 | sev=alta | pronto-scripts
  validate-seed.sh reporta éxito falso y apunta a contenedor incorrecto
- [x] ERR-20260213-AUTH-ERROR-404 | dias=0 | sev=media | pronto-employees, pronto-static
  Redirección a /authorization-error retorna 404 en employees
- [x] BUG-20260213-PLACEHOLDER-RESTAURANT-404 | dias=0 | sev=media | pronto-static
  Placeholder de menú cliente apunta a ruta de restaurante inexistente y genera 404/ORB
- [x] ERR-20260213-STATIC-DOCKERFILE-LEGACY-SCRIPT | dias=0 | sev=alta | pronto-static
  Rebuild de static falla por script faltante en Docker image build context
- [x] BUG-20260214-003 | dias=0 | sev=alta | pronto-client
  /api/me no verifica revocación de customer_ref
- [x] BUG-20260214-004 | dias=0 | sev=media | pronto-client
  auth.py usa auth_bp = api_bp (blueprint frágil) + doble import en __init__.py
- [x] BUG-20260214-001 | dias=0 | sev=bloqueante | pronto-client
  notifications.py usa JWT (modelo incorrecto para clientes)
- [x] BUG-20260214-002 | dias=0 | sev=bloqueante | pronto-libs
  Password hashing usa SHA256 con pepper estático
- [x] BUG-20260214-005 | dias=0 | sev=alta | pronto-client
  waiter_calls.py sin auth guard
- [x] BUG-20260214-006 | dias=0 | sev=alta | pronto-client
  split_bills.py sin auth guard
- [x] BUG-20260214-007 | dias=0 | sev=bloqueante | pronto-client
  waiter_calls.py name shadowing flask.session vs SQLAlchemy session
- [x] BUG-20260215-001 | dias=0 | sev=alta | pronto-employees
  Rutas API usan <int:id> para entidades que deben usar UUID
- [x] BUG-20260215-002 | dias=0 | sev=media | pronto-employees, pronto-client
  Uso de current_app.logger en lugar de StructuredLogger
- [x] BUG-20260215-003 | dias=0 | sev=baja | pronto-client
  Archivos de backup en directorio de templates
- [x] ERR-20260218-CLIENT-UUID-ROUTES-SYNTAX | dias=0 | sev=alta | pronto-client
  Rutas API cliente desalineadas (int vs UUID) y error de sintaxis en shortcuts.py
- [x] ERR-20260218-PARITY-ROUTE-ALIGNMENT-P1 | dias=0 | sev=alta | pronto-client, pronto-static, pronto-employees
  API parity desalineado por rutas frontend/backend y login cliente faltante
- [x] BUG-2026-0216-001 | dias=2 | sev=media | pronto-static
  Memory leak en event listeners de checkout (rebinding sin cleanup)
- [x] BUG-2026-0216-003 | dias=2 | sev=media | pronto-client, pronto-static
  Bloque grande de estilos inline en index-alt.html (checkout-offers)
- [x] ERR-20260218-GATE-VALIDATION-RESOLVED-CONSISTENCY | dias=0 | sev=alta | pronto-client, pronto-employees, pronto-docs
  Incumplimiento de gate de converters int+_id y archivos en resolved con ESTADO ABIERTO
- [x] ERR-20260218-EMPLOYEES-ORDERS-500-CUSTOMER-EMAIL | dias=0 | sev=alta | pronto-libs, pronto-employees, pronto-tests
  GET /api/orders en employees falla 500 por columna customer.email inexistente
- [x] BUG-20250209-005-HYBRID-SSR-VUE | dias=0 | sev=desconocida | pronto-employees, pronto-static
  Implementación de patrón híbrido SSR/Vue en employees (same-origin proxy)
- [x] BUG-20250209-004-LEGACY-TEMPLATES | dias=0 | sev=desconocida | pronto-employees, pronto-static
  Consolidación de templates legacy de employees a shell SPA único
- [x] BUG-20250209-002-BUSINESS-LOGIC-REVIEW | dias=0 | sev=desconocida | PRONTO-System
  Revisión completa de lógica de negocio en todos los archivos Python
- [x] ERR-20260218-MIGR-20260218-06-NONIDEMPOTENT-INDEX | dias=0 | sev=alta | pronto-scripts
  Migración 20260218_06 falla por CREATE INDEX no idempotente
- [x] ERR-20260218-EMPLOYEES-MISSING-APP-CONTEXT | dias=0 | sev=alta | pronto-employees
  Template index.html no incluye window.APP_CONTEXT para Vue app
- [x] ERR-20260219-UUID-IMPORT-MISSING | dias=0 | sev=bloqueante | pronto-libs
  customer_service.py usa UUID sin importarlo
- [x] ERR-20260219-MENU-MAPPER-PAYMENT | dias=0 | sev=bloqueante | pronto-libs, pronto-client
  /api/menu retorna 500 por mapper SQLAlchemy (Payment no resuelto)
- [x] ERR-20260219-INITIALIZE-APP-UNDEFINED | dias=0 | sev=alta | pronto-static
  menu.ts llama a funcion initializeApp que no existe
- [x] ERR-20260218-OSM-HANDLERS | dias=0 | sev=bloqueante | pronto-libs
  OrderStateMachine handlers no cambian workflow_status
- [x] ERR-20260218-MAGIC-STRINGS | dias=0 | sev=alta | pronto-libs, pronto-api
  Strings mágicos de estados en lugar de enums canónicos
- [x] ERR-20260219-MISSING-BACKEND-ENDPOINTS | dias=0 | sev=bloqueante | pronto-employees
  Endpoints de API no encontrados (falso positivo)
- [x] ERR-20260219-MISSING-PLACEHOLDER-ASSET | dias=0 | sev=media | pronto-static
  Asset placeholder-food.png no existe
- [x] ERR-20260219-HARDCODED-HOSTS | dias=0 | sev=alta | pronto-client, pronto-employees, pronto-static
  Hosts y puertos hardcodeados impiden despliegue en produccion
- [x] ERR-20260219-EMPLOYEES-AUTH-REFRESH-MISSING | dias=0 | sev=alta | pronto-static, pronto-employees
  Interceptor de auth llama endpoint /api/employees/auth/refresh inexistente
- [x] ERR-20260219-EMPLOYEES-REALTIME-ENDPOINTS-MISSING | dias=0 | sev=alta | pronto-employees, pronto-static
  Endpoints realtime de employees faltantes generan 404
- [x] ERR-20260219-EMPLOYEES-ORDER-HEAD-MISSING | dias=0 | sev=media | pronto-employees, pronto-static
  Validación HEAD /api/orders/{id} en employees usa endpoint inexistente
- [x] ERR-20260219-HARDCODED-HOSTS | dias=0 | sev=alta | pronto-client, pronto-static, pronto-api
  Hosts hardcodeados (falso positivo - ya usa variables de entorno)
- [x] ERR-20260218-001 | dias=0 | sev=bloqueante | pronto-api
  Endpoints de orders sin autenticación JWT
- [x] ERR-20260218-002 | dias=0 | sev=desconocida | pronto-api
  Auditoría general de pronto-api - Gate H compliance
- [x] ERR-20260219-MENU-MAP-NOT-FUNCTION | dias=0 | sev=alta | pronto-static
  use-menu.ts falla con TypeError: e.value.map is not a function
- [x] ERR-20260219-CLIENTS-TEMPLATE-HOST-API-CALLS | dias=0 | sev=media | pronto-client
  Templates de cliente usan `${window.API_BASE}` en llamadas API y generan ruido parity
- [x] ERR-20260219-PLACEHOLDER-STATIC-HOST | dias=0 | sev=media | pronto-static, pronto-client, pronto-employees
  Imagenes placeholder usan path relativo en lugar de static_host_url
- [x] ERR-20260219-CHECKOUT-POST-CSRF | dias=0 | sev=bloqueante | pronto-client
  Checkout cliente falla por mutaciones POST sin token CSRF
- [x] ERR-20260219-FEEDBACK-FORM-UUID | dias=0 | sev=alta | pronto-client
  Ruta web de feedback parsea session_id y employee_id como int en dominio UUID
- [x] ERR-20260219-FEEDBACK-BULK-CROSS-HOST | dias=0 | sev=alta | pronto-client
  Formulario feedback usa endpoint cross-host sin contrato de auth/CSRF
- [x] ERR-20260219-EMPLOYEE-API-ENV-KEY-MISMATCH | dias=0 | sev=media | pronto-client
  Inconsistencia entre variable de entorno documentada y variable leída en app cliente
- [x] ERR-20260219-EMPLOYEES-AUTH-LOGIN-CSRF-EXEMPT | dias=0 | sev=bloqueante | pronto-api
  Endpoint de login de employees usa @csrf.exempt fuera de excepción permitida
- [x] ERR-20260219-SYSTEMSETTING-ATTRIBUTE-NAMES | dias=0 | sev=alta | pronto-libs
  settings_service.py usa nombres de atributos incorrectos
- [x] ERR-20260219-KIOSK-PASSWORD-HARDCODED | dias=0 | sev=media | pronto-client, pronto-employees
  Password de kiosk hardcodeado
- [x] ERR-20260219-USEFETCH-CREDENTIALS | dias=0 | sev=media | pronto-static
  useFetch.ts sin credentials
- [x] ERR-20260219-FEEDBACK-TODO-PARSE-DATES | dias=0 | sev=baja | pronto-api
  TODO sin resolver en feedback.py
- [x] ERR-20260219-CHEF-NOTIFICATIONS-TEST-FAIL | dias=0 | sev=baja | pronto-tests
  Test chef_notifications.spec.ts falla con timeout
- [x] ERR-20260219-PUBLIC-AUTH-ROUTE-CONVENTION | dias=0 | sev=media | pronto-api, pronto-employees, pronto-client, pronto-static
  Rutas públicas y de autenticación fuera de la convención /public y /auth

## Bucket 8-30
- Total: 1
- [x] BUG-20260210-001-TEMPLATE-CLEANUP | dias=8 | sev=alta | pronto-employees
  Template cleanup in-place (employees) para eliminar inline CSS/JS legacy

## Bucket 31-90
- Total: 0
- [x] Sin tickets en este bucket

## Bucket 90+
- Total: 3
- [x] BUG-20250215-001 | dias=365 | sev=bloqueante | pronto-client
  Endpoints de pagos sin autenticación de cliente
- [x] BUG-20250215-002 | dias=365 | sev=alta | pronto-client
  Feedback usa JWT de empleados en lugar de customer session
- [x] BUG-20250215-003 | dias=365 | sev=media | pronto-static
  Datos de usuario en localStorage vulnerable a XSS

## Bucket sin-dato
- Total: 0
- [x] Sin tickets en este bucket

