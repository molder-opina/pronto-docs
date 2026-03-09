ID: TEST-20260306-009
FECHA: 2026-03-06
PROYECTO: pronto-libs,pronto-tests
SEVERIDAD: bloqueante
TITULO: Duplicación de Invoice en business_models.py rompe imports de pytest
DESCRIPCION:
  La carga de `pronto_shared.models` quedaba bloqueada por una definición duplicada de la tabla
  `pronto_invoices` dentro de `business_models.py`, además del modelo canónico existente en
  `order_models.py`.
PASOS_REPRODUCIR:
  1. Ejecutar cualquier pytest que cargue `pronto-tests/conftest.py`.
  2. Observar `InvalidRequestError: Table 'pronto_invoices' is already defined for this MetaData instance`.
RESULTADO_ACTUAL:
  Pytest no arrancaba porque el import de modelos fallaba antes de la colección.
RESULTADO_ESPERADO:
  Debe existir una sola autoridad del modelo `Invoice` y el import de `pronto_shared.models` debe funcionar.
UBICACION:
  - `pronto-libs/src/pronto_shared/models/business_models.py`
  - `pronto-libs/src/pronto_shared/models/order_models.py`
EVIDENCIA:
  - `class Invoice(Base)` duplicada en `business_models.py`
  - `class Invoice(Base)` canónica en `order_models.py`
HIPOTESIS_CAUSA:
  Se copió/pegó el modelo de factura dentro de `business_models.py` y quedó conviviendo con la autoridad ya existente en `order_models.py`.
ESTADO: RESUELTO
SOLUCION:
  Se eliminaron las definiciones duplicadas de `Invoice` en `business_models.py`, dejando la autoridad única en `order_models.py`. Con eso `pronto_shared.models` vuelve a importar correctamente y pytest puede colectar tests.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06
