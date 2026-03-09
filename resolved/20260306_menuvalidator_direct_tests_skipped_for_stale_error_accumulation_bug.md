ID: TEST-20260306-046
FECHA: 2026-03-06
PROYECTO: pronto-tests
SEVERIDAD: media
TITULO: tests directos de MenuValidator siguen skippeados por bug stale de acumulación de errores
DESCRIPCION:
  `test_menu_validation.py` mantenía 6 skips en `TestMenuValidator` por una razón obsoleta, aunque el
  validador actual ya reinicia `self.errors` al inicio de cada validación pública.
ESTADO: RESUELTO
SOLUCION:
  Se activaron los 6 tests directos de `MenuValidator` usando un payload base compatible con el
  contrato actual (`menu_category_id` y `menu_subcategory_id`) y verificando llamadas consecutivas
  sobre la misma instancia sin acumulación espuria de errores. Validación: `test_menu_validation.py`
  => `6 passed, 12 skipped`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06
