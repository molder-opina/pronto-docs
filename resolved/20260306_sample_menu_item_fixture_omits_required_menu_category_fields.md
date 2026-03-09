ID: TEST-20260306-025
FECHA: 2026-03-06
PROYECTO: pronto-tests
SEVERIDAD: media
TITULO: sample_menu_item omite campos requeridos menu_category_id y menu_subcategory_id
DESCRIPCION:
  La fixture creaba `MenuItem` con el contrato viejo y rompía por columnas NOT NULL nuevas.
ESTADO: RESUELTO
SOLUCION:
  Se añadió la fixture `sample_subcategory` y `sample_menu_item` ahora crea registros válidos con
  `menu_category_id` y `menu_subcategory_id`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06
