ID: TEST-20260306-051
FECHA: 2026-03-06
PROYECTO: pronto-scripts
SEVERIDAD: media
TITULO: pronto-migrate --apply falla en 20260307_01 por conflicto entre constraint e índice uq_menu_categories_slug
DESCRIPCION:
  `pronto-migrate --apply` fallaba en `20260307_01__menu_category_slug_revision.sql` porque intentaba
  agregar `uq_menu_categories_slug` aunque una migración previa ya había creado un índice único con
  ese mismo nombre.
ESTADO: RESUELTO
SOLUCION:
  La migración ahora comprueba tanto `pg_constraint` como `pg_class` antes de crear
  `uq_menu_categories_slug`, evitando la colisión de nombre con el índice existente. Validación:
  `DATABASE_URL=postgresql://pronto:pronto123@localhost:5432/pronto ./pronto-scripts/bin/pronto-migrate --apply`
  => exit 0; `pronto-migrate --check` => `pending=0 drift=0`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06
