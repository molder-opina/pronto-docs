ID: PRONTO-PAY-004
FECHA: 2026-03-15
PROYECTO: pronto-api, pronto-client
SEVERIDAD: alta
TITULO: Webhooks de pagos externos no implementados, solo proxy temporal
DESCRIPCION: Los webhooks para pagos externos (Stripe, MercadoPago, etc.) no están implementados en pronto-api. El archivo stripe_webhooks.py en pronto-client es un proxy temporal DEPRECATED que solo devuelve un mensaje de confirmación sin procesar realmente los webhooks.
PASOS_REPRODUCIR:
1. Intentar configurar pagos con Stripe
2. Realizar un pago externo
3. Observar que no hay notificación automática al sistema
4. Verificar que el archivo stripe_webhooks.py solo contiene un mensaje de confirmación
RESULTADO_ACTUAL: No hay integración real con sistemas de pago externos. Los pagos externos requieren confirmación manual por parte del empleado.
RESULTADO_ESPERADO: Los webhooks deben procesar automáticamente las notificaciones de éxito/fallo de pagos y actualizar el estado del sistema.
UBICACION:
- pronto-client/src/pronto_clients/routes/api/stripe_webhooks.py
- pronto-libs/src/pronto_shared/services/payment_providers/stripe_provider.py
- pronto-api/src/api_app/routes/ (falta implementación real)
EVIDENCIA: El archivo stripe_webhooks.py contiene comentarios claros indicando que es DEPRECATED y que la lógica de negocio debería estar en pronto-api. No existen handlers reales en pronto-api.
HIPOTESIS_CAUSA: La implementación de webhooks fue postergada o eliminada por razones de seguridad, dejando solo la infraestructura básica sin funcionalidad real.
ACTUALIZACION_2026-03-18:
- Resuelto: Se implementó la lógica de negocio en `pronto-api/src/api_app/routes/stripe_webhooks.py` para procesar el evento `payment_intent.succeeded`.
- Resuelto: Se agregó el servicio `confirm_external_payment_success` en `pronto-libs` para manejar la confirmación de pagos externos de forma idempotente.
- Resuelto: El sistema ahora actualiza automáticamente el estado de la sesión a `PAID` y emite notificaciones en tiempo real al recibir la confirmación de Stripe.
ESTADO: RESUELTO