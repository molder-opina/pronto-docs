ID: BUG-20260309-CLIENT-BASE-VIEW-NAVIGATION-UI-WRAPPERS-MODULARIZATION
FECHA: 2026-03-09
PROYECTO: pronto-static
SEVERIDAD: baja
TITULO: `client-base.ts` mantiene wrappers pequeños de navegación/view UI embebidos en el entrypoint cliente
DESCRIPCION: `client-base.ts` todavía contenía wrappers pequeños de navegación/view UI como `applyInitialViewFromUrl()`, `backToMenu()` y `openAuthModalForCheckout()`. Se extrajeron a un helper dedicado sin tocar sesión, auth real, requests, transporte ni proxies/BFF temporales.
PASOS_REPRODUCIR:
1. Abrir `pronto-static/src/vue/clients/modules/client-base.ts`.
2. Ubicar `applyInitialViewFromUrl()`, `backToMenu()` y `openAuthModalForCheckout()`.
3. Verificar que operan solo sobre `window.location`, `history.replaceState`, `scrollTo`, notificación UI y `toggleProfile()`.
RESULTADO_ACTUAL: El entrypoint cliente conservaba wrappers pequeños de navegación/view mezclados con lógica más grande del módulo.
RESULTADO_ESPERADO: Estos wrappers UI deben vivir en un helper aislado y testeable, manteniendo intacta la funcionalidad actual.
UBICACION:
- pronto-static/src/vue/clients/modules/client-base.ts
- pronto-static/src/vue/clients/modules/view-navigation-ui.ts
- pronto-static/src/vue/clients/modules/view-navigation-ui.spec.ts
EVIDENCIA:
- `view-navigation-ui.ts` no contiene `/api/`, `requestJSON`, auth, `session_id`, `localStorage`, `sessionStorage` ni `CartPersistence`.
- Validación: `PRONTO_TARGET=clients npm run test:run -- modules/view-navigation-ui.spec.ts` OK.
- Validación: `cd pronto-static && npm run build` OK.
- Recurrencia inventariada: existen patrones relacionados de `toggleProfile()`, `history.replaceState(...)` y `scrollTo(...)` en `pronto-client/templates/index.html`, `debug_panel.html`, `pronto-static/src/vue/clients/modules/menu-shortcuts.ts` y módulos employees, pero no son la misma semántica de wrapper y quedan fuera de este corte puntual.
HIPOTESIS_CAUSA: Son helpers pequeños que se quedaron en el entrypoint por conveniencia local mientras crecían otros flujos del cliente.
ESTADO: RESUELTO
SOLUCION: Se creó `view-navigation-ui.ts` para encapsular deep-link inicial de `view/profile`, regreso visual a menú y apertura del overlay/login de checkout. `client-base.ts` conserva wrappers finos para no romper globals ni wiring actual. Se añadió `view-navigation-ui.spec.ts` como cobertura focalizada.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-09

