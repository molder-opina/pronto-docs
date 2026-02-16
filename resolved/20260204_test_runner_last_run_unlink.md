---
ID: ERR-20260204-TESTRUNNER-LASTRUN-EPERM
FECHA: 2026-02-04
PROYECTO: pronto-tests
SEVERIDAD: media
TITULO: run-tests.sh falla al borrar test-results/.last-run.json (EPERM)
DESCRIPCION: El runner de pruebas funcionales intenta eliminar /Users/molder/projects/github-molder/test-results/.last-run.json y falla por permisos (EPERM), lo que impide ejecutar UI/E2E.
PASOS_REPRODUCIR:
1. Ejecutar: pronto-tests/scripts/run-tests.sh functionality
2. Observar salida del runner.
RESULTADO_ACTUAL: Error EPERM al unlink y se reporta UI/E2E tests no disponibles.
RESULTADO_ESPERADO: El runner limpia el archivo o ignora el fallo sin romper la ejecucion de UI/E2E.
UBICACION: pronto-tests/scripts/run-tests.sh (manejo de .last-run.json).
EVIDENCIA: "Error: EPERM: operation not permitted, unlink '/Users/molder/projects/github-molder/test-results/.last-run.json'".
HIPOTESIS_CAUSA: Permisos o path fuera del workspace; el runner no maneja EPERM al limpiar el archivo.
ESTADO: RESUELTO
SOLUCION: El runner ahora hace cd al root de pronto-tests, evitando rutas fuera del workspace al generar test-results.
COMMIT: NO_COMMIT
FECHA_RESOLUCION: 2026-02-04
---
