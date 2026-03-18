ID: PRONTO-PAY-036
FECHA: 2026-03-15
PROYECTO: pronto-libs, pronto-api
SEVERIDAD: media
TITULO: Cancelación de ítems incompleta sin integración con pagos parciales
DESCRIPCION: El sistema permite cancelar ítems de órdenes, pero no está claro cómo se integra esta funcionalidad con los pagos parciales y la lógica de cierre de sesiones. Cuando se cancela un ítem después de procesar pagos parciales, no está garantizado que los totales se recalculen adecuadamente o que se manejen los reembolsos necesarios.
PASOS_REPRODUCIR:
1. Crear una sesión con múltiples ítems
2. Procesar un pago parcial
3. Cancelar un ítem que ya fue pagado parcialmente
4. Observar cómo se manejan los totales y si se generan reembolsos
5. Verificar si hay inconsistencias en los saldos
RESULTADO_ACTUAL: Cancelación de ítems sin integración clara con pagos parciales, lo que puede causar inconsistencias en los totales y saldos financieros.
RESULTADO_ESPERADO: La cancelación de ítems debe integrarse adecuadamente con los pagos parciales, recalculando los totales y generando reembolsos cuando sea necesario.
UBICACION:
- pronto-libs/src/pronto_shared/services/order_service_impl.py (cancelación de ítems)
- pronto-libs/src/pronto_shared/services/payment_service.py (pagos parciales)
- pronto-libs/src/pronto_shared/models/order_models.py (cálculo de totales)
EVIDENCIA: El análisis del código muestra que la cancelación de ítems y los pagos parciales son funcionalidades separadas sin integración clara, lo que puede causar inconsistencias financieras.
HIPOTESIS_CAUSA: Las funcionalidades se implementaron de manera incremental sin considerar adecuadamente la necesidad de integración entre cancelación de ítems y pagos parciales.
ESTADO: ABIERTO