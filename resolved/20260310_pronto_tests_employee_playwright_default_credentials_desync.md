ID: BUG-20260310-PRONTO-TESTS-EMPLOYEE-PLAYWRIGHT-DEFAULT-CREDENTIALS-DESYNC
FECHA: 2026-03-10
PROYECTO: pronto-tests
SEVERIDAD: media
TITULO: Specs Playwright de employees usan credenciales default desalineadas con el seed QA vigente
DESCRIPCION: Varios specs Playwright/E2E de `pronto-tests` usaban defaults legacy como `maria@pronto.com`, `ana@pronto.com`, `juan@pronto.com`, `carlos@pronto.com`, `pedro@pronto.com` o `system@pronto.com`. El seed operativo/QA vigente documenta cuentas `*@cafeteria.test` con password `ChangeMe!123`, lo que volvía inconsistente la autenticación de los tests.
PASOS_REPRODUCIR:
1. Ejecutar `cd pronto-tests && npx playwright test tests/functionality/ui/playwright-tests/employees/waiter-scope-runtime.spec.ts`.
2. Observar fallas tempranas en login antes de llegar a la lógica runtime.
3. Revisar defaults hardcodeados en specs Playwright/E2E de employees.
RESULTADO_ACTUAL: Los specs mezclaban defaults legacy y QA actuales.
RESULTADO_ESPERADO: Los defaults de login en Playwright/E2E deben estar alineados con credenciales QA vigentes y ser consistentes entre archivos.
UBICACION:
- pronto-tests/tests/functionality/ui/playwright-tests/employees/*.spec.ts
- pronto-tests/tests/functionality/e2e/*.spec.ts
EVIDENCIA:
- Búsqueda transversal posterior: `rg -n "maria@pronto.com|ana@pronto.com|juan@pronto.com|carlos@pronto.com|pedro@pronto.com|system@pronto.com" tests/functionality/ui/playwright-tests tests/functionality/e2e` => sin resultados.
- Validación: `npx playwright test tests/functionality/e2e/test-login-flows.spec.ts` => `9 passed`, `1 failed` (admin `429`, problema distinto al desajuste de defaults).
- Validación: `npx playwright test tests/functionality/ui/playwright-tests/employees/auth.spec.ts` y `.../waiter-scope-runtime.spec.ts` siguen fallando por runtime/UI login, ya no por defaults legacy; quedan fuera de este fix puntual.
- Referencias canónicas usadas: `pronto-docs/QA_TEST_GUIDE.md` (`juan.mesero@cafeteria.test`, `carlos.chef@cafeteria.test`, `laura.cajera@cafeteria.test`, `admin@cafeteria.test`) y `pronto-docs/business/pronto-docs.md` (`system@cafeteria.test`).
HIPOTESIS_CAUSA: El repo mezcló credenciales demo/legacy con credenciales QA actuales y no todos los specs Playwright/E2E se actualizaron cuando cambió el seed base.
ESTADO: RESUELTO
SOLUCION: Se alinearon los defaults Playwright/E2E de employees con las credenciales QA actuales: waiter=`juan.mesero@cafeteria.test`, chef=`carlos.chef@cafeteria.test`, cashier=`laura.cajera@cafeteria.test`, admin=`admin@cafeteria.test`, system=`system@cafeteria.test`. También se eliminó el fallback admin legacy residual en `smoke-critical.spec.ts`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-10

