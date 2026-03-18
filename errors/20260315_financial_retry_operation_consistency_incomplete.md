ID: PRONTO-PAY-069
FECHA: 2026-03-15
PROYECTO: pronto-libs, pronto-api
SEVERIDAD: crítica
TITULO: Consistencia de operaciones financieras con retry incompleta sin estrategia adecuada de reintentos
DESCRIPCION: El sistema no implementa una estrategia adecuada de reintentos para operaciones financieras que pueden fallar temporalmente. Cuando se procesan pagos externos o se realizan operaciones con servicios externos que pueden fallar temporalmente, no se garantiza que los reintentos se realicen de manera segura sin causar duplicación o inconsistencias.
PASOS_REPRODUCIR:
1. Crear una sesión y procesar un pago externo (Stripe, MercadoPago)
2. Simular una falla temporal del servicio externo
3. Observar si se realizan reintentos automáticos
4. Verificar si los reintentos son seguros y no causan duplicación
5. Comprobar si existe una estrategia adecuada de reintentos con backoff exponencial
RESULTADO_ACTUAL: Sin estrategia adecuada de reintentos para operaciones financieras que pueden fallar temporalmente, lo que puede causar duplicación de pagos o inconsistencias financieras cuando se realizan reintentos inseguros.
RESULTADO_ESPERADO: Debe existir una estrategia adecuada de reintentos con backoff exponencial y garantía de idempotencia que asegure que los reintentos sean seguros y no causen duplicación o inconsistencias financieras.
UBICACION:
- pronto-libs/src/pronto_shared/services/payment_providers/stripe_provider.py (proveedor Stripe)
- pronto-libs/src/pronto_shared/services/retry_service.py (servicio de reintentos)
- pronto-client/src/pronto_clients/routes/api/stripe_webhooks.py (webhooks - proxy temporal)
EVIDENCIA: El análisis del código muestra que no existe una estrategia adecuada de reintentos para operaciones financieras con servicios externos, especialmente para pagos que pueden fallar temporalmente y requerir reintentos seguros.
HIPOTESIS_CAUSA: La implementación inicial no consideró adecuadamente los requisitos de reintentos seguros para operaciones financieras en entornos de producción con servicios externos que pueden tener fallos temporales.
ESTADO: ABIERTO