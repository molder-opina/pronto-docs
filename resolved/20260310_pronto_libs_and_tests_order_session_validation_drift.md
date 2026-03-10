ID: LIBS-TESTS-20260310-ORDER-SESSION-VALIDATION-DRIFT
FECHA: 2026-03-10
PROYECTO: pronto-libs, pronto-tests
SEVERIDAD: media
TITULO: Validación focalizada de órdenes/sesiones reveló tests stale tras refactors recientes en libs
DESCRIPCION: Al correr una pasada focalizada de tests para órdenes/sesiones usando el wrapper estable de `pytest`, aparecieron fallos no por regresión funcional principal sino por drift entre tests y el código actual: un test de `create_client_session` seguía esperando persistencia de `table_number` ya no implementada, un test de autoridad inspeccionaba `order_service_impl.py` aunque la lógica real de `mark_order_awaiting_tip` vive en `order_delivery.py`, y un test de `move_session_to_table` parcheaba `pronto_shared.db.get_session` en vez del alias efectivo usado por `dining_session_service_impl.py`.
PASOS_REPRODUCIR:
1. Ejecutar tests focalizados de órdenes/sesiones con el wrapper estable.
2. Observar fallos en `test_dining_session_table_sync.py`, `test_order_state_authority_regressions.py` y `test_dining_session_service.py`.
3. Comparar expectativas de tests contra los módulos refactorizados actuales.
RESULTADO_ACTUAL: Corregido.
RESULTADO_ESPERADO: Los tests reflejan la arquitectura actual y el código no mantiene imports residuales inútiles.
UBICACION:
- pronto-libs/tests/unit/services/test_dining_session_table_sync.py
- pronto-libs/tests/unit/test_order_state_authority_regressions.py
- pronto-tests/tests/functionality/unit/test_dining_session_service.py
- pronto-libs/src/pronto_shared/services/order_service_impl.py
EVIDENCIA:
- `test_create_client_session_persists_table_number` asumía dos `execute()` y columna `table_number`, pero `create_client_session()` hoy hace un solo INSERT `RETURNING id, opened_at`.
- `test_order_service_uses_canonical_helper_for_awaiting_tip` buscaba `mark_order_awaiting_tip(order)` en `order_service_impl.py`, pero la llamada real está en `order_delivery.py`.
- `test_move_session_to_occupied_table_fails` parcheaba `pronto_shared.db.get_session`, mientras el módulo bajo prueba usa `get_db_session` importado localmente.
HIPOTESIS_CAUSA: Refactors válidos en `pronto-libs` movieron lógica y simplificaron flujos, pero algunos tests y un import residual quedaron apuntando a la superficie previa.
ESTADO: RESUELTO
SOLUCION:
- Se alineó `pronto-libs/tests/unit/services/test_dining_session_table_sync.py` con el comportamiento actual de `create_client_session()`, que hoy hace un único `INSERT ... RETURNING id, opened_at` y no persiste `table_number` en ese paso.
- Se alineó `pronto-libs/tests/unit/test_order_state_authority_regressions.py` al módulo real que contiene la transición a `awaiting_tip` (`order_delivery.py`) y se eliminó el import residual no usado de `mark_order_awaiting_tip` en `order_service_impl.py`.
- Se corrigió `pronto-tests/tests/functionality/unit/test_dining_session_service.py` para parchear `pronto_shared.services.dining_session_service_impl.get_db_session`, que es el alias realmente usado por el módulo bajo prueba.
- Validación ejecutada con el wrapper estable de entorno: `pronto-libs` 25 passed y `pronto-tests` 14 passed usando `.venv` de `pronto-libs` + `tmp/pytest-shim` + `PYTEST_DISABLE_PLUGIN_AUTOLOAD=1`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-10

