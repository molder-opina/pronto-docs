ID: PRONTO-PAY-012
FECHA: 2026-03-15
PROYECTO: pronto-libs
SEVERIDAD: alta
TITULO: Inconsistencia en cálculo de totales y saldos financieros
DESCRIPCION: Existen múltiples lugares donde se calculan y actualizan totales financieros (subtotal, tax_amount, tip_amount, total_amount, total_paid) en DiningSession y Order. Algunas actualizaciones son directas mientras que otras usan funciones como recompute_totals(). Esto puede causar inconsistencias en los cálculos financieros si no se mantienen sincronizados todos los campos.
PASOS_REPRODUCIR:
1. Analizar cómo se actualizan los totales en DiningSession
2. Verificar las llamadas a recompute_totals() vs actualizaciones directas
3. Observar si total_paid se actualiza consistentemente cuando se procesan pagos
4. Verificar si los cálculos excluyen correctamente órdenes canceladas
RESULTADO_ACTUAL: Múltiples mecanismos para actualizar totales financieros que pueden causar inconsistencias si no se mantienen sincronizados.
RESULTADO_ESPERADO: Un único mecanismo canónico para calcular y actualizar totales financieros que garantice consistencia.
UBICACION:
- pronto-libs/src/pronto_shared/models/order_models.py (DiningSession.recompute_totals)
- pronto-libs/src/pronto_shared/services/payment_service.py (process_partial_payment)
- pronto-libs/src/pronto_shared/services/order_payment_service.py (finalize_payment)
EVIDENCIA: El análisis del código muestra que algunos métodos actualizan directamente total_paid mientras que otros llaman a recompute_totals(). También hay lógica duplicada para calcular totales en diferentes servicios.
HIPOTESIS_CAUSA: La funcionalidad de pagos parciales y totales fue implementada incrementalmente sin establecer un único punto canónico para los cálculos financieros.
ESTADO: RESUELTO