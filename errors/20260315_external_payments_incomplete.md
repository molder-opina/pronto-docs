ID: PRONTO-PAY-029
FECHA: 2026-03-15
PROYECTO: pronto-libs, pronto-api
SEVERIDAD: alta
TITULO: Pagos externos incompletos sin flujo de confirmación real
DESCRIPCION: El sistema define estados y funciones para pagos externos (QR, webhooks) pero no implementa un flujo de confirmación real. El estado AWAITING_PAYMENT_CONFIRMATION existe pero nunca se establece, y no hay mecanismos para confirmar automáticamente pagos externos cuando se reciben notificaciones.
PASOS_REPRODUCIR:
1. Analizar los estados definidos para pagos externos
2. Verificar si existe un flujo real para establecer AWAITING_PAYMENT_CONFIRMATION
3. Intentar configurar pagos externos y observar que no hay confirmación automática
4. Verificar que las funciones de confirmación no se pueden ejecutar porque el estado necesario no se establece
RESULTADO_ACTUAL: Infraestructura básica para pagos externos sin implementación real del flujo de confirmación, lo que hace que la funcionalidad no sea utilizable en producción.
RESULTADO_ESPERADO: Debe existir un flujo completo que permita establecer AWAITING_PAYMENT_CONFIRMATION y confirmar automáticamente pagos externos mediante webhooks o confirmación manual.
UBICACION:
- pronto-libs/src/pronto_shared/constants.py:36 (AWAITING_PAYMENT_CONFIRMATION)
- pronto-libs/src/pronto_shared/services/order_service_impl.py:1024-1118 (confirm_partial_payment)
- pronto-client/src/pronto_clients/routes/api/stripe_webhooks.py (proxy temporal)
EVIDENCIA: El estado AWAITING_PAYMENT_CONFIRMATION está definido pero nunca se establece en ningún flujo real, y no existen handlers reales de webhooks en pronto-api para procesar notificaciones de pagos externos.
HIPOTESIS_CAUSA: La funcionalidad fue diseñada pero nunca se implementó completamente, dejando solo la infraestructura básica sin el flujo real de confirmación.
ESTADO: ABIERTO