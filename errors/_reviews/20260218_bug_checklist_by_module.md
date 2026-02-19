# Checklist de Bugs por Módulo

Fuente: pronto-docs/resueltos.txt

## pronto-static
- Total: 19
- Resueltos: 18
- Pendientes: 1

- [x] ERR-20260213-LOGIN-LAYOUT-VERSION | Login de empleados desproporcionado y versión fuera de viewport | RESUELTO
- [x] ERR-20260213-LOGIN-SCOPE-403 | Login de empleados retorna 403 por validación de scope incompleta | RESUELTO
- [x] ERR-20260213-AUTH-ERROR-404 | Redirección a /authorization-error retorna 404 en employees | RESUELTO
- [x] BUG-20260213-PLACEHOLDER-RESTAURANT-404 | Placeholder de menú cliente apunta a ruta de restaurante inexistente y genera 404/ORB | RESUELTO
- [x] ERR-20260213-STATIC-DOCKERFILE-LEGACY-SCRIPT | Rebuild de static falla por script faltante en Docker image build context | RESUELTO
- [x] BUG-20250215-003 | Datos de usuario en localStorage vulnerable a XSS | RESUELTO
- [x] ERR-20260218-PARITY-ROUTE-ALIGNMENT-P1 | API parity desalineado por rutas frontend/backend y login cliente faltante | RESUELTO
- [x] BUG-2026-0216-001 | Memory leak en event listeners de checkout (rebinding sin cleanup) | RESUELTO
- [x] BUG-2026-0216-003 | Bloque grande de estilos inline en index-alt.html (checkout-offers) | RESUELTO
- [x] BUG-20250209-005-HYBRID-SSR-VUE | Implementación de patrón híbrido SSR/Vue en employees (same-origin proxy) | RESUELTO
- [x] BUG-20250209-004-LEGACY-TEMPLATES | Consolidación de templates legacy de employees a shell SPA único | RESUELTO
- [x] ERR-20260219-INITIALIZE-APP-UNDEFINED | menu.ts llama a funcion initializeApp que no existe | RESUELTO
- [x] ERR-20260219-MISSING-PLACEHOLDER-ASSET | Asset placeholder-food.png no existe | RESUELTO
- [ ] ERR-20260219-HARDCODED-HOSTS | Hosts y puertos hardcodeados impiden despliegue en produccion | N/A
- [x] ERR-20260219-EMPLOYEES-AUTH-REFRESH-MISSING | Interceptor de auth llama endpoint /api/employees/auth/refresh inexistente | RESUELTO
- [x] ERR-20260219-EMPLOYEES-REALTIME-ENDPOINTS-MISSING | Endpoints realtime de employees faltantes generan 404 | RESUELTO
- [x] ERR-20260219-EMPLOYEES-ORDER-HEAD-MISSING | Validación HEAD /api/orders/{id} en employees usa endpoint inexistente | RESUELTO
- [x] ERR-20260219-HARDCODED-HOSTS | Hosts hardcodeados (falso positivo - ya usa variables de entorno) | RESUELTO
- [x] ERR-20260219-MENU-MAP-NOT-FUNCTION | use-menu.ts falla con TypeError: e.value.map is not a function | RESUELTO

## pronto-employees
- Total: 17
- Resueltos: 16
- Pendientes: 1

- [x] ERR-20260213-LOGIN-LAYOUT-VERSION | Login de empleados desproporcionado y versión fuera de viewport | RESUELTO
- [x] ERR-20260213-LOGIN-SCOPE-403 | Login de empleados retorna 403 por validación de scope incompleta | RESUELTO
- [x] ERR-20260213-AUTH-ERROR-404 | Redirección a /authorization-error retorna 404 en employees | RESUELTO
- [x] BUG-20260215-001 | Rutas API usan <int:id> para entidades que deben usar UUID | RESUELTO
- [x] BUG-20260215-002 | Uso de current_app.logger en lugar de StructuredLogger | RESUELTO
- [x] ERR-20260218-PARITY-ROUTE-ALIGNMENT-P1 | API parity desalineado por rutas frontend/backend y login cliente faltante | RESUELTO
- [x] ERR-20260218-GATE-VALIDATION-RESOLVED-CONSISTENCY | Incumplimiento de gate de converters int+_id y archivos en resolved con ESTADO ABIERTO | RESUELTO
- [x] BUG-20260210-001-TEMPLATE-CLEANUP | Template cleanup in-place (employees) para eliminar inline CSS/JS legacy | RESUELTO
- [x] ERR-20260218-EMPLOYEES-ORDERS-500-CUSTOMER-EMAIL | GET /api/orders en employees falla 500 por columna customer.email inexistente | RESUELTO
- [x] BUG-20250209-005-HYBRID-SSR-VUE | Implementación de patrón híbrido SSR/Vue en employees (same-origin proxy) | RESUELTO
- [x] BUG-20250209-004-LEGACY-TEMPLATES | Consolidación de templates legacy de employees a shell SPA único | RESUELTO
- [x] ERR-20260218-EMPLOYEES-MISSING-APP-CONTEXT | Template index.html no incluye window.APP_CONTEXT para Vue app | RESUELTO
- [x] ERR-20260219-MISSING-BACKEND-ENDPOINTS | Endpoints de API no encontrados (falso positivo) | RESUELTO
- [ ] ERR-20260219-HARDCODED-HOSTS | Hosts y puertos hardcodeados impiden despliegue en produccion | N/A
- [x] ERR-20260219-EMPLOYEES-AUTH-REFRESH-MISSING | Interceptor de auth llama endpoint /api/employees/auth/refresh inexistente | RESUELTO
- [x] ERR-20260219-EMPLOYEES-REALTIME-ENDPOINTS-MISSING | Endpoints realtime de employees faltantes generan 404 | RESUELTO
- [x] ERR-20260219-EMPLOYEES-ORDER-HEAD-MISSING | Validación HEAD /api/orders/{id} en employees usa endpoint inexistente | RESUELTO

