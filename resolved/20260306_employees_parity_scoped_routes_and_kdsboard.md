ID: OPS-20260306-002
FECHA: 2026-03-06
PROYECTO: pronto-scripts, pronto-static, pronto-employees
SEVERIDAD: alta
TITULO: Parity de employees ignora rutas scopeadas del proxy y KDSBoard llama método inexistente
DESCRIPCION:
  El checker `pronto-api-parity-check employees` sigue reportando ruido sobre
  `/api/orders/{id}/kitchen/start`, `/api/orders/{id}/kitchen/ready` y
  `/api/orders/{id}/request-payment` por dos causas acopladas: (1) la introspección
  de backend ignora las rutas scopeadas `/{scope}/api/*` de `pronto-employees` aunque
  el wrapper oficial de employees las usa como proxy técnico temporal; y (2) el scanner
  de frontend pierde contexto cuando `requestJSON(` está en la línea anterior al literal
  `/api/*`, degradando el método a `UNKNOWN`. En paralelo, `KDSBoard.vue` invoca
  `ordersStore.updateOrderStatus(...)`, pero el store solo expone
  `processWorkflowAction(...)`.
PASOS_REPRODUCIR:
  1. Ejecutar `./pronto-scripts/bin/pronto-api-parity-check employees --json`.
  2. Observar `missing_unknown_method` para rutas de cocina y request-payment.
  3. Inspeccionar `pronto-static/src/vue/employees/shared/core/http.ts` y ver que `/api/*`
     se resuelve a `/{scope}/api/*`.
  4. Inspeccionar `pronto-static/src/vue/employees/chef/components/KDSBoard.vue`.
  5. Inspeccionar `pronto-static/src/vue/employees/shared/store/orders.ts`.
RESULTADO_ACTUAL:
  El parity de employees reporta ruido/falsos faltantes al no mapear el proxy scopeado,
  y `KDSBoard` referencia un método que no existe en el store actual.
RESULTADO_ESPERADO:
  El checker debe normalizar la cobertura del proxy técnico `/{scope}/api/*` a `/api/*`
  para employees y conservar inferencia correcta de método; `KDSBoard` debe usar el
  método real del store para acciones de workflow.
UBICACION:
  - `pronto-scripts/lib/api_parity_check.py`
  - `pronto-static/src/vue/employees/shared/core/http.ts`
  - `pronto-static/src/vue/employees/chef/components/KDSBoard.vue`
  - `pronto-static/src/vue/employees/shared/store/orders.ts`
EVIDENCIA:
  - `missing_unknown_method` sobre `/api/orders/{var}/kitchen/start|ready|request-payment`
  - `KDSBoard.vue:52` usa `ordersStore.updateOrderStatus(orderId, endpoint)`
  - `orders.ts` expone `async processWorkflowAction(orderId, endpoint)`
HIPOTESIS_CAUSA:
  El checker quedó desalineado respecto al proxy técnico scope-aware de employees y el
  componente KDS retuvo una llamada legacy tras refactor del store.
ESTADO: RESUELTO
SOLUCION: Se corrigió `KDSBoard.vue` para usar `ordersStore.processWorkflowAction(...)` (método canónico del store) y se mejoró `api_parity_check.py` para normalizar rutas scopeadas `/{scope}/api/*` de employees a `/api/*`, ampliar ventana de inferencia de método y fallar loud ante errores de introspección.
COMMIT: df92ef4,26b6d58
FECHA_RESOLUCION: 2026-03-06
