ID: BUG-20260309-CLIENT-BASE-BUSINESS-HOURS-UI-MODULARIZATION
FECHA: 2026-03-09
PROYECTO: pronto-static
SEVERIDAD: baja
TITULO: `client-base.ts` mantiene la UI de horarios del negocio embebida en el entrypoint cliente
DESCRIPCION: `client-base.ts` conservaba la lógica DOM/UI para abrir el modal de horarios, fallback al resaltado de la sección y cierre por overlay/botón. Se extrajo a un helper dedicado sin tocar sesión, auth, requests, transporte ni proxies/BFF temporales.
PASOS_REPRODUCIR:
1. Abrir `pronto-static/src/vue/clients/modules/client-base.ts`.
2. Ubicar `bindBusinessHoursButton()`.
3. Verificar que solo depende de DOM y `showNotification`.
RESULTADO_ACTUAL: El entrypoint cliente mezclaba comportamiento visual de horarios con responsabilidades mayores del módulo.
RESULTADO_ESPERADO: La UI de horarios debe vivir en un helper aislado y testeable, manteniendo intacta la funcionalidad actual.
UBICACION:
- pronto-static/src/vue/clients/modules/client-base.ts
- pronto-static/src/vue/clients/modules/business-hours-ui.ts
- pronto-static/src/vue/clients/modules/business-hours-ui.spec.ts
EVIDENCIA:
- `business-hours-ui.ts` no contiene `/api/`, `requestJSON`, auth ni `session_id`.
- Validación: `PRONTO_TARGET=clients npm run test:run -- modules/business-hours-ui.spec.ts` OK.
- Validación: `cd pronto-static && npm run build` OK.
HIPOTESIS_CAUSA: La UI de horarios se agregó por conveniencia dentro del entrypoint principal y no se había extraído a una utilidad dedicada.
ESTADO: RESUELTO
SOLUCION: Se creó `business-hours-ui.ts` para encapsular apertura/cierre del modal, delegación a globals existentes y fallback visual/notificación; `client-base.ts` ahora solo lo cablea con `showNotification`. Se añadió `business-hours-ui.spec.ts` para cubrir delegación global, modal fallback y resaltado visual.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-09

