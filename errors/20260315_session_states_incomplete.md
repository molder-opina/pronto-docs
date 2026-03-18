ID: PRONTO-PAY-017
FECHA: 2026-03-15
PROYECTO: pronto-libs
SEVERIDAD: alta
TITULO: Estados de sesión incompletos y transiciones no implementadas
DESCRIPCION: El sistema define estados de sesión como AWAITING_PAYMENT_CONFIRMATION pero no implementa las transiciones necesarias para alcanzar estos estados. Además, faltan validaciones para asegurar que las sesiones solo se cierren cuando remaining_balance = 0, lo que puede causar inconsistencias financieras.
PASOS_REPRODUCIR:
1. Analizar los estados definidos en SessionStatus
2. Verificar qué transiciones están implementadas realmente
3. Observar que AWAITING_PAYMENT_CONFIRMATION nunca se establece
4. Procesar pagos parciales y verificar si remaining_balance se calcula correctamente
5. Intentar cerrar sesión con remaining_balance > 0
RESULTADO_ACTUAL: Estados definidos pero no utilizados, y falta de validación para garantizar que las sesiones solo se cierren cuando el saldo restante sea cero.
RESULTADO_ESPERADO: Todos los estados deben tener transiciones implementadas, y debe existir validación para garantizar invariantes financieros como remaining_balance = 0 al cerrar sesión.
UBICACION:
- pronto-libs/src/pronto_shared/constants.py:36 (AWAITING_PAYMENT_CONFIRMATION)
- pronto-libs/src/pronto_shared/models/order_models.py (DiningSession)
- pronto-libs/src/pronto_shared/services/payment_service.py (process_partial_payment)
EVIDENCIA: El estado AWAITING_PAYMENT_CONFIRMATION está definido pero nunca se establece en ningún flujo. Además, no existe validación explícita que impida cerrar sesiones con remaining_balance > 0.
HIPOTESIS_CAUSA: Los estados fueron diseñados para soportar flujos avanzados (pagos externos, confirmaciones) pero nunca se implementaron completamente, dejando estados huérfanos y validaciones incompletas.
ESTADO: ABIERTO