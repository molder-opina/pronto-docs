ID: PRONTO-PAY-047
FECHA: 2026-03-15
PROYECTO: pronto-libs, pronto-api
SEVERIDAD: crítica
TITULO: Integridad referencial financiera incompleta sin validación de relaciones
DESCRIPCION: El sistema no valida adecuadamente la integridad referencial financiera entre sesiones, órdenes y pagos. No existen mecanismos para garantizar que todos los pagos estén asociados a sesiones válidas, o que las órdenes pertenezcan a sesiones activas, lo que puede causar inconsistencias financieras graves.
PASOS_REPRODUCIR:
1. Crear una sesión y procesar un pago
2. Eliminar o cerrar la sesión manualmente
3. Observar si los pagos asociados se mantienen consistentes
4. Verificar si existe validación de integridad referencial
RESULTADO_ACTUAL: Sin validación adecuada de integridad referencial financiera entre sesiones, órdenes y pagos, lo que puede causar inconsistencias financieras graves cuando se modifican o eliminan entidades relacionadas.
RESULTADO_ESPERADO: Deben existir mecanismos adecuados de validación de integridad referencial financiera que garanticen que todas las relaciones entre sesiones, órdenes y pagos sean consistentes y válidas.
UBICACION:
- pronto-libs/src/pronto_shared/models/order_models.py (relaciones entre entidades)
- pronto-libs/src/pronto_shared/services/payment_service.py (procesamiento de pagos)
EVIDENCIA: El análisis del código muestra que no existen mecanismos adecuados de validación de integridad referencial financiera entre las entidades relacionadas.
HIPOTESIS_CAUSA: La implementación inicial se enfocó en las relaciones básicas sin considerar adecuadamente los requisitos de integridad referencial financiera en escenarios complejos de modificación o eliminación de entidades.
ESTADO: ABIERTO