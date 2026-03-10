ID: BUG-20260309-CLIENT-BASE-STICKY-CART-UI-MODULARIZATION
FECHA: 2026-03-09
PROYECTO: pronto-static
SEVERIDAD: baja
TITULO: `client-base.ts` mantiene la UI del sticky cart y snackbar undo embebida en el entrypoint cliente
DESCRIPCION: `client-base.ts` todavía contenía la lógica DOM/UI para la barra sticky del carrito y el snackbar de undo. Se extrajo a un helper dedicado sin tocar sesión, auth, requests, transporte ni proxies/BFF temporales. La restauración real del item removido permaneció en `client-base.ts`.
PASOS_REPRODUCIR:
1. Abrir `pronto-static/src/vue/clients/modules/client-base.ts`.
2. Ubicar `initStickyCartBar`, `show/hide/updateStickyCartBar`, `show/hideUndoSnackbar`.
3. Verificar que la capa extraída es UI y que `restoreRemovedItem()` sigue usando `CartPersistence` dentro del entrypoint.
RESULTADO_ACTUAL: El entrypoint cliente mezclaba comportamiento visual del sticky cart/undo con la restauración real del item removido.
RESULTADO_ESPERADO: La UI del sticky cart/undo debe vivir en un helper aislado y testeable, mientras la restauración real del item permanece en `client-base.ts`.
UBICACION:
- pronto-static/src/vue/clients/modules/client-base.ts
- pronto-static/src/vue/clients/modules/sticky-cart-ui.ts
- pronto-static/src/vue/clients/modules/sticky-cart-ui.spec.ts
EVIDENCIA:
- `sticky-cart-ui.ts` no contiene `/api/`, `requestJSON`, auth, `session_id`, `localStorage`, `sessionStorage` ni `CartPersistence`.
- Validación: `PRONTO_TARGET=clients npm run test:run -- modules/sticky-cart-ui.spec.ts` OK.
- Validación: `cd pronto-static && npm run build` OK.
HIPOTESIS_CAUSA: La funcionalidad de sticky cart se integró inicialmente en el entrypoint principal por rapidez y no se separó después entre capa UI y restauración real del item.
ESTADO: RESUELTO
SOLUCION: Se creó `sticky-cart-ui.ts` para encapsular bindings, visibilidad, textos y timeout del sticky cart/undo; `client-base.ts` conserva solamente la cache del item removido y `restoreRemovedItem()` para no tocar la lógica real de persistencia. Se añadió `sticky-cart-ui.spec.ts` para cubrir counters, timeout del snackbar y atajos/bindings.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-09

