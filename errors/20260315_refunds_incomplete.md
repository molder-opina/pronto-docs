ID: PRONTO-PAY-037
FECHA: 2026-03-15
PROYECTO: pronto-libs, pronto-api
SEVERIDAD: alta
TITULO: Funcionalidad de reembolsos incompleta sin implementación real
DESCRIPCION: El sistema define el estado PaymentStatus.REFUNDED pero no implementa funcionalidad real de reembolsos. No existen endpoints, servicios, o lógica para procesar reembolsos reales, lo que deja esta funcionalidad como un estado huérfano sin utilidad práctica.
PASOS_REPRODUCIR:
1. Analizar los estados definidos en PaymentStatus
2. Observar que REFUNDED está definido pero no se utiliza
3. Buscar endpoints o servicios para procesar reembolsos
4. Verificar que no existe implementación real de reembolsos
RESULTADO_ACTUAL: Estado REFUNDED definido pero sin implementación real de funcionalidad de reembolsos, lo que deja esta capacidad como un estado huérfano sin utilidad práctica.
RESULTADO_ESPERADO: Debe existir una implementación completa de reembolsos con endpoints, servicios, y lógica para procesar reembolsos reales y actualizar adecuadamente los estados y totales.
UBICACION:
- pronto-libs/src/pronto_shared/constants.py:27 (PaymentStatus.REFUNDED)
- pronto-libs/src/pronto_shared/models/order_models.py (modelo Payment)
- pronto-api/src/api_app/routes/ (falta implementación de reembolsos)
EVIDENCIA: El análisis del código muestra que el estado REFUNDED está definido pero no se utiliza en ningún flujo real, y no existen endpoints o servicios para procesar reembolsos.
HIPOTESIS_CAUSA: La funcionalidad de reembolsos fue planeada pero nunca se implementó, dejando solo el estado definido sin la lógica asociada.
ESTADO: ABIERTO