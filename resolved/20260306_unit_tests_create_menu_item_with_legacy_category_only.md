ID: TEST-20260306-036
FECHA: 2026-03-06
PROYECTO: pronto-tests
SEVERIDAD: media
TITULO: unit tests crean MenuItem solo con category_id y rompen con schema actual
DESCRIPCION:
  Los helpers unitarios seguían construyendo `MenuItem` con contrato viejo incompleto.
ESTADO: RESUELTO
SOLUCION:
  Se alinearon `test_models.py` y `_create_order()` a `menu_category_id` + `menu_subcategory_id`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06
