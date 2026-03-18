ID: PRONTO-PAY-024
FECHA: 2026-03-15
PROYECTO: pronto-libs
SEVERIDAD: alta
TITULO: Violación de separación de dominios entre órdenes y pagos
DESCRIPCION: El sistema viola el principio de separación de dominios entre órdenes (cocina) y pagos (financiero). Aunque se definen estados separados, existen dependencias cruzadas y lógica que mezcla ambos dominios, lo que puede causar inconsistencias financieras y operativas.
PASOS_REPRODUCIR:
1. Analizar las relaciones entre Order y Payment
2. Observar que algunas funciones de pago afectan directamente el estado de las órdenes
3. Verificar que no existe una separación clara entre el dominio de cocina y el dominio financiero
4. Identificar funciones que mezclan lógica de ambos dominios
RESULTADO_ACTUAL: Violación del principio de separación de dominios que puede causar inconsistencias cuando se modifican estados en uno de los dominios sin considerar el impacto en el otro.
RESULTADO_ESPERADO: Órdenes y pagos deben ser dominios completamente separados, donde las órdenes no dependen de los pagos y viceversa.
UBICACION:
- pronto-libs/src/pronto_shared/models/order_models.py
- pronto-libs/src/pronto_shared/services/order_payment_service.py
- pronto-libs/src/pronto_shared/services/payment_service.py
EVIDENCIA: El análisis del código muestra que existen funciones que modifican estados de órdenes basadas en eventos de pago, y viceversa, violando la separación clara de dominios.
HIPOTESIS_CAUSA: La implementación se hizo de manera incremental sin establecer claramente la separación de dominios desde el principio, lo que llevó a dependencias cruzadas entre los dominios de cocina y financiero.
ESTADO: ABIERTO