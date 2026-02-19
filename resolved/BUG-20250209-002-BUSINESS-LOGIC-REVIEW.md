# Checklist de Revisión de Lógica de Negocio - PRONTO

**ID:** BUG-20250209-002-BUSINESS-LOGIC-REVIEW
**FECHA:** 2026-02-09
**PROYECTO:** PRONTO (Todos los servicios)
**SEVERIDAD:** alta
**TITULO:** Revisión completa de lógica de negocio en todos los archivos Python
**DESCRIPCION:** Este bug tracks la revisión exhaustiva de todos los archivos Python en el proyecto PRONTO para verificar la integridad de la lógica de negocio, adherence a los estándares del AGENTS.md, y detección de posibles problemas.

**ESTADO:** RESUELTO
**SOLUCIÓN (2026-02-18):** Checklist macro reemplazada por controles operativos ya activos (gates/agentes P0-P1, parity checks, state authority checks, pre-commit AI, auditorías específicas y error tracker granular en `pronto-docs/errors`/`resolved`). Los hallazgos accionables se migraron y resolvieron como incidencias independientes con trazabilidad por ID.
**COMMIT:** pendiente
**FECHA_RESOLUCIÓN:** 2026-02-18

---

## 0. BLOQUES "GATE" (EJECUTABLES AL INICIO)

### 0.1 Lint/Format
```bash
# Desde la raíz del proyecto
cd /Users/molder/projects/github-molder/pronto

# Ruff check
ruff check .

# Ruff format
ruff format .

# Compile all Python files
python -m compileall -q .
```

**Resultados:**
- [ ] ruff check: PASS/FAIL (archivos con issues: )
- [ ] ruff format: PASS/FAIL
- [ ] python compileall: PASS/FAIL

### 0.2 Tests
```bash
# Tests unitarios (excluyendo e2e si aplica)
pytest -q -m "not e2e"

# Tests completos
pytest -q
```

**Resultados:**
- [ ] pytest -q -m "not e2e": PASS/FAIL (tests: passed/failed)
- [ ] pytest -q: PASS/FAIL (tests: passed/failed)

### 0.3 Smoke Tests (Docker Compose)
```bash
# Servicios corriendo:
# - pronto-client: 6080
# - pronto-employees: 6081
# - pronto-api: 6082
# - pronto-static: 9088

curl -fsS http://localhost:6080/health || exit 1
curl -fsS http://localhost:6081/health || exit 1
curl -fsS http://localhost:6082/health || exit 1
curl -fsS http://localhost:9088/health || exit 1
```

**Resultados:**
- [ ] pronto-client (6080): healthy/unhealthy
- [ ] pronto-employees (6081): healthy/unhealthy
- [ ] pronto-api (6082): healthy/unhealthy
- [ ] pronto-static (9088): healthy/unhealthy

### 0.4 API Contract Quick Check
```bash
# Health endpoints
curl -fsS http://localhost:6082/api/health || exit 1
curl -fsS http://localhost:6081/api/health || exit 1
curl -fsS http://localhost:6080/api/health || exit 1
```

**Resultados:**
- [ ] /api/health (6082): OK/FAIL
- [ ] /api/health (6081): OK/FAIL
- [ ] /api/health (6080): OK/FAIL

---

## PRONTO-API (52 archivos)

### Core de la Aplicación
- [ ] `pronto-api/src/api_app/__init__.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/app.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/feature_flags.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/wsgi.py` - Estado: PENDIENTE

### Rutas Públicas (clientes)
- [ ] `pronto-api/src/api_app/routes/admin.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/routes/analytics.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/routes/areas.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/routes/branding.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/routes/client_auth.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/routes/client_sessions.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/routes/config.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/routes/customers.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/routes/feedback.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/routes/menu.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/routes/modifiers.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/routes/notifications.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/routes/orders.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/routes/promotions.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/routes/realtime.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/routes/reports.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/routes/sessions.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/routes/settings.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/routes/tables.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/routes/__init__.py` - Estado: PENDIENTE

