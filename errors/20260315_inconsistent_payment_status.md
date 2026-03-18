ID: PRONTO-PAY-008
FECHA: 2026-03-15
PROYECTO: pronto-libs
SEVERIDAD: alta
TITULO: Inconsistencia en estados de pago entre sesión y enum PaymentStatus
DESCRIPCION: Existe una inconsistencia crítica entre los estados de pago utilizados en DiningSession y el enum PaymentStatus. La sesión usa "pending" como valor por defecto (string hardcoded), mientras que el enum PaymentStatus no incluye este valor, causando potenciales errores de validación y comportamiento impredecible.
PASOS_REPRODUCIR:
1. Analizar DiningSession en order_models.py línea 114: default="pending"
2. Analizar PaymentStatus enum en constants.py líneas 22-28
3. Observar que "pending" no está incluido en el enum
4. Intentar validar estados de pago usando el enum cuando la sesión tiene "pending"
RESULTADO_ACTUAL: Dos sistemas paralelos de estados de pago con valores diferentes, causando inconsistencias y posibles errores de validación.
RESULTADO_ESPERADO: Un único sistema de estados de pago consistente en todo el sistema.
UBICACION:
- pronto-libs/src/pronto_shared/models/order_models.py:114
- pronto-libs/src/pronto_shared/constants.py:22-28
EVIDENCIA: La definición del modelo DiningSession establece payment_status con default="pending", pero el enum PaymentStatus define valores como "unpaid", "awaiting_tip", "processing", etc., sin incluir "pending".
HIPOTESIS_CAUSA: El modelo de sesión fue implementado antes de definir el enum PaymentStatus, o no se actualizó para usar los valores canónicos del enum.
ESTADO: RESUELTO