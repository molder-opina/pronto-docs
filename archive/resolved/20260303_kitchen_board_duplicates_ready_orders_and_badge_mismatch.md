ID: ERR-20260303-KITCHEN-BOARD-DUPLICATES-READY-ORDERS-AND-BADGE-MISMATCH
FECHA: 2026-03-03
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: Tablero de Cocina mezcla órdenes listas en Activas y Seguimiento con badge inconsistente
DESCRIPCION: En `KitchenBoard.vue` las órdenes con estado `ready` aparecen tanto en la pestaña `Activas` como en `Seguimiento`, mientras el badge de `Activas` usa otra fuente (`newOrdersForChef`). Esto genera duplicidad visual y conteos inconsistentes en el tablero operativo de cocina.
PASOS_REPRODUCIR:
1. Entrar a `/admin/dashboard/kitchen` o `/chef/dashboard`.
2. Tener al menos una orden en estado `ready`.
3. Observar que la orden aparece en `Activas` y también en `Seguimiento`, y que el badge de `Activas` no representa la tabla visible.
RESULTADO_ACTUAL: El tablero duplica órdenes listas y muestra badges inconsistentes.
RESULTADO_ESPERADO: `Activas` debe mostrar solo órdenes en trabajo de cocina (`queued`, `preparing`) y `Seguimiento` debe concentrar las órdenes `ready`.
UBICACION: pronto-static/src/vue/employees/chef/components/KitchenBoard.vue
EVIDENCIA: Validación runtime en `/admin/dashboard/kitchen` con una orden `ready` visible en tabla y badge `Seguimiento 1`.
HIPOTESIS_CAUSA: La pestaña `active` filtra `queued`, `preparing` y `ready`, mientras `tracking` vuelve a filtrar `ready`, y el badge de `active` usa un conteo distinto al dataset mostrado.
ESTADO: RESUELTO
SOLUCION: `KitchenBoard.vue` separó explícitamente órdenes en curso (`queued`, `preparing`) de órdenes listas (`ready`). La pestaña `Activas` y su badge ahora usan el mismo dataset `inProgressKitchenOrders`, `Seguimiento` concentra `ready`, y la vista `Mesas` sigue considerando ambos grupos para no perder el contexto operativo de mesa.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03
