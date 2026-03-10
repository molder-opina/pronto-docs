ID: BUG-20260309-CLIENT-BASE-CHECKOUT-ACCORDION-UI-MODULARIZATION
FECHA: 2026-03-09
PROYECTO: pronto-static
SEVERIDAD: baja
TITULO: `client-base.ts` mantiene la UI de accordion de checkout embebida en el entrypoint cliente
DESCRIPCION: `client-base.ts` conservaba la lógica DOM/UI para expandir/contraer secciones de checkout e historial. Se extrajo a un helper dedicado sin tocar sesión, auth, requests, transporte ni proxies/BFF temporales.
PASOS_REPRODUCIR:
1. Abrir `pronto-static/src/vue/clients/modules/client-base.ts`.
2. Ubicar `bindCheckoutAccordions()`.
3. Verificar que solo depende de DOM, clases CSS y atributos ARIA.
RESULTADO_ACTUAL: El entrypoint cliente mezclaba comportamiento visual del accordion con responsabilidades mayores del módulo.
RESULTADO_ESPERADO: La UI del accordion debe vivir en un helper aislado y testeable, manteniendo intacta la funcionalidad actual.
UBICACION:
- pronto-static/src/vue/clients/modules/client-base.ts
- pronto-static/src/vue/clients/modules/checkout-accordions-ui.ts
- pronto-static/src/vue/clients/modules/checkout-accordions-ui.spec.ts
EVIDENCIA:
- `checkout-accordions-ui.ts` no contiene `/api/`, `requestJSON`, auth ni `session_id`.
- Validación: `PRONTO_TARGET=clients npm run test:run -- modules/checkout-accordions-ui.spec.ts` OK.
- Validación: `cd pronto-static && npm run build` OK.
HIPOTESIS_CAUSA: La lógica del accordion se quedó dentro del entrypoint principal por cercanía con el render del historial, sin extracción posterior a una utilidad UI dedicada.
ESTADO: RESUELTO
SOLUCION: Se creó `checkout-accordions-ui.ts` para encapsular binding, toggles, ARIA y visibilidad del contenido; `client-base.ts` ahora reutiliza ese helper sin tocar requests, auth ni sesiones. Se añadió `checkout-accordions-ui.spec.ts` para cubrir inicialización, toggle por click/teclado y protección contra rebinding duplicado.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-09

