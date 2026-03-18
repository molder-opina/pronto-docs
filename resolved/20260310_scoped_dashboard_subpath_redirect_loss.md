ID: BUG-20260310-SCOPED-DASHBOARD-SUBPATH-REDIRECT-LOSS
FECHA: 2026-03-10
PROYECTO: pronto-static
SEVERIDAD: alta
TITULO: Redirectores absolutos `/{scope}/dashboard/:subpath` pierden el subpath y envían al dashboard raíz
DESCRIPCION: El router employees tenía aliases absolutos scope-aware para deep links (`/waiter/dashboard/...`, `/chef/dashboard/...`, etc.), pero colapsaba todas las subrutas al dashboard raíz. Esto rompía refresh/direct access a rutas hijas como `sessions` y cualquier otra subruta bajo dashboard.
PASOS_REPRODUCIR:
1. Navegar autenticado a `/waiter/dashboard/sessions`.
2. Observar que la URL termina en `/waiter/dashboard` y no en la subruta esperada.
RESULTADO_ACTUAL: Resuelto.
RESULTADO_ESPERADO: `/{scope}/dashboard/<subpath>` debe redirigir internamente a `/dashboard/<subpath>` preservando query/hash.
UBICACION:
- pronto-static/src/vue/employees/shared/router/index.ts
EVIDENCIA:
- `sessions-tabs.spec.ts` pasó 1/1 tras el fix.
- `operational-filters.spec.ts` pasó 1/1 tras el ajuste del router.
HIPOTESIS_CAUSA: Los aliases absolutos del dashboard no conservaban el subpath al mapear rutas scope-aware hacia las rutas internas del SPA.
ESTADO: RESUELTO
SOLUCION:
- Se añadió `redirectScopedDashboardSubpath(...)` para preservar `subpath + query + hash`.
- Se aplicó el fix de forma transversal para waiter, chef, cashier, admin y system.
- Se recompiló el bundle employees para reflejar el cambio en runtime.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-10

