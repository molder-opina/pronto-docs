ID: TEST-20260307-067
FECHA: 2026-03-07
PROYECTO: pronto-scripts
SEVERIDAD: baja
TITULO: cleanup-old-sessions --dry-run hereda hostnames Docker y falla desde el host local
DESCRIPCION:
  Tras endurecer `cleanup-old-sessions.sh`, el nuevo camino seguro `--dry-run` invocaba correctamente el script offline,
  pero heredaba `POSTGRES_HOST=pronto-postgres` (o `postgres`) y `REDIS_URL` de los `.env`, valores válidos dentro de la
  red Docker pero no resolubles desde el host local.
PASOS_REPRODUCIR:
  1. Ejecutar `bash pronto-scripts/bin/cleanup-old-sessions.sh --dry-run`.
  2. Observar `could not translate host name "pronto-postgres" to address`.
RESULTADO_ACTUAL:
  El wrapper seguro fallaba por heredar hostnames de contenedor al ejecutar el script offline desde el host.
RESULTADO_ESPERADO:
  El wrapper debe normalizar esos hostnames a `localhost` para el camino offline ejecutado desde el host local.
UBICACION:
  - `pronto-scripts/bin/cleanup-old-sessions.sh`
ESTADO: RESUELTO
SOLUCION:
  Se añadieron normalizadores de entorno para el camino offline del wrapper: `postgres`/`pronto-postgres` pasan a
  `localhost` y `redis://redis...`/`redis://pronto-redis...` pasan a `redis://localhost...` antes de invocar el script
  Python. Validación: `bash pronto-scripts/bin/cleanup-old-sessions.sh --dry-run` => exit 0 mostrando estadísticas y
  `0` sesiones cerradas; `bash pronto-scripts/bin/cleanup-old-sessions.sh --all --dry-run` => exit 0 con preview total.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07
