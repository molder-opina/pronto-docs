---
ID: ERR-20260204-PLAYWRIGHT-E2E-NO-SPECS
FECHA: 2026-02-04
PROYECTO: pronto-tests
SEVERIDAD: baja
TITULO: Playwright E2E sin archivos .spec en tests/functionality/e2e
DESCRIPCION: El runner intenta ejecutar tests E2E en tests/functionality/e2e pero no hay archivos .spec, y Playwright reporta "No tests found".
PASOS_REPRODUCIR:
1. Ejecutar: pronto-tests/scripts/run-tests.sh functionality
2. Ver salida en seccion E2E.
RESULTADO_ACTUAL: "No tests found" y se marca E2E no disponible.
RESULTADO_ESPERADO: Existen specs E2E o el runner omite la seccion si no hay tests.
UBICACION: pronto-tests/tests/functionality/e2e/ (vacio de specs).
EVIDENCIA: "Error: No tests found. Make sure that arguments are regular expressions matching test files."
HIPOTESIS_CAUSA: No hay specs E2E en el folder o el runner no valida si existe alguno.
ESTADO: RESUELTO
SOLUCION: Los tests E2E en `tests/functionality/e2e/` usan Python (pytest) y archivos `.cjs`, no archivos `.spec.ts` de Playwright. Archivos existentes:
- `test_e2e_cliente_crear_orden.py`
- `test_e2e_flujo_completo.cjs`
- `test_e2e_simple.cjs`
- `test_mesero_aceptar_orden.py`
- `test_pronto_flow.py`

El runner de Playwright no debe ejecutarse en este directorio. Los tests E2E se ejecutan con pytest o node directamente, no con `npx playwright test`.
FECHA_RESOLUCION: 2026-02-09
---
