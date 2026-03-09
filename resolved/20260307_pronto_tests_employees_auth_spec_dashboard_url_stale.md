ID: TEST-20260307-061
FECHA: 2026-03-07
PROYECTO: pronto-tests
SEVERIDAD: media
TITULO: auth.spec.ts de employees espera redirects legacy de dashboard
DESCRIPCION:
  `pronto-tests/tests/functionality/ui/playwright-tests/employees/auth.spec.ts` seguía esperando
  navegación final a `/<scope>/dashboard` tras login, mientras el router actual de employees
  resuelve a rutas canónicas bajo `/dashboard/*`.
PASOS_REPRODUCIR:
  1. Ejecutar `npx playwright test tests/functionality/ui/playwright-tests/employees/auth.spec.ts`.
  2. Iniciar sesión como admin o waiter.
RESULTADO_ACTUAL:
  El spec quedó alineado al routing vigente y ya no falla por timeouts de URL legacy.
RESULTADO_ESPERADO:
  El spec debe aceptar la forma canónica actual de dashboard y validar autenticación sin asumir una URL legacy rígida.
UBICACION:
  - `pronto-tests/tests/functionality/ui/playwright-tests/employees/auth.spec.ts`
ESTADO: RESUELTO
SOLUCION:
  Se añadió `DASHBOARD_URL_PATTERN` para aceptar tanto aliases scopeados como la forma canónica `/dashboard/*`, y se reemplazaron los `waitForURL` rígidos de admin/waiter por ese patrón compartido.
  Validación: `npx playwright test tests/functionality/ui/playwright-tests/employees/auth.spec.ts` => `3 passed`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07
