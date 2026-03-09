ID: SCRIPTS-20260309-MIGRATION-CHECKSUM-DRIFT
FECHA: 2026-03-09
PROYECTO: pronto-scripts / pronto-docs
SEVERIDAD: alta
TITULO: Drift por checksum en migration 20260215_03__fix_session_status_column.sql tras edición post-aplicación
DESCRIPCION: `pronto-migrate --check` y `pronto-init --check` fallan con `pending=0 drift=1` para `20260215_03__fix_session_status_column.sql`. El schema real y el ORM ya están alineados en `status VARCHAR(50)`, pero la migration fue editada después de aplicada: el único cambio histórico detectado fue en el `COMMENT ON COLUMN pronto_dining_sessions.status`, agregando `merged` al texto descriptivo. Esto rompe la verificación por checksum aunque la estructura ya esté correcta.
PASOS_REPRODUCIR:
1. Ejecutar `bash -lc 'set -a; source .env >/dev/null 2>&1 || true; set +a; ./pronto-scripts/bin/pronto-migrate --check'`.
2. Observar `DRIFT: 20260215_03__fix_session_status_column.sql`.
3. Ejecutar `cd pronto-scripts && git log --follow -p -- init/sql/migrations/20260215_03__fix_session_status_column.sql`.
4. Verificar que el cambio posterior al alta fue solo en el comentario del campo `status`.
RESULTADO_ACTUAL: La verificación canónica ya no falla. La migration fue restaurada al contenido originalmente aplicado y los checks quedaron en verde: `pronto-migrate --check` => `pending=0 drift=0`, `pronto-init --check` => `ok: true`, `pronto-init-seed-review.sh` => `EXIT=0`.
RESULTADO_ESPERADO: Las migrations aplicadas no deben modificarse después de su aplicación; el archivo en repo debe coincidir con el hash registrado en `pronto_schema_migrations`, permitiendo `pending=0 drift=0`.
UBICACION:
- pronto-scripts/init/sql/migrations/20260215_03__fix_session_status_column.sql
- pronto-scripts/bin/pronto-migrate
- pronto-libs/src/pronto_shared/models/order_models.py
- pronto-scripts/init/sql/10_schema/0110__core_tables.sql
EVIDENCIA:
- `pronto-migrate --check` => `pending=0 drift=1`, `DRIFT: 20260215_03__fix_session_status_column.sql`.
- `pronto-init --check` => sin gaps de schema/columns/indexes/tables, pero falla por el mismo drift.
- `git log --follow -p` en la migration muestra un único edit post-aplicación: se agregó `merged` al comentario.
- `information_schema.columns` confirma `pronto_dining_sessions.status = character varying(50)`.
HIPOTESIS_CAUSA: Se editó una migration ya aplicada para ajustar un comentario descriptivo, violando la inmutabilidad práctica de migrations históricas y generando checksum drift.
ESTADO: RESUELTO
SOLUCION: Se restauró `20260215_03__fix_session_status_column.sql` a la versión históricamente aplicada, eliminando el edit posterior en el comentario descriptivo del campo `status`. Con eso se removió el checksum drift sin tocar la base de datos y se recuperó el estado verde de `pronto-migrate --check` y `pronto-init --check`.
COMMIT: pronto-scripts:e1fcabf
FECHA_RESOLUCION: 2026-03-09

