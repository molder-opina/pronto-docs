ID: BUG-20260309-CLIENT-BASE-DETAILS-ORDERS-UI-MODULARIZATION
FECHA: 2026-03-09
PROYECTO: pronto-static
SEVERIDAD: baja
TITULO: `client-base.ts` mantiene render DOM del panel de detalles/órdenes embebido en el entrypoint cliente
DESCRIPCION: `client-base.ts` todavía contenía funciones de render DOM para el listado de órdenes activas y el historial dentro del panel de detalles. Se extrajeron a un helper dedicado sin tocar sesión, auth, requests, transporte ni proxies/BFF temporales.
PASOS_REPRODUCIR:
1. Abrir `pronto-static/src/vue/clients/modules/client-base.ts`.
2. Ubicar `renderActiveOrders(...)` y `renderCheckoutHistoryInDetails(...)`.
3. Verificar que solo dependen de DOM, `safeSetHTML`, builders de HTML y binding del accordion.
RESULTADO_ACTUAL: El entrypoint cliente mezclaba render DOM del panel de detalles/órdenes con otras responsabilidades del módulo.
RESULTADO_ESPERADO: El render DOM del panel de detalles/órdenes debe vivir en un helper UI aislado y testeable, manteniendo intacta la funcionalidad actual.
UBICACION:
- pronto-static/src/vue/clients/modules/client-base.ts
- pronto-static/src/vue/clients/modules/details-orders-ui.ts
- pronto-static/src/vue/clients/modules/details-orders-ui.spec.ts
EVIDENCIA:
- `details-orders-ui.ts` no contiene `/api/`, `requestJSON`, auth, `session_id`, `localStorage`, `sessionStorage` ni `CartPersistence`.
- Validación: `PRONTO_TARGET=clients npm run test:run -- modules/details-orders-ui.spec.ts` OK.
- Validación: `cd pronto-static && npm run build` OK.
HIPOTESIS_CAUSA: El render de órdenes/historial se mantuvo dentro del entrypoint por cercanía con el polling/tracker antes de extraer utilidades de UI más pequeñas.
ESTADO: RESUELTO
SOLUCION: Se creó `details-orders-ui.ts` para encapsular el render DOM del listado de órdenes activas y del historial en detalles, reutilizando builders de HTML ya extraídos y el binding del accordion. `client-base.ts` conserva polling, fetch y estado; solo delega el render visual. Se añadió `details-orders-ui.spec.ts` como cobertura focalizada.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-09

