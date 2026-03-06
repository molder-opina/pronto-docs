ID: AUDIT-20260303-TESTS-MASTER
FECHA: 2026-03-03
PROYECTO: pronto-tests
SEVERIDAD: baja
TITULO: Master Checklist - Auditoría Archivo por Archivo de pronto-tests

DESCRIPCION: |
  Rastreo de la auditoría detallada de la suite de pruebas en `pronto-tests`.

ESTADO: RESUELTO

CHECKLIST_AUDITORIA:
  **Configuración y Runners**
  - [x] `conftest.py` (Ok, parchado isolation parcial TEST-20260303-001)
  - [x] `playwright.config.ts` (Ok)
  - [x] `scripts/run-tests.sh` (Ok, parchado runner parcial TEST-20260303-001)
  - [x] `package.json` (Ok, reportado missing script)

  **Pruebas de Funcionalidad API (Pytest)**
  - [x] `tests/functionality/api/api-tests/test_auth_api.py` (Ok, detectadas rutas desactualizadas TEST-20260303-003)
  - [x] `tests/functionality/api/api-tests/test_business_config_api.py` (Ok)
  - [x] `tests/functionality/api/api-tests/test_employee_auth.py` (Ok, detectada falta de employee_code)
  - [x] `tests/functionality/api/api-tests/test_jwt_refresh.py` (Ok, parchadas rutas)
  - [x] `tests/functionality/api/api-tests/test_jwt_roles.py` (Ok)
  - [x] `tests/functionality/api/api-tests/test_jwt_scope_guard.py` (Ok)
  - [x] `tests/functionality/api/api-tests/test_menu_validation_api.py` (Ok)
  - [x] `tests/functionality/api/api-tests/test_recommendations_api.py` (Ok)
  - [x] `tests/functionality/api/api-tests/test_split_bill_payments.py` (Ok)
  - [x] `tests/functionality/api/analytics/test_analytics_api.py` (Ok)

  **Pruebas E2E / UI (Playwright)**
  - [x] `tests/functionality/e2e/test_login_flows.spec.ts` (Ok, excelente diseño)
  - [x] `tests/functionality/e2e/test_multi_console_navigation.spec.ts` (Ok)

ACCIONES_PENDIENTES:
  - Ninguna. Auditoría de pronto-tests completada.

SOLUCION: |
  Auditoría finalizada. La suite de pruebas es madura pero requiere una actualización masiva de las rutas de API en las pruebas de integración para reflejar el estado actual del backend.

COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-03
