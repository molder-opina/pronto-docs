ID: TEST-20260306-019
FECHA: 2026-03-06
PROYECTO: pronto-scripts,pronto-libs,pronto-tests
SEVERIDAD: alta
TITULO: Migración create_invoices_table usa session_id en lugar de dining_session_id
DESCRIPCION:
  `20260306_06__create_invoices_table.sql` estaba desalineada con la autoridad canónica de `Invoice`.
PASOS_REPRODUCIR:
  1. Ejecutar `pronto-migrate --apply` en una base nueva.
  2. Observar fallos por `session_id` inexistente o por comentarios sobre `tax_id` antes de su alta.
RESULTADO_ACTUAL:
  Las migraciones se detenían en el tramo final de invoices.
RESULTADO_ESPERADO:
  La migración debe ser compatible con `dining_session_id` y no depender de tax fields creados después.
UBICACION:
  - `pronto-scripts/init/sql/migrations/20260306_06__create_invoices_table.sql`
  - `pronto-scripts/init/sql/migrations/20260306_07__alter_invoices_table_add_tax_fields.sql`
ESTADO: RESUELTO
SOLUCION:
  Se cambió `session_id` por `dining_session_id`, se hizo condicional la creación del índice de sesión
  y también el comentario sobre `tax_id`, evitando dependencia prematura de la migración siguiente.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06
