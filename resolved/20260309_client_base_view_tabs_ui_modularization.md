ID: BUG-20260309-CLIENT-BASE-VIEW-TABS-UI-MODULARIZATION
FECHA: 2026-03-09
PROYECTO: pronto-static
SEVERIDAD: baja
TITULO: `client-base.ts` mantiene la UI de tabs/vistas embebida en el entrypoint cliente
DESCRIPCION: `client-base.ts` conservaba lógica visual de tabs/vistas (`menu`, `details`, `orders`) mezclada con el wiring del entrypoint. Se extrajo a un helper UI dedicado sin tocar sesión, auth, requests, transporte ni proxies/BFF temporales.
PASOS_REPRODUCIR:
1. Abrir `pronto-static/src/vue/clients/modules/client-base.ts`.
2. Ubicar los bloques `normalizeView`, `setDisplay`, `switchView`, `bindViewTabs`, `setDetailsTabState`, `setOrdersTabState` y lectura DOM de conteos.
3. Verificar que la parte extraída es puramente DOM/UI.
RESULTADO_ACTUAL: El entrypoint cliente mezclaba comportamiento visual de tabs/vistas con responsabilidades mayores del módulo.
RESULTADO_ESPERADO: La UI de tabs/vistas debe vivir en un helper aislado y testeable, manteniendo intacta la funcionalidad actual.
UBICACION:
- pronto-static/src/vue/clients/modules/client-base.ts
- pronto-static/src/vue/clients/modules/view-tabs-ui.ts
- pronto-static/src/vue/clients/modules/view-tabs-ui.spec.ts
EVIDENCIA:
- `view-tabs-ui.ts` no contiene `/api/`, `requestJSON`, auth, `localStorage`, `sessionStorage` ni `session_id`.
- Validación: `PRONTO_TARGET=clients npm run test:run -- modules/view-tabs-ui.spec.ts` OK.
- Validación: `cd pronto-static && npm run build` OK.
HIPOTESIS_CAUSA: La UI de tabs/vistas quedó dentro del entrypoint principal por conveniencia operativa mientras crecían otras funciones del cliente.
ESTADO: RESUELTO
SOLUCION: Se creó `view-tabs-ui.ts` para centralizar normalización de vista, lectura visual de conteos, estado DOM de tabs/badge y activación de secciones; `client-base.ts` mantiene solo el estado local y el wiring necesario. Se añadió `view-tabs-ui.spec.ts` para cubrir normalización, sincronía DOM y binding de tabs.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-09

