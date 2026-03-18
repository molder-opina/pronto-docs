ID: BUG-20260310-WAITER-SCOPE-RUNTIME-SPEC-DRIFT
FECHA: 2026-03-10
PROYECTO: pronto-tests
SEVERIDAD: media
TITULO: Specs waiter scope usan helper de login frágil y endpoint legacy request-payment
DESCRIPCION: Varias pruebas Playwright waiter dependían de `waitForURL(...)`, generando timeouts flake aun cuando la página ya estaba en dashboard. Además, `waiter-scope-runtime.spec.ts` llamaba un endpoint legacy `/request-payment` desalineado con la ruta canónica actual.
PASOS_REPRODUCIR:
1. Ejecutar `waiter-scope-runtime.spec.ts`.
2. Observar fallos intermitentes de login y no-OK en el flujo de solicitud de cuenta.
RESULTADO_ACTUAL: Resuelto.
RESULTADO_ESPERADO: Helpers robustos y spec alineado al contrato actual.
UBICACION:
- pronto-tests/tests/functionality/ui/playwright-tests/employees/waiter-scope-runtime.spec.ts
- pronto-tests/tests/functionality/ui/playwright-tests/employees/sessions-tabs.spec.ts
- pronto-tests/tests/functionality/ui/playwright-tests/employees/profile-preferences.spec.ts
EVIDENCIA:
- `waiter-scope-runtime.spec.ts` quedó 6/6 en verde.
- El helper recurrente se endureció también en `sessions-tabs.spec.ts` y `profile-preferences.spec.ts`.
HIPOTESIS_CAUSA: Drift entre helpers duplicados de Playwright y rutas/backend actuales.
ESTADO: RESUELTO
SOLUCION:
- Los helpers waiter reemplazaron `waitForURL(...)` por `expect(page).toHaveURL(...)` para evitar carreras de navegación.
- `waiter-scope-runtime.spec.ts` se alineó con la ruta canónica `POST /waiter/api/orders/{id}/request-check`.
- El test de logout se actualizó al contrato SSR real: navegación `GET /waiter/logout` y verificación de redirect a login.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-10

