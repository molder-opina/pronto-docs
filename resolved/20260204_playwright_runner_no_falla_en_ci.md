---
ID: ERR-20260204-PLAYWRIGHT-RUNNER-NO-FAIL
FECHA: 2026-02-04
PROYECTO: pronto-tests
SEVERIDAD: alta
TITULO: Runner de Playwright no falla (exit 0) aunque existan tests fallidos
DESCRIPCION: El script pronto-tests/scripts/run-tests.sh imprime warnings y continua (|| echo), retornando exit code 0 aun cuando Playwright reporta multiples fallos. Esto permite que CI/pipelines pasen con regresiones UI/E2E.
PASOS_REPRODUCIR:
1) Levantar servicios (client/employees/api) y static
2) Ejecutar: cd pronto-tests && bash scripts/run-tests.sh functionality
RESULTADO_ACTUAL:
Playwright reporta fallos, pero el script finaliza con "✅ Ejecución completada" y exit code 0.
RESULTADO_ESPERADO:
Si Playwright retorna codigo != 0, el runner debe salir con exit 1.
UBICACION:
pronto-tests/scripts/run-tests.sh
EVIDENCIA:
Comando:
cd pronto-tests && bash scripts/run-tests.sh functionality
Salida:
Se observan multiples "✘" y resumen con "passed" + fallos, pero el script termina sin error.
HIPOTESIS_CAUSA:
Uso de "|| echo" alrededor de npx playwright test y pytest, lo que suprime el exit code real.
ESTADO: RESUELTO
---

SOLUCION: Se actualizo el runner de Playwright para propagar correctamente el exit code (fail en CI cuando Playwright falla).
COMMIT: e5bc277
FECHA_RESOLUCION: 2026-02-05

SOLUCION:
- scripts/run-tests.sh ya no suprime errores con `|| echo`; ahora propaga fallos (exit 1) si cualquier suite requerida falla o falta tooling.

COMMIT:
e5bc277

FECHA_RESOLUCION:
2026-02-05
