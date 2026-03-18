ID: PRONTO-PAY-041
FECHA: 2026-03-15
PROYECTO: pronto-libs, pronto-api, pronto-client
SEVERIDAD: alta
TITULO: Integración con sistemas externos incompleta sin manejo real de webhooks
DESCRIPCION: El sistema define infraestructura para integración con sistemas externos (Stripe, MercadoPago) pero no implementa manejo real de webhooks. Los archivos de webhook son proxies temporales DEPRECATED que no procesan realmente las notificaciones, lo que deja la integración incompleta y no funcional en producción.
PASOS_REPRODUCIR:
1. Analizar los archivos de webhook en pronto-client
2. Observar que son proxies temporales DEPRECATED
3. Verificar que no existen handlers reales en pronto-api
4. Intentar configurar pagos con sistemas externos y observar que no hay confirmación automática
RESULTADO_ACTUAL: Integración con sistemas externos incompleta que no puede manejar notificaciones automáticas de éxito/fallo de pagos, dejando la funcionalidad no utilizable en producción.
RESULTADO_ESPERADO: Debe existir una implementación completa de webhooks en pronto-api que procese realmente las notificaciones de sistemas externos y actualice automáticamente el estado del sistema.
UBICACION:
- pronto-client/src/pronto_clients/routes/api/stripe_webhooks.py (proxy temporal DEPRECATED)
- pronto-libs/src/pronto_shared/services/payment_providers/stripe_provider.py (solo crea PaymentIntents)
- pronto-api/src/api_app/routes/ (falta implementación real de webhooks)
EVIDENCIA: El análisis del código muestra que los archivos de webhook son proxies temporales que no procesan realmente las notificaciones, y no existen handlers reales en pronto-api para manejar webhooks.
HIPOTESIS_CAUSA: La implementación de webhooks fue postergada o eliminada por razones de seguridad, dejando solo la infraestructura básica sin funcionalidad real.
ESTADO: ABIERTO