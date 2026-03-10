ID: BUG-20260309-CLIENT-BASE-GLOBAL-LOADING-UI-SHELL-MODULARIZATION
FECHA: 2026-03-09
PROYECTO: pronto-static
SEVERIDAD: baja
TITULO: `client-base.ts` mantiene la capa UI del global loading embebida en el entrypoint cliente
DESCRIPCION: `client-base.ts` todavía contenía dentro de `setupGlobalLoading()` la capa UI del overlay global (`pending`, `classList.add/remove('visible')`). Se extrajo a un helper dedicado sin tocar el wrapping de `window.fetch`, requests, auth, sesión ni proxies/BFF temporales.
PASOS_REPRODUCIR:
1. Abrir `pronto-static/src/vue/clients/modules/client-base.ts`.
2. Ubicar `setupGlobalLoading()`.
3. Verificar que el sub-bloque extraído solo maneja contador visual y clases del overlay.
RESULTADO_ACTUAL: El entrypoint cliente mezclaba la shell UI del overlay global con el wrapping de `window.fetch`.
RESULTADO_ESPERADO: La shell UI del overlay global debe vivir en un helper aislado y testeable, dejando el wrapping de `window.fetch` dentro de `client-base.ts`.
UBICACION:
- pronto-static/src/vue/clients/modules/client-base.ts
- pronto-static/src/vue/clients/modules/global-loading-ui.ts
- pronto-static/src/vue/clients/modules/global-loading-ui.spec.ts
EVIDENCIA:
- `global-loading-ui.ts` no contiene `/api/`, `requestJSON`, auth, `session_id`, `localStorage`, `sessionStorage`, `CartPersistence`, `window.fetch` ni `fetchWrapped`.
- Validación: `PRONTO_TARGET=clients npm run test:run -- modules/global-loading-ui.spec.ts` OK.
- Validación: `cd pronto-static && npm run build` OK.
- Recurrencia inventariada: existen implementaciones/patrones relacionados de global loading en `pronto-libs/src/pronto_shared/templates/base.html`, `pronto-client/src/pronto_clients/templates/base.html` y `pronto-static/src/vue/shared/components/LoadingOverlay.vue`; quedan fuera de este corte porque aquí solo se extrajo la shell UI local del cliente, sin unificar SSR/shared shells ni wrappers de transporte.
HIPOTESIS_CAUSA: El helper visual quedó incrustado en `setupGlobalLoading()` por cercanía con el bootstrap del fetch wrapper y no se separó después.
ESTADO: RESUELTO
SOLUCION: Se creó `global-loading-ui.ts` para encapsular el contador visual y el toggle del overlay global. `client-base.ts` ahora importa ese helper, pero conserva intactos `window.GlobalLoading`, el wrapping de `window.fetch` y `fetchWrapped`. Se añadió `global-loading-ui.spec.ts` para cubrir incrementos, decrementos y protección contra underflow.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-09

