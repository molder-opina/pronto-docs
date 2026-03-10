ID: BUG-20260309-CLIENT-BASE-UI-FORMATTERS-MODULARIZATION
FECHA: 2026-03-09
PROYECTO: pronto-static
SEVERIDAD: baja
TITULO: `client-base.ts` mantiene formatters/render helpers puros embebidos en el entrypoint cliente
DESCRIPCION: `client-base.ts` todavía contenía helpers puramente frontend como `safeSetHTML(...)` y `formatCurrency(...)`, usados por la UI cliente pero sin dependencia de sesión, auth, transporte ni proxies/BFF temporales. Se extrajeron a un helper dedicado sin tocar funcionalidad sensible.
PASOS_REPRODUCIR:
1. Abrir `pronto-static/src/vue/clients/modules/client-base.ts`.
2. Ubicar `safeSetHTML(...)` y `formatCurrency(...)`.
3. Verificar que solo operan sobre datos/DOM de presentación y no realizan requests ni acceden a sesión.
RESULTADO_ACTUAL: El entrypoint cliente conservaba utilidades puras de presentación mezcladas con lógica más grande del módulo.
RESULTADO_ESPERADO: Los formatters/render helpers puros deben vivir en un módulo aislado y testeable, manteniendo intacta la funcionalidad actual.
UBICACION:
- pronto-static/src/vue/clients/modules/client-base.ts
- pronto-static/src/vue/clients/modules/ui-formatters.ts
- pronto-static/src/vue/clients/modules/ui-formatters.spec.ts
EVIDENCIA:
- `ui-formatters.ts` no contiene `/api/`, `requestJSON`, auth, `session_id`, `localStorage`, `sessionStorage` ni `CartPersistence`.
- Validación: `PRONTO_TARGET=clients npm run test:run -- modules/ui-formatters.spec.ts` OK.
- Validación: `cd pronto-static && npm run build` OK.
- Recurrencia inventariada: existen otros `formatCurrency` en `clients/store/cart.ts`, `clients/modules/thank-you.ts` y `clients/components/ClientInvoices.vue`; quedan pendientes fuera de este corte porque pueden tener semántica/alcance visual propio y requerir refactor transversal separado.
HIPOTESIS_CAUSA: El entrypoint fue creciendo y absorbió utilidades puras de presentación por conveniencia local, sin extracción posterior a un helper común.
ESTADO: RESUELTO
SOLUCION: Se creó `ui-formatters.ts` para centralizar `safeSetHTML(...)` y `formatCurrency(...)`; `client-base.ts` ahora importa ese módulo y mantiene el mismo comportamiento, incluida la exposición global de `window.formatCurrency`. Se añadió `ui-formatters.spec.ts` para cubrir sanitización y formateo con fallback.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-09

