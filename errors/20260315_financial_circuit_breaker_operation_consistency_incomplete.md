ID: PRONTO-PAY-070
FECHA: 2026-03-15
PROYECTO: pronto-libs, pronto-api
SEVERIDAD: crítica
TITULO: Consistencia de operaciones financieras con circuit breaker incompleta sin patrón Circuit Breaker
DESCRIPCION: El sistema no implementa un patrón adecuado de Circuit Breaker para proteger las operaciones financieras contra fallos continuos de servicios externos. Cuando se procesan pagos externos y los servicios externos fallan continuamente, no se garantiza que el sistema entre en un estado de protección que evite sobrecargar los servicios fallidos.
PASOS_REPRODUCIR:
1. Crear una sesión y procesar múltiples pagos externos (Stripe, MercadoPago)
2. Simular fallos continuos del servicio externo
3. Observar si el sistema entra en un estado de protección
4. Verificar si se evita la sobrecarga del servicio externo fallido
5. Comprobar si existe un patrón de Circuit Breaker implementado
RESULTADO_ACTUAL: Sin patrón adecuado de Circuit Breaker para proteger las operaciones financieras contra fallos continuos de servicios externos, lo que puede causar sobrecarga de servicios fallidos y degradación del rendimiento del sistema completo.
RESULTADO_ESPERADO: Debe existir un patrón adecuado de Circuit Breaker que proteja las operaciones financieras contra fallos continuos de servicios externos, evitando la sobrecarga y permitiendo la recuperación gradual cuando los servicios externos vuelven a estar disponibles.
UBICACION:
- pronto-libs/src/pronto_shared/services/payment_providers/stripe_provider.py (proveedor Stripe)
- pronto-libs/src/pronto_shared/services/circuit_breaker_service.py (servicio de Circuit Breaker)
- pronto-client/src/pronto_clients/routes/api/stripe_webhooks.py (webhooks - proxy temporal)
EVIDENCIA: El análisis del código muestra que no existe un patrón adecuado de Circuit Breaker para proteger las operaciones financieras contra fallos continuos de servicios externos, especialmente para pagos que dependen de servicios externos que pueden fallar continuamente.
HIPOTESIS_CAUSA: La implementación inicial no consideró adecuadamente los requisitos de resiliencia para operaciones financieras en entornos de producción con dependencias externas que pueden fallar continuamente.
ESTADO: ABIERTO