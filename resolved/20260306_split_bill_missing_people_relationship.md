ID: TEST-20260306-012
FECHA: 2026-03-06
PROYECTO: pronto-libs,pronto-api
SEVERIDAD: alta
TITULO: SplitBill create falla porque el modelo no expone relación people
DESCRIPCION:
  El flujo real de `POST /api/split-bills/sessions/<id>/create` terminaba en 500 porque
  `split_bill_service_core._serialize_split_bill()` iteraba `split.people`, pero el modelo
  exportado por `pronto_shared.models` no exponía esa relación ORM.
PASOS_REPRODUCIR:
  1. Crear una sesión válida.
  2. Ejecutar `POST /api/split-bills/sessions/<id>/create` con `split_type=equal`.
  3. Observar `AttributeError: 'SplitBill' object has no attribute 'people'`.
RESULTADO_ACTUAL:
  El endpoint de creación de split bill respondía 500.
RESULTADO_ESPERADO:
  Debe serializar la división creada con su colección de personas/pagos sin lanzar excepciones.
UBICACION:
  - `pronto-libs/src/pronto_shared/models/business_models.py`
  - `pronto-libs/src/pronto_shared/services/split_bill_service_core.py`
EVIDENCIA:
  - Stack trace: `_serialize_split_bill -> for p in split.people`
  - `AttributeError: 'SplitBill' object has no attribute 'people'`
HIPOTESIS_CAUSA:
  Drift entre el servicio y la definición/exportación del modelo relacional de split bill.
ESTADO: RESUELTO
SOLUCION:
  Se agregaron las relaciones ORM faltantes (`people`, `assignments`, `split_bill`, `person`,
  `order_item`) en `business_models.py`, que es la autoridad exportada por `pronto_shared.models`.
  Además se simplificó la carga eager de `get_active_split()` para no traer `assignments/order_item`
  innecesarios y se evitó tocar `dining_session.orders` cuando la sesión no tiene órdenes, lo que
  deja operativo el flujo real `create/get/pay` de split bill.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06