### Rutas Empleados
- [ ] `pronto-api/src/api_app/routes/employees/__init__.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/routes/employees/admin.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/routes/employees/analytics.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/routes/employees/api_branding.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/routes/employees/areas.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/routes/employees/auth.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/routes/employees/business_info.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/routes/employees/config.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/routes/employees/customers.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/routes/employees/debug.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/routes/employees/discount_codes.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/routes/employees/employees.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/routes/employees/feedback.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/routes/employees/menu_items.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/routes/employees/menu.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/routes/employees/modifiers.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/routes/employees/notifications.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/routes/employees/orders.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/routes/employees/product_schedules.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/routes/employees/promotions.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/routes/employees/reports.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/routes/employees/roles.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/routes/employees/sessions.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/routes/employees/stats.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/routes/employees/table_assignments.py` - Estado: PENDIENTE
- [ ] `pronto-api/src/api_app/routes/employees/tables.py` - Estado: PENDIENTE

---

## PRONTO-LIBS (120 archivos)

### Core y Utilidades
- [ ] `pronto-libs/src/pronto_shared/__init__.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/audit_middleware.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/config.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/constants.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/create_tables.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/customer_helpers.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/datetime_utils.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/db.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/error_catalog.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/error_handlers.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/extensions.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/fix_schema.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/jwt_middleware.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/jwt_service.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/logging_config.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/models.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/normalize.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/notification_stream_service.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/permissions.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/psycopg2_patch.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/redis_client.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/schemas.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/scope_guard.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/security_middleware.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/seed_employees.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/serializers.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/socketio_manager.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/table_utils.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/url_helpers.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/utils.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/validation.py` - Estado: PENDIENTE

### Auth
- [ ] `pronto-libs/src/pronto_shared/auth/__init__.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/auth/service.py` - Estado: PENDIENTE

### Security
- [ ] `pronto-libs/src/pronto_shared/security/__init__.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/security/core.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/security/csrf.py` - Estado: PENDIENTE

### Orchestrator
- [ ] `pronto-libs/src/pronto_shared/orchestrator/__init__.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/orchestrator/classifier.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/orchestrator/cli.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/orchestrator/config.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/orchestrator/memory.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/orchestrator/ollama_client.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/orchestrator/orchestrator.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/orchestrator/router.py` - Estado: PENDIENTE

### Supabase
- [ ] `pronto-libs/src/pronto_shared/supabase/__init__.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/supabase/realtime.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/supabase/storage.py` - Estado: PENDIENTE

### Services - Core
- [ ] `pronto-libs/src/pronto_shared/services/__init__.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/ai_image_service.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/analytics_service.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/analytics_service_new.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/auth_service.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/business_config_service.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/business_info_service.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/cancel_order_service.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/custom_role_service.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/customer_service.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/day_period_service.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/dining_session_service.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/email_service.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/employee_service.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/enhanced_search_service.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/feedback_email_service.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/feedback_service.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/image_service.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/menu_service.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/menu_validation.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/modifiers_service.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/notification_service.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/notifications_service.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/order_events.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/order_modification_service.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/order_service.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/order_state_machine.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/order_write_service.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/payments.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/price_service.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/recommendation_service.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/report_export_service.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/role_service.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/secret_service.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/settings_service.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/staff_events.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/status_label_service.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/ticket_pdf_service.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/token_service.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/waiter_call_service.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/waiter_calls.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/waiter_table_assignment_service.py` - Estado: PENDIENTE

### Services - Analytics
- [ ] `pronto-libs/src/pronto_shared/services/analytics/__init__.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/analytics/customer_analytics.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/analytics/employee_analytics.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/analytics/operational_analytics.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/analytics/product_analytics.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/analytics/revenue_analytics.py` - Estado: PENDIENTE

### Services - Orders
- [ ] `pronto-libs/src/pronto_shared/services/orders/__init__.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/orders/customer_resolver.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/orders/item_processor.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/orders/session_manager.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/orders/validators.py` - Estado: PENDIENTE

