ID: TEST-002
FECHA: 2026-03-05
PROYECTO: pronto-tests
SEVERIDAD: alta
TITULO: Modelos con primary key UUID no generan ID automáticamente
DESCRIPCION: Los modelos MenuCategory, MenuItem, Order, OrderItem, DiningSession, Customer, Employee tienen primary key UUID pero no tienen default=uuid.uuid4 configurado correctamente, causando FlushError al intentar guardar sin ID explícito.
PASOS_REPRODUCIR:
1. Crear una instancia de MenuItem sin especificar ID
2. Hacer db_session.add(item) y db_session.commit()
3. Observar FlushError: "Instance has a NULL identity key"
RESULTADO_ACTUAL: FlushError porque el ID es NULL
RESULTADO_ESPERADO: El ID debería generarse automáticamente con uuid.uuid4
UBICACION: pronto-libs/src/pronto_shared/models/menu_models.py, user_models.py, order_models.py
EVIDENCIA: Los tests fallan con FlushError al crear registros sin ID explícito
HIPOTESIS_CAUSA: Los modelos usan UUID(as_uuid=True) pero no tienen default=uuid.uuid4 en la columna primary key
ESTADO: RESUELTO
SOLUCION: Se agregaron defaults UUID (`default=uuid.uuid4`) en modelos con PK UUID sin generación local (categorías/ítems/modificadores de menú, customer y entidades de orden), eliminando `NULL identity key` al persistir desde tests.
COMMIT: fea629d
FECHA_RESOLUCION: 2026-03-05
