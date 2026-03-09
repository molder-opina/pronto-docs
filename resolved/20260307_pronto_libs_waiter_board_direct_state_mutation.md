ID: LIBS-20260307-004
FECHA: 2026-03-07
PROYECTO: pronto-libs
SEVERIDAD: alta
TITULO: waiter-board muta workflow_status/payment_status localmente en cliente
DESCRIPCION:
  `waiter-board.ts` escribía estados hardcodeados (`paid`, `delivered`, `waiter_accepted`)
  dentro de handlers de pago y realtime, generando drift de UI respecto al backend.
PASOS_REPRODUCIR:
  1. Abrir `pronto-libs/src/pronto_shared/static/js/src/modules/waiter-board.ts`.
  2. Revisar handlers de pago y eventos `sessions.paid` / `orders.auto_accepted`.
RESULTADO_ACTUAL:
  El board ya no escribe esos estados literales; ahora actualiza solo datos auxiliares
  (sesión/mesero) y, si llega estado desde el payload, usa normalización del backend.
RESULTADO_ESPERADO:
  Refrescar desde API/eventos canónicos sin hardcodear estados de negocio en frontend.
UBICACION:
  - pronto-libs/src/pronto_shared/static/js/src/modules/waiter-board.ts
  - pronto-libs/tests/unit/test_order_state_authority_regressions.py
EVIDENCIA:
  - `rg -n "payment_status\\s*=\\s*'|workflow_status\\s*=\\s*'|workflow_status_legacy\\s*=\\s*'" pronto-libs/src/pronto_shared/static/js/src/modules/waiter-board.ts` => sin matches
  - `pytest pronto-libs/tests/unit/test_order_state_authority_regressions.py -q` => `2 passed`
HIPOTESIS_CAUSA:
  Optimización de UX con actualizaciones optimistas sin guardrail de dominio.
ESTADO: RESUELTO
SOLUCION:
  Se eliminaron las mutaciones hardcodeadas de `payment_status`, `workflow_status` y
  `workflow_status_legacy`; el board conserva solo sincronización por sesión/mesero y
  usa estado proveniente del payload cuando está disponible.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07