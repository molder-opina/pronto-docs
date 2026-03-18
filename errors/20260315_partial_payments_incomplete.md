ID: PRONTO-PAY-018
FECHA: 2026-03-15
PROYECTO: pronto-libs
SEVERIDAD: alta
TITULO: Pagos parciales por órdenes específicas no implementados completamente
DESCRIPCION: La función confirm_partial_payment existe pero asume que hay un flujo de pago externo que establece el estado AWAITING_PAYMENT_CONFIRMATION. Sin embargo, este estado nunca se establece en ningún flujo real, lo que hace que la funcionalidad de pago parcial por órdenes específicas dentro de una sesión no funcione correctamente.
PASOS_REPRODUCIR:
1. Crear una sesión con múltiples órdenes
2. Intentar pagar solo algunas órdenes específicas
3. Observar que la función confirm_partial_payment no ejecuta su lógica porque el estado no es AWAITING_PAYMENT_CONFIRMATION
4. Verificar que no hay manera de establecer el estado AWAITING_PAYMENT_CONFIRMATION
RESULTADO_ACTUAL: La funcionalidad de pago parcial por órdenes específicas está implementada pero no funciona debido a la falta del estado necesario AWAITING_PAYMENT_CONFIRMATION.
RESULTADO_ESPERADO: Debe existir un flujo completo que permita establecer AWAITING_PAYMENT_CONFIRMATION y luego confirmar pagos parciales por órdenes específicas.
UBICACION:
- pronto-libs/src/pronto_shared/services/order_service_impl.py:1024-1118 (confirm_partial_payment)
- pronto-libs/src/pronto_shared/constants.py:36 (AWAITING_PAYMENT_CONFIRMATION)
EVIDENCIA: La función confirm_partial_payment verifica si session.status == SessionStatus.AWAITING_PAYMENT_CONFIRMATION, pero este estado nunca se establece en ningún lugar del sistema.
HIPOTESIS_CAUSA: El flujo de pagos parciales por órdenes específicas fue diseñado pero nunca se implementó completamente, dejando la función sin poder ser utilizada.
ESTADO: ABIERTO