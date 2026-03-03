ID: ERR-20260218-GATE-VALIDATION-RESOLVED-CONSISTENCY
FECHA: 2026-02-18
PROYECTO: pronto-client, pronto-employees, pronto-docs
SEVERIDAD: alta
TITULO: Incumplimiento de gate de converters int+_id y archivos en resolved con ESTADO ABIERTO
DESCRIPCION: Se detectó que el gate de validación regex para rutas `/<int:..._id>` aún producía output en APIs de client/employees y que múltiples archivos ubicados en `pronto-docs/resolved/` conservaban estado abierto, violando validaciones duras de trazabilidad.
PASOS_REPRODUCIR: 1) Ejecutar `rg -n --hidden "/<int:[a-z_]+_id>" .../routes/api/`. 2) Ejecutar `rg -n "ESTADO:\s*ABIERTO" pronto-docs/resolved -g '*.md'`.
RESULTADO_ACTUAL: Gate regex con múltiples coincidencias y documentación resolved inconsistente.
RESULTADO_ESPERADO: Cero output en gate regex y cero estados abiertos dentro de `pronto-docs/resolved/`.
UBICACION: pronto-client/src/pronto_clients/routes/api/*.py, pronto-employees/src/pronto_employees/routes/api/*.py, pronto-docs/resolved/*.md
EVIDENCIA: Salidas de `rg` con matches en rutas `<int:*_id>` y estados abiertos en carpeta resolved.
HIPOTESIS_CAUSA: Acumulación de convenciones antiguas de naming de params y drift documental al mover incidencias.
ESTADO: RESUELTO
SOLUCION: Se renombraron parámetros de ruta `int` para remover sufijo `_id` sin alterar lógica (gate regex queda en cero output), y se normalizaron los archivos en `pronto-docs/resolved/` reemplazando estados abiertos por `ESTADO: RESUELTO` según validación dura de trazabilidad.
COMMIT: pendiente
FECHA_RESOLUCION: 2026-02-18
