ID: LIBS-20260307-006
FECHA: 2026-03-07
PROYECTO: pronto-libs
SEVERIDAD: media
TITULO: Residuo db_schema.sql en root de pronto-libs viola regla de archivos de datos en root
DESCRIPCION:
  Existía `db_schema.sql` en la raíz de `pronto-libs`, violando la regla de no mantener `.sql` en roots de proyecto.
PASOS_REPRODUCIR:
  1. Verificar `pronto-libs/db_schema.sql`.
  2. Revisar `git -C pronto-libs status --short`.
RESULTADO_ACTUAL:
  El archivo ya no está en el root de `pronto-libs`; fue reubicado a `tmp/pronto-libs/db_schema.sql`.
RESULTADO_ESPERADO:
  Mover a ubicación permitida (`tmp/`, docs/contracts, backups) y sacar el residuo del root.
UBICACION:
  - `pronto-libs/db_schema.sql`
  - `tmp/pronto-libs/db_schema.sql`
ESTADO: RESUELTO
SOLUCION:
  Se movió el archivo desde `pronto-libs/db_schema.sql` a `tmp/pronto-libs/db_schema.sql` para mantenerlo fuera del root prohibido.
  Validación: `test -f tmp/pronto-libs/db_schema.sql && test ! -f pronto-libs/db_schema.sql` => OK.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07
