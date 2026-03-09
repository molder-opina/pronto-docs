ID: TEST-20260306-050
FECHA: 2026-03-06
PROYECTO: pronto-libs,pronto-tests
SEVERIDAD: media
TITULO: cancel_order falla por import faltante de mark_order_cancelled
DESCRIPCION:
  Al activar el último skip unitario, `cancel_order` falló con `NameError` porque `_apply_transition_side_effects()`
  llamaba `mark_order_cancelled(order)` sin importar esa función desde el state machine canónico.
ESTADO: RESUELTO
SOLUCION:
  `order_service_impl.py` ahora importa `mark_order_cancelled` desde `pronto_shared.services.order_state_machine`.
  Validación: `test_order_state_machine_v2.py` => `8 passed`; suite completa `pronto-tests/tests` =>
  `312 passed, 4 skipped`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06
