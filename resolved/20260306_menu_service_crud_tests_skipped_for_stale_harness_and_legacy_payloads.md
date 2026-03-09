ID: TEST-20260306-048
FECHA: 2026-03-06
PROYECTO: pronto-tests
SEVERIDAD: media
TITULO: tests CRUD de menu_service siguen skippeados por harness stale y payloads legacy
DESCRIPCION:
  Los 12 skips restantes en `test_menu_validation.py` para `create/update/delete` vía `menu_service`
  estaban atados a un harness viejo sin `menu_category_id/menu_subcategory_id`, con IDs inválidos y
  sin patching de `get_session` ni side-effects del servicio actual.
ESTADO: RESUELTO
SOLUCION:
  Se activaron los 12 tests usando `db_session`, categoría/subcategoría UUID reales y patching mínimo
  de `menu_service_impl` (`get_session`, cache, draft y day periods). Además se alinearon las
  expectativas a la forma actual de `success_response/error_response`. Validación: `test_menu_validation.py`
  => `18 passed` y suite completa `pronto-tests/tests` => `311 passed, 5 skipped`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06
