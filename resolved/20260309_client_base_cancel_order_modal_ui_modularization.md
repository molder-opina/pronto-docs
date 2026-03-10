ID: BUG-20260309-CLIENT-BASE-CANCEL-ORDER-MODAL-UI-MODULARIZATION
FECHA: 2026-03-09
PROYECTO: pronto-static
SEVERIDAD: baja
TITULO: `client-base.ts` mantiene la UI del modal de cancelación embebida en el entrypoint cliente
DESCRIPCION: `client-base.ts` todavía contenía la lógica DOM/UI de `showCancelOrderSelector(...)` para crear, poblar y resolver el modal de selección de orden a cancelar. Se extrajo a un helper dedicado sin tocar sesión, auth, requests, transporte ni proxies/BFF temporales.
PASOS_REPRODUCIR:
1. Abrir `pronto-static/src/vue/clients/modules/client-base.ts`.
2. Ubicar `showCancelOrderSelector(...)`.
3. Verificar que la parte extraída solo maneja `window.confirm`, DOM, estilos inline, render del `<select>` y callbacks de resolución.
RESULTADO_ACTUAL: El entrypoint cliente mezclaba la UI del modal de cancelación con otras responsabilidades del módulo.
RESULTADO_ESPERADO: La UI del modal de cancelación debe vivir en un helper aislado y testeable, manteniendo intacta la lógica de negocio que decide cuándo cancelar y la llamada al API.
UBICACION:
- pronto-static/src/vue/clients/modules/client-base.ts
- pronto-static/src/vue/clients/modules/cancel-order-modal-ui.ts
- pronto-static/src/vue/clients/modules/cancel-order-modal-ui.spec.ts
EVIDENCIA:
- `cancel-order-modal-ui.ts` no contiene `/api/`, `requestJSON`, auth, `session_id`, `localStorage`, `sessionStorage` ni `CartPersistence`.
- Validación: `PRONTO_TARGET=clients npm run test:run -- modules/cancel-order-modal-ui.spec.ts` OK.
- Validación: `cd pronto-static && npm run build` OK.
- Recurrencia inventariada: la ocurrencia exacta del selector de cancelación existe solo en `client-base.ts`; hay modales genéricos/overlays en otros puntos del monorepo (por ejemplo `employees/waiter/legacy/ui-utils.ts`, `post-payment-feedback.ts`, `employee-shortcuts.ts`), pero responden a flujos distintos y quedan fuera de este corte.
HIPOTESIS_CAUSA: El modal de cancelación se integró directamente en el entrypoint por conveniencia operativa y no se separó después de la lógica de flujo que dispara la cancelación.
ESTADO: RESUELTO
SOLUCION: Se creó `cancel-order-modal-ui.ts` para encapsular el `confirm` de una sola orden y el modal selector multiorden, recibiendo callbacks para IDs, labels y sanitización HTML. `client-base.ts` conserva la lógica que determina la cancelación, pide el motivo y llama al API. Se añadió `cancel-order-modal-ui.spec.ts` para cubrir confirm simple, confirm multiorden y cierre del modal.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-09

