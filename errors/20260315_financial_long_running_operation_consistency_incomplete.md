ID: PRONTO-PAY-066
FECHA: 2026-03-15
PROYECTO: pronto-libs, pronto-api
SEVERIDAD: crítica
TITULO: Consistencia de operaciones financieras de larga duración incompleta sin patrón Long-Running Transaction
DESCRIPCION: El sistema no implementa un patrón adecuado de Long-Running Transaction para garantizar la consistencia de operaciones financieras que se extienden en el tiempo. Cuando se procesan pagos externos (QR, webhooks) que requieren confirmación posterior, no se garantiza que el estado del sistema permanezca consistente durante todo el período de espera.
PASOS_REPRODUCIR:
1. Crear una sesión y procesar un pago externo (QR)
2. Observar el estado AWAITING_PAYMENT_CONFIRMATION
3. Simular un fallo del sistema durante el período de espera
4. Verificar si el estado se mantiene consistente después de la recuperación
5. Comprobar si existe un patrón de Long-Running Transaction implementado
RESULTADO_ACTUAL: Sin patrón adecuado de Long-Running Transaction para garantizar la consistencia de operaciones financieras de larga duración, lo que puede causar inconsistencias financieras graves cuando ocurren fallos del sistema durante períodos de espera prolongados.
RESULTADO_ESPERADO: Debe existir un patrón adecuado de Long-Running Transaction que garantice que el estado del sistema permanezca consistente durante todo el período de operaciones financieras de larga duración, con mecanismos adecuados de recuperación ante fallos.
UBICACION:
- pronto-libs/src/pronto_shared/services/order_service_impl.py (confirm_partial_payment)
- pronto-libs/src/pronto_shared/constants.py (AWAITING_PAYMENT_CONFIRMATION)
- pronto-libs/src/pronto_shared/services/long_running_transaction_service.py (servicio de Long-Running Transaction)
EVIDENCIA: El análisis del código muestra que no existe un patrón adecuado de Long-Running Transaction para garantizar la consistencia de operaciones financieras que se extienden en el tiempo, especialmente para pagos externos que requieren confirmación posterior.
HIPOTESIS_CAUSA: La implementación inicial no consideró adecuadamente los requisitos de consistencia para operaciones financieras de larga duración en entornos de producción con alta disponibilidad y tolerancia a fallos.
ESTADO: ABIERTO