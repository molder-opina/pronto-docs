ID: PRONTO-PAY-025
FECHA: 2026-03-15
PROYECTO: pronto-libs
SEVERIDAD: alta
TITULO: Problemas de precisión en cálculos financieros y redondeo
DESCRIPCION: El sistema realiza cálculos financieros con posibles problemas de precisión debido al uso de tipos de datos inadecuados y falta de estrategias consistentes de redondeo. Esto puede causar discrepancias en los totales, especialmente en operaciones con impuestos, propinas y pagos parciales.
PASOS_REPRODUCIR:
1. Analizar los tipos de datos usados para campos financieros (subtotal, tax_amount, tip_amount, total_amount, total_paid)
2. Verificar las estrategias de redondeo utilizadas en cálculos
3. Procesar pagos parciales con montos que requieren redondeo
4. Observar posibles discrepancias en los totales finales
RESULTADO_ACTUAL: Cálculos financieros que pueden tener problemas de precisión debido a tipos de datos inadecuados y falta de estrategias consistentes de redondeo, lo que puede causar discrepancias financieras.
RESULTADO_ESPERADO: Todos los cálculos financieros deben usar tipos de datos adecuados (Decimal) y estrategias consistentes de redondeo para garantizar la precisión financiera.
UBICACION:
- pronto-libs/src/pronto_shared/models/order_models.py (campos financieros)
- pronto-libs/src/pronto_shared/services/payment_service.py (cálculos de pagos)
- pronto-libs/src/pronto_shared/services/order_payment_service.py (cálculos de totales)
EVIDENCIA: El análisis del código muestra que los campos financieros usan tipos float en lugar de Decimal, y no existe una estrategia consistente de redondeo para operaciones financieras.
HIPOTESIS_CAUSA: La implementación inicial no consideró adecuadamente los requisitos de precisión financiera, usando tipos de datos inadecuados para cálculos monetarios.
ESTADO: ABIERTO