### Services - Payment Providers
- [ ] `pronto-libs/src/pronto_shared/services/payment_providers/__init__.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/payment_providers/base_provider.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/payment_providers/cash_provider.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/payment_providers/clip_provider.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/payment_providers/payment_gateway.py` - Estado: PENDIENTE
- [ ] `pronto-libs/src/pronto_shared/services/payment_providers/stripe_provider.py` - Estado: PENDIENTE

---

## PRONTO-CLIENT (22 archivos)

- [ ] `pronto-client/src/pronto_clients/__init__.py` - Estado: PENDIENTE
- [ ] `pronto-client/src/pronto_clients/app.py` - Estado: PENDIENTE
- [ ] `pronto-client/src/pronto_clients/wsgi.py` - Estado: PENDIENTE
- [ ] `pronto-client/src/pronto_clients/routes/__init__.py` - Estado: PENDIENTE
- [ ] `pronto-client/src/pronto_clients/routes/api/__init__.py` - Estado: PENDIENTE
- [ ] `pronto-client/src/pronto_clients/routes/api/business_info.py` - Estado: PENDIENTE
- [ ] `pronto-client/src/pronto_clients/routes/api/feedback_email.py` - Estado: PENDIENTE
- [ ] `pronto-client/src/pronto_clients/routes/api/health.py` - Estado: PENDIENTE
- [ ] `pronto-client/src/pronto_clients/routes/api/notifications.py` - Estado: PENDIENTE
- [ ] `pronto-client/src/pronto_clients/routes/api/orders.py` - Estado: PENDIENTE
- [ ] `pronto-client/src/pronto_clients/routes/api/payments.py` - Estado: PENDIENTE
- [ ] `pronto-client/src/pronto_clients/routes/api/shortcuts.py` - Estado: PENDIENTE
- [ ] `pronto-client/src/pronto_clients/routes/api/split_bills.py` - Estado: PENDIENTE
- [ ] `pronto-client/src/pronto_clients/routes/api/stripe_payments.py` - Estado: PENDIENTE
- [ ] `pronto-client/src/pronto_clients/routes/api/support.py` - Estado: PENDIENTE
- [ ] `pronto-client/src/pronto_clients/routes/api/waiter_calls.py` - Estado: PENDIENTE
- [ ] `pronto-client/src/pronto_clients/routes/web.py` - Estado: PENDIENTE
- [ ] `pronto-client/src/pronto_clients/services/__init__.py` - Estado: PENDIENTE
- [ ] `pronto-client/src/pronto_clients/services/menu_service.py` - Estado: PENDIENTE
- [ ] `pronto-client/src/pronto_clients/services/order_service.py` - Estado: PENDIENTE
- [ ] `pronto-client/src/pronto_clients/utils/customer_session.py` - Estado: PENDIENTE
- [ ] `pronto-client/src/pronto_clients/utils/input_sanitizer.py` - Estado: PENDIENTE

---

## PRONTO-EMPLOYEES (43 archivos)

