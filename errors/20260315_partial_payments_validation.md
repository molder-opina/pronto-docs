ID: PRONTO-PAY-034
FECHA: 2026-03-15
PROYECTO: pronto-libs
SEVERIDAD: alta
TITULO: Validación incompleta en pagos parciales sin protección contra montos inválidos
DESCRIPCION: El sistema no valida adecuadamente los montos en pagos parciales, lo que puede permitir pagos con montos negativos, cero, o superiores al saldo restante. Esto puede causar inconsistencias financieras graves y corrupción de datos.
PASOS_REPRODUCIR:
1. Crear una sesión con un total específico
2. Intentar procesar un pago parcial con monto negativo
3. Intentar procesar un pago parcial con monto cero
4. Intentar procesar un pago parcial con monto superior al saldo restante
5. Observar si se permiten estos pagos inválidos
RESULTADO_ACTUAL: Pagos parciales sin validación adecuada de montos, lo que puede permitir operaciones financieras inválidas y causar inconsistencias en los totales.
RESULTADO_ESPERADO: Todos los pagos parciales deben validar que el monto sea positivo, mayor que cero, y no superior al saldo restante de la sesión.
UBICACION:
- pronto-libs/src/pronto_shared/services/payment_service.py (process_partial_payment)
- pronto-libs/src/pronto_shared/models/order_models.py (DiningSession)
EVIDENCIA: El análisis del código muestra que la función process_partial_payment no valida adecuadamente los montos de los pagos parciales, lo que puede permitir operaciones financieras inválidas.
HIPOTESIS_CAUSA: La implementación inicial se enfocó en la funcionalidad básica sin considerar adecuadamente la necesidad de validación de montos para garantizar la integridad financiera.
ESTADO: ABIERTO