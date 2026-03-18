ID: PRONTO-PAY-027
FECHA: 2026-03-15
PROYECTO: pronto-libs
SEVERIDAD: alta
TITULO: Lógica de cierre de sesión incompleta sin validación de invariantes
DESCRIPCION: El sistema no valida adecuadamente los invariantes financieros al cerrar sesiones. Aunque se calcula remaining_balance, no existe validación explícita que impida cerrar sesiones con remaining_balance > 0, lo que puede causar inconsistencias financieras graves.
PASOS_REPRODUCIR:
1. Crear una sesión con órdenes
2. Procesar un pago parcial (menor que el total)
3. Intentar cerrar la sesión manualmente
4. Observar que la sesión se cierra aunque remaining_balance > 0
RESULTADO_ACTUAL: Sesiones pueden cerrarse con remaining_balance > 0, violando el invariante financiero fundamental de que las sesiones solo deben cerrarse cuando el saldo restante sea cero.
RESULTADO_ESPERADO: Debe existir validación explícita que impida cerrar sesiones con remaining_balance > 0, garantizando la integridad financiera del sistema.
UBICACION:
- pronto-libs/src/pronto_shared/models/order_models.py (DiningSession)
- pronto-libs/src/pronto_shared/services/payment_service.py (process_partial_payment)
- pronto-libs/src/pronto_shared/services/order_payment_service.py (finalize_payment)
EVIDENCIA: El análisis del código muestra que aunque se calcula remaining_balance, no existe validación que impida cerrar sesiones con saldo pendiente, lo que viola el invariante financiero fundamental.
HIPOTESIS_CAUSA: La implementación inicial no consideró adecuadamente la necesidad de validar invariantes financieros al cerrar sesiones, enfocándose solo en la funcionalidad básica.
ACTUALIZACION_2026-03-18:
- Resuelto: Se añadió validación de invariante financiero en `close_session` (force close).
- Resuelto: Ahora el sistema impide el cierre manual de una sesión si el saldo pendiente (`remaining_balance`) es mayor a $0.01.
- Resuelto: Se obliga a que las órdenes sean canceladas individualmente o se liquide el pago total antes de permitir el cierre de la sesión, protegiendo la integridad de los reportes de ventas.
ESTADO: RESUELTO