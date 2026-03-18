ID: PRONTO-PAY-001
FECHA: 2026-03-15
PROYECTO: pronto-libs, pronto-api, pronto-static
SEVERIDAD: alta
TITULO: Estado AWAITING_PAYMENT_CONFIRMATION definido pero nunca utilizado
DESCRIPCION: El estado de sesión AWAITING_PAYMENT_CONFIRMATION está definido en constants.py pero nunca se establece en ningún flujo del sistema. Esto causa que las funciones de confirmación de pagos externos (como confirm_partial_payment) nunca funcionen correctamente ya que dependen de este estado para ejecutar su lógica.
PASOS_REPRODUCIR:
1. Intentar procesar un pago externo (QR, Stripe, etc.)
2. Observar que el estado de la sesión nunca cambia a AWAITING_PAYMENT_CONFIRMATION
3. Intentar confirmar el pago externo usando confirm_partial_payment
4. La función no ejecuta su lógica porque el estado no coincide
RESULTADO_ACTUAL: Los pagos externos no pueden ser confirmados automáticamente. El estado AWAITING_PAYMENT_CONFIRMATION es un estado huérfano.
RESULTADO_ESPERADO: El estado AWAITING_PAYMENT_CONFIRMATION debe establecerse cuando se inicia un pago externo y permitir la confirmación posterior.
UBICACION:
- pronto-libs/src/pronto_shared/constants.py:36
- pronto-libs/src/pronto_shared/services/order_service_impl.py:1024-1118
- pronto-libs/src/pronto_shared/services/order_payment_service.py:885-944
EVIDENCIA: Búsqueda exhaustiva en todo el código base muestra que AWAITING_PAYMENT_CONFIRMATION solo se verifica en comparaciones, nunca se asigna.
HIPOTESIS_CAUSA: El flujo de pagos externos fue diseñado pero nunca implementado completamente. La infraestructura básica existe pero falta la integración real.
ESTADO: ABIERTO