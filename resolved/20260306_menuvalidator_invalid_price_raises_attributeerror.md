ID: TEST-20260306-047
FECHA: 2026-03-06
PROYECTO: pronto-libs,pronto-tests
SEVERIDAD: media
TITULO: MenuValidator usa Decimal.InvalidOperation y rompe validación de precio inválido
DESCRIPCION:
  Al reactivar `TestMenuValidator`, `_validate_price()` lanzaba `AttributeError` al intentar capturar
  `Decimal.InvalidOperation` en lugar de `InvalidOperation` del módulo `decimal`.
ESTADO: RESUELTO
SOLUCION:
  `menu_validation.py` ahora importa `InvalidOperation` correctamente y lo captura en `_validate_price()`
  para devolver `MenuValidationError` legible. Validación: `test_menu_validation.py` => `6 passed,
  12 skipped` y suite completa `pronto-tests/tests` => `299 passed, 17 skipped`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06
