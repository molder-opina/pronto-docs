ID: BUG-20260310-SYSTEM-SCOPE-TEST-EMAIL-DRIFT
FECHA: 2026-03-10
PROYECTO: pronto-tests
SEVERIDAD: media
TITULO: Tests/scripts de scope `system` usan emails legacy y rompen autenticación local actual
DESCRIPCION: Varias pruebas y scripts de validación de employees usaban emails legacy para scope `system`, provocando `401` en el entorno QA/local vigente.
PASOS_REPRODUCIR:
1. Ejecutar `test-multi-console-navigation.spec.ts` con fallback `system@cafeteria.test`.
2. Observar fallos en todos los casos `As SYSTEM`.
RESULTADO_ACTUAL: Resuelto.
RESULTADO_ESPERADO: Los defaults de scope `system` deben apuntar a la cuenta vigente o ser configurables por env.
UBICACION:
- pronto-tests/tests/functionality/e2e/test-multi-console-navigation.spec.ts
- pronto-tests/tests/functionality/e2e/test_config_settings_roundtrip_live.py
- pronto-tests/tests/functionality/api/test_v6_config_rbac.py
- pronto-scripts/pronto-api/run-tests.sh
EVIDENCIA:
- Probe real: `system@cafeteria.test` y `system@pronto.test` -> 401; `admin@cafeteria.test` en `/system/login` -> 200.
- `test-multi-console-navigation.spec.ts` pasó 25/25 tras el fix.
HIPOTESIS_CAUSA: Drift entre credenciales históricas de tests y la cuenta system vigente en QA/local.
ESTADO: RESUELTO
SOLUCION:
- Los defaults de tests/runner se alinearon a `admin@cafeteria.test` para scope `system`.
- Se endureció además el helper del spec usando `expect(page).toHaveURL(...)`.
- Se validó con Playwright y con chequeos de sintaxis de scripts/tests auxiliares.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-10

