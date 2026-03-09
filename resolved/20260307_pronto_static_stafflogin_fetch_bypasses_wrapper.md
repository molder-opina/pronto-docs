ID: STA-20260307-002
FECHA: 2026-03-07
PROYECTO: pronto-static
SEVERIDAD: alta
TITULO: StaffLogin usa fetch directo a /api/public/stats y bypass del wrapper oficial
DESCRIPCION:
  `StaffLogin.vue` realizaba `fetch('/api/public/stats')` directo, fuera del wrapper canónico de employees.
PASOS_REPRODUCIR:
  1. Abrir `pronto-static/src/vue/employees/shared/views/StaffLogin.vue`.
  2. Revisar `fetchPublicStats()` y la llamada directa a `/api/public/stats`.
RESULTADO_ACTUAL:
  `StaffLogin.vue` ya no usa fetch directo ni depende de ese endpoint.
RESULTADO_ESPERADO:
  Toda llamada `/api/*` de employees debe pasar por wrapper o eliminarse si no es necesaria.
UBICACION:
  - `pronto-static/src/vue/employees/shared/views/StaffLogin.vue`
ESTADO: RESUELTO
SOLUCION:
  Se eliminó completamente `fetchPublicStats()` y su `fetch()` directo desde `StaffLogin.vue`.
  La pantalla de login ya no emite esa llamada API, por lo que desaparece el bypass del wrapper y el acoplamiento a un endpoint anónimo.
  Validación: `npm --prefix pronto-static run build` => OK; `npx playwright test tests/functionality/e2e/test_login_flows.spec.ts` => `10 passed`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07
