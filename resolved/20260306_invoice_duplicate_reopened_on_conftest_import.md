ID: TEST-20260306-013
FECHA: 2026-03-06
PROYECTO: pronto-libs,pronto-tests
SEVERIDAD: alta
TITULO: Reapertura de duplicación de Invoice al importar conftest.py
DESCRIPCION:
  Durante la validación del guard de `pronto-tests/conftest.py` reapareció la duplicación del
  modelo `Invoice`: todavía quedaba una definición residual en `business_models.py` además de la
  autoridad canónica en `order_models.py`.
PASOS_REPRODUCIR:
  1. Importar `pronto-tests/conftest.py` desde Python.
  2. Observar `InvalidRequestError: Table 'pronto_invoices' is already defined for this MetaData instance`.
RESULTADO_ACTUAL:
  El import de modelos fallaba por duplicación de `pronto_invoices`.
RESULTADO_ESPERADO:
  Debe existir una sola autoridad del modelo `Invoice`.
UBICACION:
  - `pronto-libs/src/pronto_shared/models/business_models.py`
  - `pronto-libs/src/pronto_shared/models/order_models.py`
EVIDENCIA:
  - `class Invoice(Base)` residual en `business_models.py`
  - `class Invoice(Base)` canónica en `order_models.py`
HIPOTESIS_CAUSA:
  La limpieza previa del duplicado quedó incompleta y persistió una copia residual en `business_models.py`.
ESTADO: RESUELTO
SOLUCION:
  Se eliminó la definición residual de `Invoice` en `business_models.py`, dejando la autoridad única
  en `order_models.py`. Después de eso, `pronto-tests/conftest.py` vuelve a importar correctamente.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06