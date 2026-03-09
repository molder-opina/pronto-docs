ID: TESTS-20260309-001
FECHA: 2026-03-09
PROYECTO: pronto-tests
SEVERIDAD: media
TITULO: pronto-tests mezcla specs duplicados y specs especulativos en el lote local
DESCRIPCION:
  El estado local de `pronto-tests` mezclaba un smoke útil con pruebas de distinta madurez:
  un duplicado exacto de feedback y un spec de invoices amplio/no curado.
PASOS_REPRODUCIR:
  1. Revisar `git status` en `pronto-tests`.
  2. Comparar `tests/functionality/api/api-tests/test_feedback_questions_api.py` con `tests/functionality/integration/test_feedback_questions_api.py`.
  3. Revisar `tests/functionality/invoice-flow.spec.ts` y sus rutas/puertos mezclados.
RESULTADO_ACTUAL:
  El lote queda curado: se conserva solo el smoke Playwright útil y su script asociado.
RESULTADO_ESPERADO:
  Mantener solo pruebas útiles, alineadas y mínimamente validadas.
UBICACION:
  - pronto-tests/package.json
  - pronto-tests/tests/functionality/ui/playwright-tests/smoke/smoke-critical.spec.ts
EVIDENCIA:
  - `npx playwright test tests/functionality/ui/playwright-tests/smoke/smoke-critical.spec.ts --list` => OK
  - se eliminaron `tests/functionality/api/api-tests/test_feedback_questions_api.py` y `tests/functionality/invoice-flow.spec.ts`
HIPOTESIS_CAUSA:
  Se agruparon pruebas candidatas de distinta madurez en un mismo lote local sin curación previa.
ESTADO: RESUELTO
SOLUCION:
  Se descartó el duplicado exacto de feedback y el spec amplio/especulativo de invoices. Se conservó `smoke-critical.spec.ts` y el script `test:smoke-critical` en `package.json` como lote mínimo y coherente de soporte de pruebas.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-09