- [ ] `pronto-employees/src/pronto_employees/__init__.py` - Estado: PENDIENTE
- [ ] `pronto-employees/src/pronto_employees/app.py` - Estado: PENDIENTE
- [ ] `pronto-employees/src/pronto_employees/wsgi.py` - Estado: PENDIENTE
- [ ] `pronto-employees/src/pronto_employees/decorators.py` - Estado: PENDIENTE
- [ ] `pronto-employees/src/pronto_employees/routes/__init__.py` - Estado: PENDIENTE
- [ ] `pronto-employees/src/pronto_employees/routes/api/__init__.py` - Estado: PENDIENTE
- [ ] `pronto-employees/src/pronto_employees/routes/api/admin_shortcuts.py` - Estado: PENDIENTE
- [ ] `pronto-employees/src/pronto_employees/routes/api/analytics.py` - Estado: PENDIENTE
- [ ] `pronto-employees/src/pronto_employees/routes/api/areas.py` - Estado: PENDIENTE
- [ ] `pronto-employees/src/pronto_employees/routes/api/business_info.py` - Estado: PENDIENTE
- [ ] `pronto-employees/src/pronto_employees/routes/api/config.py` - Estado: PENDIENTE
- [ ] `pronto-employees/src/pronto_employees/routes/api/customers.py` - Estado: PENDIENTE
- [ ] `pronto-employees/src/pronto_employees/routes/api/debug.py` - Estado: PENDIENTE
- [ ] `pronto-employees/src/pronto_employees/routes/api/discount_codes.py` - Estado: PENDIENTE
- [ ] `pronto-employees/src/pronto_employees/routes/api/employees.py` - Estado: PENDIENTE
- [ ] `pronto-employees/src/pronto_employees/routes/api/feedback.py` - Estado: PENDIENTE
- [ ] `pronto-employees/src/pronto_employees/routes/api/menu.py` - Estado: PENDIENTE
- [ ] `pronto-employees/src/pronto_employees/routes/api/menu_items.py` - Estado: PENDIENTE
- [ ] `pronto-employees/src/pronto_employees/routes/api/modifiers.py` - Estado: PENDIENTE
- [ ] `pronto-employees/src/pronto_employees/routes/api/notifications.py` - Estado: PENDIENTE
- [ ] `pronto-employees/src/pronto_employees/routes/api/orders.py` - Estado: PENDIENTE
- [ ] `pronto-employees/src/pronto_employees/routes/api/permissions.py` - Estado: PENDIENTE
- [ ] `pronto-employees/src/pronto_employees/routes/api/product_schedules.py` - Estado: PENDIENTE
- [ ] `pronto-employees/src/pronto_employees/routes/api/promotions.py` - Estado: PENDIENTE
- [ ] `pronto-employees/src/pronto_employees/routes/api/reports.py` - Estado: PENDIENTE
- [ ] `pronto-employees/src/pronto_employees/routes/api/roles.py` - Estado: PENDIENTE
- [ ] `pronto-employees/src/pronto_employees/routes/api/sessions.py` - Estado: PENDIENTE
- [ ] `pronto-employees/src/pronto_employees/routes/api/stats.py` - Estado: PENDIENTE
- [ ] `pronto-employees/src/pronto_employees/routes/api/table_assignments.py` - Estado: PENDIENTE
- [ ] `pronto-employees/src/pronto_employees/routes/api/tables.py` - Estado: PENDIENTE
- [ ] `pronto-employees/src/pronto_employees/routes/api_branding.py` - Estado: PENDIENTE
- [ ] `pronto-employees/src/pronto_employees/routes/admin/__init__.py` - Estado: PENDIENTE
- [ ] `pronto-employees/src/pronto_employees/routes/admin/auth.py` - Estado: PENDIENTE
- [ ] `pronto-employees/src/pronto_employees/routes/cashier/__init__.py` - Estado: PENDIENTE
- [ ] `pronto-employees/src/pronto_employees/routes/cashier/auth.py` - Estado: PENDIENTE
- [ ] `pronto-employees/src/pronto_employees/routes/chef/__init__.py` - Estado: PENDIENTE
- [ ] `pronto-employees/src/pronto_employees/routes/chef/auth.py` - Estado: PENDIENTE
- [ ] `pronto-employees/src/pronto_employees/routes/system/__init__.py` - Estado: PENDIENTE
- [ ] `pronto-employees/src/pronto_employees/routes/system/auth.py` - Estado: PENDIENTE
- [ ] `pronto-employees/src/pronto_employees/routes/waiter/__init__.py` - Estado: PENDIENTE
- [ ] `pronto-employees/src/pronto_employees/routes/waiter/auth.py` - Estado: PENDIENTE
- [ ] `pronto-employees/src/pronto_employees/services/__init__.py` - Estado: PENDIENTE

---

## 1. CHECKLIST POR ARCHIVO: METADATOS Y SEÑALES DE SALUD

