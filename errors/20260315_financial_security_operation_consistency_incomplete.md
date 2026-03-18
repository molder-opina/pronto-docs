ID: PRONTO-PAY-078
FECHA: 2026-03-15
PROYECTO: pronto-libs, pronto-api
SEVERIDAD: crítica
TITULO: Consistencia de operaciones financieras con seguridad incompleta sin protección PCI DSS
DESCRIPCION: El sistema no implementa una protección adecuada PCI DSS para las operaciones financieras críticas. Cuando se procesan pagos con tarjetas de crédito o débito, no se garantiza la protección adecuada de los datos sensibles (PAN, CVV, fechas de expiración) ni se cumplen los requisitos de enmascaramiento, cifrado, y almacenamiento seguro requeridos por PCI DSS.
PASOS_REPRODUCIR:
1. Crear una sesión y procesar un pago con tarjeta de crédito
2. Observar cómo se manejan los datos sensibles de la tarjeta
3. Verificar si se enmascara el PAN en logs y displays
4. Comprobar si se cifran los datos sensibles en tránsito y en reposo
5. Analizar si se cumplen los requisitos PCI DSS para protección de datos
RESULTADO_ACTUAL: Sin protección adecuada PCI DSS para las operaciones financieras críticas, lo que pone en riesgo los datos sensibles de tarjetas y viola los requisitos regulatorios para el procesamiento de pagos con tarjetas de crédito y débito.
RESULTADO_ESPERADO: Debe existir una protección adecuada PCI DSS que garantice el enmascaramiento del PAN, el cifrado de datos sensibles en tránsito y en reposo, la no retención de datos sensibles innecesarios, y el cumplimiento de todos los requisitos PCI DSS para el procesamiento seguro de pagos con tarjetas.
UBICACION:
- pronto-libs/src/pronto_shared/models/order_models.py (modelo Payment)
- pronto-libs/src/pronto_shared/services/payment_service.py (procesamiento de pagos)
- pronto-libs/src/pronto_shared/security_service.py (servicio de seguridad)
- pronto-api/src/api_app/routes/payments.py (endpoints de pagos)
EVIDENCIA: El análisis del código muestra que no existe una protección adecuada PCI DSS para las operaciones financieras críticas, especialmente para el manejo de datos sensibles de tarjetas como PAN, CVV, y fechas de expiración que deben ser enmascarados, cifrados, y no retenidos innecesariamente.
HIPOTESIS_CAUSA: La implementación inicial no consideró adecuadamente los requisitos de seguridad PCI DSS para operaciones financieras en entornos de producción donde el procesamiento de pagos con tarjetas requiere cumplimiento estricto con estándares de seguridad para proteger los datos sensibles de los clientes.
ESTADO: ABIERTO