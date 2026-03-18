ID: PRONTO-PAY-019
FECHA: 2026-03-15
PROYECTO: pronto-libs, pronto-client
SEVERIDAD: alta
TITULO: Proveedor Stripe incompleto sin manejo de webhooks
DESCRIPCION: El proveedor Stripe en pronto-libs crea PaymentIntents pero no maneja webhooks de confirmación. Además, el archivo stripe_webhooks.py en pronto-client es un proxy temporal DEPRECATED que no procesa realmente los webhooks, lo que deja la integración con Stripe incompleta.
PASOS_REPRODUCIR:
1. Analizar stripe_provider.py en pronto-libs
2. Observar que crea PaymentIntents pero no maneja webhooks
3. Analizar stripe_webhooks.py en pronto-client
4. Verificar que solo devuelve un mensaje de confirmación sin procesar nada
5. Intentar configurar pagos con Stripe y observar que no hay confirmación automática
RESULTADO_ACTUAL: Integración con Stripe incompleta que no puede manejar notificaciones automáticas de éxito/fallo de pagos.
RESULTADO_ESPERADO: Debe existir un handler real de webhooks en pronto-api que procese las notificaciones de Stripe y actualice automáticamente el estado del sistema.
UBICACION:
- pronto-libs/src/pronto_shared/services/payment_providers/stripe_provider.py
- pronto-client/src/pronto_clients/routes/api/stripe_webhooks.py
EVIDENCIA: El proveedor Stripe solo implementa la creación de PaymentIntents pero no el manejo de eventos. El webhook handler es un proxy temporal que no procesa realmente las notificaciones.
HIPOTESIS_CAUSA: La implementación de webhooks fue postergada o eliminada por razones de seguridad, dejando solo la infraestructura básica sin funcionalidad real.
ESTADO: ABIERTO