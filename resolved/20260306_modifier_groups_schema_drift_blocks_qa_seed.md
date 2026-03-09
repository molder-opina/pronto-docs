ID: TEST-20260306-015
FECHA: 2026-03-06
PROYECTO: pronto-scripts,pronto-libs,pronto-tests
SEVERIDAD: alta
TITULO: Schema base de modifiers/modifier_groups carece de columnas esperadas por seed y ORM
DESCRIPCION:
  El seed `0398__qa_menu_catalog.sql` usaba columnas y tablas que no quedaban disponibles durante
  init sobre una base nueva.
PASOS_REPRODUCIR:
  1. Ejecutar `pronto-init --apply` en una base vacía.
  2. Observar errores sobre `pronto_modifier_groups.description`, `pronto_modifiers.display_order`
     y la tabla `pronto_menu_item_modifier_groups`.
RESULTADO_ACTUAL:
  El init canónico fallaba en el seed QA de catálogo.
RESULTADO_ESPERADO:
  El schema base y el orden de fases deben satisfacer los requisitos del seed QA sin romper init.
UBICACION:
  - `pronto-scripts/init/sql/10_schema/0110__core_tables.sql`
  - `pronto-scripts/init/sql/40_seeds/0398__qa_menu_catalog.sql`
ESTADO: RESUELTO
SOLUCION:
  Se alineó `0110__core_tables.sql` agregando columnas faltantes en `pronto_modifier_groups`
  y `pronto_modifiers`, se volvió condicional la parte del seed que dependía de
  `pronto_menu_item_modifier_groups` y se agregó la migración
  `20260306_10__backfill_qa_menu_modifier_links.sql` para completar esos enlaces post-migración.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06
