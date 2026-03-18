ID: PRONTO-PAY-068
FECHA: 2026-03-15
PROYECTO: pronto-libs, pronto-api
SEVERIDAD: crítica
TITULO: Consistencia de operaciones financieras con timeouts incompleta sin manejo adecuado de expiración
DESCRIPCION: El sistema no implementa un manejo adecuado de timeouts para operaciones financieras que requieren confirmación posterior. Cuando se procesan pagos externos (QR) y ocurre una expiración del tiempo de espera, no se garantiza que el estado del sistema se actualice adecuadamente o que se notifique al usuario sobre la expiración.
PASOS_REPRODUCIR:
1. Crear una sesión y procesar un pago externo (QR)
2. Observar el estado AWAITING_PAYMENT_CONFIRMATION
3. Esperar hasta que expire el tiempo de espera configurado
4. Verificar si el estado se actualiza adecuadamente
5. Comprobar si existe manejo adecuado de timeouts y expiración
RESULTADO_ACTUAL: Sin manejo adecuado de timeouts para operaciones financieras que requieren confirmación posterior, lo que puede causar estados inconsistentes cuando ocurren expiraciones de tiempo de espera sin actualización adecuada del estado del sistema.
RESULTADO_ESPERADO: Debe existir un manejo adecuado de timeouts que garantice que el estado del sistema se actualice adecuadamente cuando ocurren expiraciones de tiempo de espera, con notificaciones adecuadas al usuario y mecanismos de recuperación.
UBICACION:
- pronto-libs/src/pronto_shared/services/order_service_impl.py (confirm_partial_payment)
- pronto-libs/src/pronto_shared/constants.py (AWAITING_PAYMENT_CONFIRMATION)
- pronto-libs/src/pronto_shared/services/timeout_service.py (servicio de timeouts)
EVIDENCIA: El análisis del código muestra que no existe un manejo adecuado de timeouts para operaciones financieras que requieren confirmación posterior, especialmente para pagos externos que pueden expirar sin actualización adecuada del estado del sistema.
HIPOTESIS_CAUSA: La implementación inicial no consideró adecuadamente los requisitos de manejo de timeouts para operaciones financieras en entornos de producción con alta disponibilidad y experiencia de usuario consistente.
ESTADO: ABIERTO