ID: TEST-20260306-016
FECHA: 2026-03-06
PROYECTO: pronto-scripts,pronto-tests
SEVERIDAD: alta
TITULO: Migración de waiter_table_assignments altera antes de crear la tabla
DESCRIPCION:
  La migración `20260215_11__create_waiter_table_assignments_table.sql` ejecutaba un `ALTER TABLE`
  antes del `CREATE TABLE IF NOT EXISTS`.
PASOS_REPRODUCIR:
  1. Ejecutar `pronto-migrate --apply` en una base nueva.
  2. Observar `relation "pronto_waiter_table_assignments" does not exist`.
RESULTADO_ACTUAL:
  Las migraciones se detenían en una base limpia.
RESULTADO_ESPERADO:
  La tabla debe existir antes de alterarla o indexarla.
UBICACION:
  - `pronto-scripts/init/sql/migrations/20260215_11__create_waiter_table_assignments_table.sql`
ESTADO: RESUELTO
SOLUCION:
  Se reordenó la migración para crear la tabla primero y agregar luego la columna `notes` y sus índices.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06