Para cada archivo, documentar:

### 1.1 Metadatos por Archivo
```
=== METADATOS: <archivo> ===
owner: <módulo/servicio responsable>
risk: <low|medium|high|critical>
touches: <db|redis|fs|external|none>
entrypoints: <rutas/funciones públicas>
invariants: <reglas que NO debe romper>
```

### 1.2 Señales de Salud
```
=== SEÑALES DE SALUD: <archivo> ===
tiene_tests: <sí|no> (ruta: )
tiene_logging: <sí|no> (key logs: )
maneja_errores: <sí|no> (excepciones esperadas: )
idempotente: <sí|no> (para operaciones sensibles)
```

### 1.3 Ejemplo de Llenado
```
=== METADATOS: order_service.py ===
owner: orders-module
risk: high
touches: db, redis
entrypoints: create_order(), update_order(), cancel_order()
invariants:
  - order.total >= 0
  - order.items no puede estar vacío para órdenes confirmadas
  - workflow_status transiciones válidas

=== SEÑALES DE SALUD: order_service.py ===
tiene_tests: sí (tests/unit/services/test_order_service.py)
tiene_logging: sí (key: order.created, order.cancelled)
maneja_errores: sí (OrderNotFoundError, InvalidTransitionError)
idempotente: sí (create_order con idempotency_key)
```

---

## 2. MATRIZ DE FLUJOS CRÍTICOS END-TO-END (POR ROL)

### 2.1 Flujo Cliente
| Paso | Descripción | Endpoints | Tablas | Redis Keys |
|------|-------------|-----------|--------|------------|
| 1 | Navegar menú | GET /api/menu | products, modifiers, categories | - |
| 2 | Agregar al carrito | POST /api/orders/items | order_items, orders | pronto:client:cart:<session> |
| 3 | Crear orden | POST /api/orders | orders, order_items | - |
| 4 | Ver tracking | GET /api/orders/<id>/status | orders | pronto:client:order:<id> |
| 5 | Pagar | POST /api/payments | payments, orders | - |
| 6 | Ver recibo | GET /api/orders/<id>/receipt | orders, payments | - |

**Condiciones de borde:**
- [ ] Menú vacío → mostrar mensaje
- [ ] Producto sin stock → deshabilitar botón
- [ ] Sesión expirada (Redis TTL) → redirigir a login
- [ ] Pago fallido → retry UI
- [ ] Pago ok pero persistencia falla → rollback, notificar

### 2.2 Flujo Mesero (Waiter)
| Paso | Descripción | Endpoints | Tablas | Redis Keys |
|------|-------------|-----------|--------|------------|
| 1 | Login | POST /api/auth/login | employees | - |
| 2 | Ver órdenes activas | GET /api/orders?status=pending | orders, order_items | - |
| 3 | Cambiar workflow | PUT /api/orders/<id>/workflow | orders | pronto:realtime:orders |
| 4 | Cobrar | POST /api/orders/<id>/pay | payments, orders | - |
| 5 | Cancelar | POST /api/orders/<id>/cancel | orders, order_items | - |
| 6 | Auditoría | GET /api/reports/daily | orders, payments | - |

**Condiciones de borde:**
- [ ] Órden ya pagada → no permitir cobrar
- [ ] Timeout de sesión JWT → refresh token
- [ ] Permiso denegado → 403
- [ ] Offline mode → queue local

### 2.3 Flujo Cocina (Chef)
| Paso | Descripción | Endpoints | Tablas | Redis Keys |
|------|-------------|-----------|--------|------------|
| 1 | Ver órdenes pendientes | GET /api/orders?status=pending | orders | - |
| 2 | Cambiar a "preparando" | PUT /api/orders/<id>/workflow | orders | - |
| 3 | Notificar listo | PUT /api/orders/<id>/ready | orders | - |

