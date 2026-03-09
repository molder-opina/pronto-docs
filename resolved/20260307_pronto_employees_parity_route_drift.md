ID: EMP-20260307-010
FECHA: 2026-03-07
PROYECTO: pronto-static
SEVERIDAD: alta
TITULO: frontend employees usa rutas de cocina/pago que no existen en el backend canónico
DESCRIPCION:
  El frontend de employees referenciaba rutas inexistentes o drifted respecto a `pronto-api`.
  En particular usaba `kitchen/start`, `kitchen/ready` y `orders/{id}/request-payment`
  cuando el backend canónico expone `kitchen-start`, `kitchen-ready` y flujos de pago
  a nivel de sesión.
PASOS_REPRODUCIR:
  1. Ejecutar `./pronto-scripts/bin/pronto-api-parity-check employees`.
  2. Observar faltantes en `PaymentOptionsModal.vue`, `KDSBoard.vue`, `KitchenBoard.vue`
     y constantes legacy de waiter.
RESULTADO_ACTUAL:
  El parity check de employees falla por referencias a endpoints inexistentes.
RESULTADO_ESPERADO:
  El frontend employees debe consumir únicamente rutas reales expuestas por `pronto-api`.
UBICACION:
  - `pronto-static/src/vue/employees/shared/components/PaymentOptionsModal.vue`
  - `pronto-static/src/vue/employees/chef/components/KDSBoard.vue`
  - `pronto-static/src/vue/employees/chef/components/KitchenBoard.vue`
  - `pronto-static/src/vue/employees/waiter/modules/waiter/legacy/constants.ts`
EVIDENCIA:
  - `POST /api/orders/{var}/request-payment`
  - `/api/orders/{var}/kitchen/start`
  - `/api/orders/{var}/kitchen/ready`
HIPOTESIS_CAUSA:
  Drift entre nombres legacy de acciones frontend y endpoints canónicos del backend.
ESTADO: RESUELTO
SOLUCION:
  Se alineó el frontend employees a las rutas reales del backend:
  `kitchen-start`, `kitchen-ready` y `POST /api/sessions/{sessionId}/checkout`
  para el flujo de cobro solicitado por sesión.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07

