ID: ERR-20260213-VALIDATE-SEED-SCRIPT
FECHA: 2026-02-13
PROYECTO: pronto-scripts
SEVERIDAD: alta
TITULO: validate-seed.sh reporta éxito falso y apunta a contenedor incorrecto
DESCRIPCION: El script de validación/seed usaba el contenedor `pronto-employee` (inexistente en este entorno) y aun así finalizaba mostrando `✅ Validación completada` tras errores.
PASOS_REPRODUCIR:
1. Ejecutar `bash pronto-scripts/bin/validate-seed.sh`.
2. Observar `No such container: pronto-employee`.
3. Observar mensaje final de éxito.
RESULTADO_ACTUAL: Falso positivo de éxito y validación no ejecutada correctamente.
RESULTADO_ESPERADO: Detección de contenedor activo correcta y exit code != 0 ante fallo.
UBICACION: pronto-scripts/bin/validate-seed.sh
EVIDENCIA: salida de script con error de contenedor + mensaje final de éxito.
HIPOTESIS_CAUSA: nombre de contenedor hardcodeado desactualizado y flujo con `&&` sin cortar ejecución con mensaje de éxito incondicional.
ESTADO: RESUELTO
SOLUCION: Se añadió autodetección de contenedor (`pronto-employees-1`/`pronto-employee`), rutas absolutas al script Python y manejo explícito de errores con `exit 1`.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-13