## pronto-libs
- Total: 7
- Resueltos: 7
- Pendientes: 0

- [x] ERR-20260213-LOGIN-SCOPE-403 | Login de empleados retorna 403 por validación de scope incompleta | RESUELTO
- [x] BUG-20260214-002 | Password hashing usa SHA256 con pepper estático | RESUELTO
- [x] ERR-20260218-EMPLOYEES-ORDERS-500-CUSTOMER-EMAIL | GET /api/orders en employees falla 500 por columna customer.email inexistente | RESUELTO
- [x] ERR-20260219-UUID-IMPORT-MISSING | customer_service.py usa UUID sin importarlo | RESUELTO
- [x] ERR-20260219-MENU-MAPPER-PAYMENT | /api/menu retorna 500 por mapper SQLAlchemy (Payment no resuelto) | RESUELTO
- [x] ERR-20260218-OSM-HANDLERS | OrderStateMachine handlers no cambian workflow_status | RESUELTO
- [x] ERR-20260218-MAGIC-STRINGS | Strings mágicos de estados en lugar de enums canónicos | RESUELTO

## pronto-scripts
- Total: 2
- Resueltos: 2
- Pendientes: 0

- [x] ERR-20260213-VALIDATE-SEED-SCRIPT | validate-seed.sh reporta éxito falso y apunta a contenedor incorrecto | RESUELTO
- [x] ERR-20260218-MIGR-20260218-06-NONIDEMPOTENT-INDEX | Migración 20260218_06 falla por CREATE INDEX no idempotente | RESUELTO

## pronto-client
- Total: 18
- Resueltos: 16
- Pendientes: 2

- [x] BUG-20260214-003 | /api/me no verifica revocación de customer_ref | RESUELTO
- [x] BUG-20260214-004 | auth.py usa auth_bp = api_bp (blueprint frágil) + doble import en __init__.py | RESUELTO
- [x] BUG-20260214-001 | notifications.py usa JWT (modelo incorrecto para clientes) | RESUELTO
- [x] BUG-20260214-005 | waiter_calls.py sin auth guard | RESUELTO
- [x] BUG-20260214-006 | split_bills.py sin auth guard | RESUELTO
- [x] BUG-20260214-007 | waiter_calls.py name shadowing flask.session vs SQLAlchemy session | RESUELTO
- [x] BUG-20250215-001 | Endpoints de pagos sin autenticación de cliente | RESUELTO
- [x] BUG-20250215-002 | Feedback usa JWT de empleados en lugar de customer session | RESUELTO
- [x] BUG-20260215-002 | Uso de current_app.logger en lugar de StructuredLogger | RESUELTO
- [x] BUG-20260215-003 | Archivos de backup en directorio de templates | RESUELTO
- [x] ERR-20260218-CLIENT-UUID-ROUTES-SYNTAX | Rutas API cliente desalineadas (int vs UUID) y error de sintaxis en shortcuts.py | RESUELTO
- [x] ERR-20260218-PARITY-ROUTE-ALIGNMENT-P1 | API parity desalineado por rutas frontend/backend y login cliente faltante | RESUELTO
- [x] BUG-2026-0216-003 | Bloque grande de estilos inline en index-alt.html (checkout-offers) | RESUELTO
- [x] ERR-20260218-GATE-VALIDATION-RESOLVED-CONSISTENCY | Incumplimiento de gate de converters int+_id y archivos en resolved con ESTADO ABIERTO | RESUELTO
- [x] ERR-20260219-MENU-MAPPER-PAYMENT | /api/menu retorna 500 por mapper SQLAlchemy (Payment no resuelto) | RESUELTO
- [ ] ERR-20260219-HARDCODED-HOSTS | Hosts y puertos hardcodeados impiden despliegue en produccion | N/A
- [x] ERR-20260219-HARDCODED-HOSTS | Hosts hardcodeados (falso positivo - ya usa variables de entorno) | RESUELTO
- [ ] ERR-20260219-CLIENTS-TEMPLATE-HOST-API-CALLS | Templates de cliente usan `${window.API_BASE}` en llamadas API y generan ruido parity | local-uncommitted

## pronto-docs
- Total: 1
- Resueltos: 1
- Pendientes: 0

- [x] ERR-20260218-GATE-VALIDATION-RESOLVED-CONSISTENCY | Incumplimiento de gate de converters int+_id y archivos en resolved con ESTADO ABIERTO | RESUELTO

## pronto-tests
- Total: 1
- Resueltos: 1
- Pendientes: 0

- [x] ERR-20260218-EMPLOYEES-ORDERS-500-CUSTOMER-EMAIL | GET /api/orders en employees falla 500 por columna customer.email inexistente | RESUELTO

## PRONTO-System
- Total: 1
- Resueltos: 1
- Pendientes: 0

- [x] BUG-20250209-002-BUSINESS-LOGIC-REVIEW | Revisión completa de lógica de negocio en todos los archivos Python | RESUELTO

## pronto-api
- Total: 4
- Resueltos: 4
- Pendientes: 0

- [x] ERR-20260218-MAGIC-STRINGS | Strings mágicos de estados en lugar de enums canónicos | RESUELTO
- [x] ERR-20260219-HARDCODED-HOSTS | Hosts hardcodeados (falso positivo - ya usa variables de entorno) | RESUELTO
- [x] ERR-20260218-001 | Endpoints de orders sin autenticación JWT | RESUELTO
- [x] ERR-20260218-002 | Auditoría general de pronto-api - Gate H compliance | RESUELTO

