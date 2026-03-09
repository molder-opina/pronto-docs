ID: LIBS-20260307-002
FECHA: 2026-03-07
PROYECTO: pronto-libs
SEVERIDAD: alta
TITULO: order_service_impl modifica payment_status fuera de autoridad canónica
DESCRIPCION:
  `order_service_impl.py` asignaba `order.payment_status` directamente al completar
  la entrega total, fuera del servicio canónico de estados/pago.
PASOS_REPRODUCIR:
  1. Abrir `pronto-libs/src/pronto_shared/services/order_service_impl.py`.
  2. Revisar el flujo de entrega total de items.
RESULTADO_ACTUAL:
  El flujo usa `mark_order_awaiting_tip(order)` en lugar de una escritura directa.
RESULTADO_ESPERADO:
  Encapsular transición de pago/checkout en helper canónico del state authority.
UBICACION:
  - pronto-libs/src/pronto_shared/services/order_service_impl.py
  - pronto-libs/tests/unit/test_order_state_authority_regressions.py
EVIDENCIA:
  - `mark_order_awaiting_tip(order)` presente en `order_service_impl.py`
  - `pytest pronto-libs/tests/unit/test_order_state_authority_regressions.py -q` => `2 passed`
HIPOTESIS_CAUSA:
  Parche temporal para cubrir entrega total antes de consolidar helper específico.
ESTADO: RESUELTO
SOLUCION:
  Se importó y aplicó `mark_order_awaiting_tip(order)` en el flujo de entrega total,
  eliminando la escritura directa a `order.payment_status`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07