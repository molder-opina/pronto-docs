ID: TEST-20260306-042
FECHA: 2026-03-06
PROYECTO: pronto-scripts,pronto-client
SEVERIDAD: alta
TITULO: 0398__qa_menu_catalog.sql inserta pronto_menu_items con contrato viejo
DESCRIPCION:
  El seed QA de init usaba el contrato legacy de `pronto_menu_items` y además asumía nombres de
  columnas viejos en `pronto_modifier_groups`, bloqueando `pronto-init --apply` en live.
ESTADO: RESUELTO
SOLUCION:
  `0398__qa_menu_catalog.sql` ahora resuelve `menu_category_id/menu_subcategory_id` canónicos para
  `pronto_menu_items` y detecta si `pronto_modifier_groups` usa `min_select/max_select` o
  `min_selection/max_selection`. Validación: `pronto-init --apply` y `pronto-init --check` OK en
  la DB live `pronto`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06
