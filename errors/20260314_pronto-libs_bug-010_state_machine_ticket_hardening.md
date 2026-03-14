# BUG-010 pronto-libs — state machine + ticket hardening

## D0 verificación previa (EXISTE => modificar)
- Evidencia de existencia:
  - `pronto-libs/src/pronto_shared/services/order_payment_service.py`
  - `pronto-libs/src/pronto_shared/constants.py`
  - `pronto-libs/src/pronto_shared/services/order_transitions.py`
  - `pronto-libs/src/pronto_shared/services/order_metrics_service.py`
  - `pronto-libs/src/pronto_shared/models/order_models.py`
- Decisión: **modificar** implementación existente (no crear nueva).
- Justificación: los bugs provenían de flujos ya implementados con inconsistencias en transiciones/consulta SQL/serialización de ticket.

## Cambios aplicados
1. `request-check`:
- Se reemplazó SQL textual por consulta ORM canónica.
- Se evitó falla por duplicados pendientes (`.scalars().first()`).

2. Canon de transiciones:
- Se agregó transición `queued -> ready` para quick-serve (`skip_kitchen`).
- Se alinearon acciones canónicas:
  - `ready -> delivered`: `deliver`
  - `delivered -> paid`: `pay`
- Se añadieron aliases en side-effects para compatibilidad (`serve`, `complete`, `skip_kitchen`).

3. Ticket:
- Se corrigió carga de relaciones en sesión (employee/table/orders/items/modifiers).
- Se corrigió uso de precio (`unit_price` fallback) y resolución de modificadores.
- Se añadió relación `DiningSession.employee` en modelo.

## Validación
- `./pronto-scripts/bin/pronto-rules-check full` OK
- `./pronto-scripts/bin/pronto-no-legacy` OK
- `cd pronto-tests && .venv-test/bin/python -m pytest tests/functionality/e2e/test_client_api_business_logic_moved_to_api.py -q` OK
- `cd pronto-tests && .venv-test/bin/python -m pytest tests/functionality/unit/test_order_state_machine_v2.py -q` OK
