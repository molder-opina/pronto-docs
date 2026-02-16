---
ID: ERR-20260204-PLAYWRIGHT-BROWSERS-MISSING
FECHA: 2026-02-04
PROYECTO: pronto-tests
SEVERIDAD: alta
TITULO: Playwright no encuentra browsers instalados
DESCRIPCION: La ejecucion de pruebas UI falla porque Playwright no encuentra el ejecutable de Chromium headless en cache local.
PASOS_REPRODUCIR:
1. Ejecutar: pronto-tests/scripts/run-tests.sh functionality
2. Observar fallos de Playwright en UI tests.
RESULTADO_ACTUAL: Error "Executable doesn't exist" y se abortan todos los UI tests.
RESULTADO_ESPERADO: Playwright encuentra browsers y ejecuta UI tests.
UBICACION: pronto-tests/scripts/run-tests.sh (invoca npx playwright test).
EVIDENCIA: "browserType.launch: Executable doesn't exist at /Users/molder/Library/Caches/ms-playwright/..."
HIPOTESIS_CAUSA: Browsers no descargados en el host; falta ejecutar npx playwright install.
ESTADO: RESUELTO
SOLUCION: Este es un error de configuración del entorno, no un bug de código. Los browsers de Playwright deben instalarse manualmente en cada máquina de desarrollo. El README ya documenta el requisito en la línea 83: `Playwright (npx playwright install)`. Para resolver:
```bash
cd pronto-tests
npx playwright install
```
O para instalar con dependencias del sistema:
```bash
npx playwright install --with-deps
```
FECHA_RESOLUCION: 2026-02-09
---
