# BUG-010 pronto-tests — flow regression hardening

## D0 verificación previa (EXISTE => modificar)
- Evidencia de existencia:
  - `pronto-tests/tests/functionality/e2e/test_client_api_business_logic_moved_to_api.py`
  - `pronto-tests/tests/functionality/ui/playwright-tests/smoke/smoke-critical.spec.ts`
  - `pronto-tests/conftest.py`
  - `pronto-tests/tests/functionality/unit/test_order_state_machine_v2.py`
- Decisión: **modificar** tests existentes.
- Justificación: los fallos eran drift de contrato y supuestos inválidos en pruebas críticas.

## Cambios aplicados
1. E2E:
- Se corrigió extracción de `questions` para aceptar lista vacía válida (sin false negatives por `or`).

2. Smoke:
- Detección de modifiers requeridos robusta (`min_required/min_select`).
- Resolución robusta de `order_id` UUID.
- Headers CSRF obligatorios en mutaciones `/api/orders` y pagos.
- Flujo de transición dinámico por estado actual.
- Ticket step con fallback PDF -> ticket texto.

3. Conftest:
- Se endureció validación de columnas críticas reales (sin exigir columna inexistente en schema canónico).

## Validación
- `cd pronto-tests && .venv-test/bin/python -m pytest tests/functionality/e2e/test_client_api_business_logic_moved_to_api.py -q` OK
- `cd pronto-tests && .venv-test/bin/python -m pytest tests/functionality/unit/test_order_state_machine_v2.py -q` OK
- `cd pronto-tests && SMOKE_TABLE_ID=<active_table_uuid> npx playwright test tests/functionality/ui/playwright-tests/smoke/smoke-critical.spec.ts` OK
