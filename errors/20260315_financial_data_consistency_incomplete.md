ID: PRONTO-PAY-048
FECHA: 2026-03-15
PROYECTO: pronto-libs, pronto-api
SEVERIDAD: crítica
TITULO: Consistencia de datos financieros incompleta sin sincronización garantizada
DESCRIPCION: El sistema no garantiza la consistencia de datos financieros entre diferentes fuentes de verdad. Los totales calculados pueden diferir de los pagos procesados debido a la falta de sincronización garantizada entre las operaciones de cálculo y las operaciones de pago.
PASOS_REPRODUCIR:
1. Crear una sesión con múltiples órdenes
2. Procesar pagos parciales simultáneamente
3. Consultar los totales calculados y los pagos procesados
4. Observar si hay discrepancias entre los valores
5. Verificar si existe mecanismo de sincronización garantizada
RESULTADO_ACTUAL: Sin garantía de consistencia de datos financieros entre diferentes fuentes de verdad, lo que puede causar discrepancias entre totales calculados y pagos procesados.
RESULTADO_ESPERADO: Debe existir un mecanismo de sincronización garantizada que asegure la consistencia de datos financieros entre todas las fuentes de verdad del sistema.
UBICACION:
- pronto-libs/src/pronto_shared/models/order_models.py (cálculo de totales)
- pronto-libs/src/pronto_shared/services/payment_service.py (procesamiento de pagos)
EVIDENCIA: El análisis del código muestra que no existe mecanismo de sincronización garantizada entre las operaciones de cálculo de totales y las operaciones de procesamiento de pagos.
HIPOTESIS_CAUSA: La implementación inicial no consideró adecuadamente los requisitos de consistencia de datos financieros en entornos distribuidos o concurrentes.
ESTADO: ABIERTO