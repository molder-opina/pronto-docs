ID: LIBS-20260307-003
FECHA: 2026-03-07
PROYECTO: pronto-libs
SEVERIDAD: alta
TITULO: waiter-board usa estados legacy no canónicos y strings mágicos
DESCRIPCION:
  `waiter-board.ts` evalúa estados `requested`, `waiter_accepted`, `kitchen_in_progress`,
  `ready_for_delivery`, que no corresponden al canon P0 (`new`, `queued`, `preparing`,
  `ready`, `delivered`, `paid`, `cancelled`). Esto genera drift de UI respecto al backend.
PASOS_REPRODUCIR:
  1. Abrir `pronto-libs/src/pronto_shared/static/js/src/modules/waiter-board.ts`.
  2. Revisar condiciones sobre `order.workflow_status`.
RESULTADO_ACTUAL:
  UI acoplada a nomenclatura legacy y no al contrato canónico de estados.
RESULTADO_ESPERADO:
  Usar únicamente estados definidos en `pronto_shared/constants.py`.
UBICACION:
  - pronto-libs/src/pronto_shared/static/js/src/modules/waiter-board.ts:1291
  - pronto-libs/src/pronto_shared/static/js/src/modules/waiter-board.ts:1302
  - pronto-libs/src/pronto_shared/static/js/src/modules/waiter-board.ts:1333
  - pronto-libs/src/pronto_shared/static/js/src/modules/waiter-board.ts:1336
EVIDENCIA:
  - `order.workflow_status === 'waiter_accepted'`
  - `order.workflow_status === 'requested'`
  - `order.workflow_status === 'kitchen_in_progress'`
HIPOTESIS_CAUSA:
  Compatibilidad legacy mantenida en frontend compartido sin limpieza de contrato.
ESTADO: RESUELTO
SOLUCION:
  El `waiter-board` legacy dejó de existir dentro de `pronto-libs` al retirarse el árbol
  estático heredado; la regresión unitaria ahora bloquea la reintroducción de archivos bajo
  `src/pronto_shared/static`, evitando volver a exponer estados mágicos legacy desde ese frente.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07