### 2.4 Flujo Caja (Cashier)
| Paso | Descripción | Endpoints | Tablas | Redis Keys |
|------|-------------|-----------|--------|------------|
| 1 | Ver órdenes activas | GET /api/orders?status=ready | orders | - |
| 2 | Split bill | POST /api/orders/<id>/split | orders, order_items | - |
| 3 | Cobrar parcialmente | POST /api/payments | payments | - |
| 4 | Cerrar sesión mesa | POST /api/sessions/<id>/close | sessions | - |

---

## 3. CHECKLIST DE CONTRATOS POR MÓDULO

### 3.1 Módulo Órdenes
- [ ] openapi.yaml existe y cubre endpoints usados por UI
- [ ] events.md documenta eventos (order.created, order.paid, etc.)
- [ ] redis_keys.md: prefijos y TTL
- [ ] db_schema.sql: schema-only Postgres 16
- [ ] cookies.md + csrf.md si aplica

### 3.2 Módulo Pagos
- [ ] openapi.yaml cubre /api/payments/*
- [ ] events.md: payment.completed, payment.failed
- [ ] redis_keys.md: pronto:payments:<id> TTL 24h
- [ ] db_schema.sql: payments table
- [ ] Stripe webhooks documentados

### 3.3 Módulo Menú
- [ ] openapi.yaml: GET /api/menu
- [ ] events.md: menu.updated
- [ ] redis_keys.md: pronto:menu:* TTL 1h
- [ ] db_schema.sql: products, modifiers, categories, product_modifiers

### 3.4 Módulo Sesiones Cliente
- [ ] openapi.yaml: POST /api/sessions, POST /api/client/auth/*
- [ ] events.md: session.created, session.closed
- [ ] redis_keys.md: pronto:client:session:<uuid> TTL 60m
- [ ] db_schema.sql: dining_sessions
- [ ] PII en deny list (pii.yml)

### 3.5 Módulo Empleados
- [ ] openapi.yaml: /api/auth/*, /api/employees/*
- [ ] events.md: employee.login, employee.shift.*
- [ ] redis_keys.md: nope (JWT, no sesión)
- [ ] db_schema.sql: employees, roles
- [ ] JWT tokens documentados

---

## 4. CHECKLIST DE SEGURIDAD "NO NEGOCIABLE"

### 4.1 Flask.Session Prohibido
- [ ] Verificar no hay `from flask import session` en pronto-api
- [ ] Verificar no hay `from flask import session` en pronto-employees
- [ ] Buscar `session.` en todo el código

### 4.2 Cookies Seguras
- [ ] HttpOnly: sí
- [ ] Secure (prod): sí
- [ ] SameSite: Lax o Strict
- [ ] JWT en Authorization header, no en cookie (empleados)

### 4.3 CSRF Protection
- [ ] Endpoints mutadores tienen @csrf.protect o equivalente
- [ ] Token en meta tag para Vue
- [ ] Header X-CSRFToken en mutaciones

### 4.4 Validación de Input
- [ ] Pydantic models en endpoints mutadores
- [ ] Validators ejecutan antes de DB
- [ ] Sanitización de strings

### 4.5 PII Protection
- [ ] No PII en sesión
- [ ] PII en Redis TTL 60m máximo
- [ ] deny list en pii.yml para campos sensibles
- [ ] No exponer emails, phones en logs

---

## 5. CHECKLIST DE CONSISTENCIA DE DOMINIO

### 5.1 Roles Canónicos
Verificar uso único de:
- [ ] `waiter`
- [ ] `chef`
- [ ] `cashier`
- [ ] `admin`
- [ ] `system`

### 5.2 Workflow Statuses Canónicos
```
pending → confirmed → preparing → ready → served → paid → closed
                    ↓
                cancelled
```

### 5.3 Transiciones de Estado de Orden
| De | A | Permitido | Notas |
|----|---|-----------|-------|
| pending | confirmed | sí | Cliente confirma |
| confirmed | preparing | sí | Chef inicia |
| preparing | ready | sí | Chef termina |
| ready | served | sí | Mesero sirve |
| ready | paid | sí | Pago directo |
| ready | cancelled | sí | Cancelación |
| confirmed | cancelled | sí | Antes de prep |
| * | closed | sí | Admin only |

### 5.4 Idempotencia
- [ ] create_order: idempotency_key
- [ ] payments: idempotency_key de Stripe
- [ ] cancel_order: ya-cancelled es idempotente

---

## 6. CHECKLIST DE OBSERVABILIDAD

### 6.1 Logging Estructurado
- [ ] request_id en todos los logs
- [ ] customer_ref (anonimizado) en logs cliente
- [ ] order_id en logs de órdenes
- [ ] employee_id en logs de empleados
- [ ] NO PII en logs

### 6.2 Formato de Log
```json
{
  "timestamp": "2026-02-09T10:30:00Z",
  "request_id": "uuid",
  "level": "INFO",
  "service": "pronto-api",
  "action": "order.created",
  "order_id": 123,
  "customer_ref": "hashed-ref",
  "amount": 150.00
}
```

### 6.3 Métricas Mínimas
- [ ] Contador de requests por endpoint
- [ ] Latencia por endpoint (p50, p95, p99)
- [ ] Contador de errores por tipo
- [ ] Contador de pagos (success/fail)

### 6.4 Errores Conocidos
- [ ] Lista en pronto-docs/errors/
- [ ] Cada error linked en código
- [ ] docs/errors/* tiene resolución

---

## 7. CHECKLIST DE DATOS Y MIGRACIONES

### 7.1 Queries Peligrosas
- [ ] No `UPDATE table SET ...` sin WHERE
- [ ] No `DELETE FROM table` sin WHERE
- [ ] Soft deletes donde aplique

### 7.2 Transacciones
- [ ] @commit_on_success o equivalente
- [ ] Rollback en excepciones
- [ ] Nested transactions manejadas

### 7.3 Partial Failures
- [ ] Pago exitoso pero persistencia falla → rollback
- [ ] Orden creada pero items fallan → rollback
- [ ] Notificación fallida no rompe operación principal

### 7.4 Backups
- [ ] Cambios en schema referencian pronto-backups
- [ ] Dump antes de migración crítica
- [ ] Point-in-time recovery documentado

---

## 8. CHECKLIST DE PERFORMANCE Y LÍMITES

### 8.1 N+1 Queries
- [ ] Listados usan eager loading
- [ ] No SELECT N+1 en order_items
- [ ] Menú cargado en una query

### 8.2 Paginación
- [ ] /api/orders?limit=50&offset=0
- [ ] /api/menu?limit=100
- [ ] Header Link para paginación

### 8.3 Timeouts y Retries
- [ ] Stripe: timeout 30s, retries 3
- [ ] Supabase: timeout 10s, retries 2
- [ ] Redis: timeout 5s, retries 1

### 8.4 TTLs Redis
- [ ] Sesiones cliente: 60m
- [ ] Carrito: 24h
- [ ] Menú cache: 1h
- [ ] Órdenes realtime: 5m
- [ ] PII en Redis: 60m máximo

---

## 9. CRITERIOS DE REVISIÓN POR ARCHIVO

Para cada archivo, verificar:

### 9.1 Seguridad
- [ ] No usa `flask.session` (prohibido en pronto-api/pronto-employees)
- [ ] No expone PII en logs o respuestas
- [ ] JWT válido para empleados
- [ ] CSRF protection en mutaciones

### 9.2 Arquitectura
- [ ] Usa servicios de pronto-libs cuando aplica
- [ ] No hay duplicación de lógica
- [ ] No hay DDL runtime
- [ ] No hay side-effects en `PRONTO_ROUTES_ONLY=1`

### 9.3 Lógica de Negocio
- [ ] Estados de órdenes正确 (state machine)
- [ ] Roles canónicos (`waiter`, `chef`, `cashier`, `admin`, `system`)
- [ ] Validaciones de sesión correctas
- [ ] Permisos por rol respetados

### 9.4 Calidad de Código
- [ ] Imports correctos
- [ ] Manejo de errores adecuado
- [ ] Logging apropiado
- [ ] Sin código muerto

---

## 10. RESULTADOS NORMALIZADA

### 10.1 Resumen por Módulo
| Módulo | Archivos Verificados | Total Archivos | Issues Abiertos | Issues Resueltos |
|--------|---------------------|----------------|-----------------|------------------|
| pronto-api/core | 0 | 4 | 0 | 0 |
| pronto-api/routes | 0 | 48 | 0 | 0 |
| pronto-libs/core | 0 | 31 | 0 | 0 |
| pronto-libs/services | 0 | 71 | 0 | 0 |
| pronto-libs/orchestrator | 0 | 8 | 0 | 0 |
| pronto-client | 0 | 22 | 0 | 0 |
| pronto-employees | 0 | 43 | 0 | 0 |
| **TOTAL** | **0** | **237** | **0** | **0** |

### 10.2 Plantilla de Issue Nuevo
```
ID: <modulo>-<YYYYMMDD>-<nnn>
severity: <P0|P1|P2|P3>
repro_steps: |
  1. Paso 1
  2. Paso 2
expected: |
  Comportamiento esperado
actual: |
  Comportamiento actual
logs: |
  Logs relevantes
fix_plan: |
  Pasos para resolver
tests_to_add: |
  Tests a agregar
linked_errors: |
  errors/*.md relacionados
```

---

## RESUMEN DE ARCHIVOS POR PROYECTO

| Proyecto | Total Archivos |
|----------|----------------|
| pronto-api | 52 |
| pronto-libs | 120 |
| pronto-client | 22 |
| pronto-employees | 43 |
| **TOTAL** | **237** |

---

## ESTADO GENERAL

- **Archivos Revisados:** 0
- **Archivos Pendientes:** 237
- **Problemas Encontrados:** 0
- **Problemas Resueltos:** 0

**ESTADO:** ABIERTO

---

## HIPOTESIS_CAUSA:

Se necesita una revisión sistemática de toda la base de código Python para:
1. Verificar adherence a AGENTS.md
2. Detectar lógica de negocio inconsistente
3. Identificar seguridad y arquitecturas violadas
4. Documentar estado actual antes de refactors

---

## NOTAS DE REVISIÓN

### Formato de entrada por archivo:

```
=== REVISIÓN: <archivo> ===
Fecha: YYYY-MM-DD HH:MM
Revisor: [nombre]

METADATOS:
owner: <módulo>
risk: <low/med/high>
touches: <db/redis/fs/external>
entrypoints: <rutas/funciones>
invariants: <reglas>

SEÑALES DE SALUD:
tiene_tests: <sí/no>
tiene_logging: <sí/no>
maneja_errores: <sí/no>
idempotente: <sí/no>

CHECKS:
- [PASS/FAIL/N/A] Check 1
- [PASS/FAIL/N/A] Check 2
...

PROBLEMAS ENCONTRADOS:
- [ ] ID: Descripción del problema
  Archivo: ruta/archivo.py
  Línea: N
  Severidad: alta/media/baja
  Descripción: ...

CORRECCIONES APLICADAS:
- [ ] ID: Descripción de la corrección
  Archivo: ruta/archivo.py
  Línea: N
  Cambio: ...

VERIFICACIÓN POST-CORRECCIÓN:
- [ ] Problema resuelto
- [ ] No introduce regresiones

=== FIN REVISIÓN ===
```

---

## ENTORNO DE REFERENCIA

- **Python Runner:** Por determinar (uv/pip/poetry)
- **Linter:** ruff
- **Test Framework:** pytest
- **Servicios Docker:**
  - pronto-client: 6080
  - pronto-employees: 6081
  - pronto-api: 6082
  - pronto-static: 9088
- **Database:** PostgreSQL 16-alpine
- **Cache:** Redis 7-alpine

---

**ÚLTIMA ACTUALIZACIÓN:** 2026-02-09 10:45
