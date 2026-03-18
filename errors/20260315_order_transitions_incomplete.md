ID: PRONTO-PAY-028
FECHA: 2026-03-15
PROYECTO: pronto-libs
SEVERIDAD: alta
TITULO: Transiciones de estado de orden incompletas y sin validación
DESCRIPCION: El sistema no implementa completamente todas las transiciones de estado válidas para órdenes, y carece de validación adecuada para transiciones inválidas. Algunas transiciones permitidas según la matriz ORDER_TRANSITIONS no están implementadas, mientras que otras transiciones inválidas podrían ocurrir debido a la falta de validación.
PASOS_REPRODUCIR:
1. Analizar la matriz ORDER_TRANSITIONS en order_state_machine.py
2. Verificar qué transiciones están realmente implementadas
3. Intentar realizar transiciones inválidas directamente
4. Observar si se permiten transiciones que deberían estar prohibidas
RESULTADO_ACTUAL: Transiciones de estado incompletas y falta de validación que puede permitir transiciones inválidas, causando inconsistencias en el flujo de órdenes.
RESULTADO_ESPERADO: Todas las transiciones válidas deben estar implementadas, y todas las transiciones inválidas deben ser rechazadas con validación explícita.
UBICACION:
- pronto-libs/src/pronto_shared/services/order_state_machine.py (ORDER_TRANSITIONS)
- pronto-libs/src/pronto_shared/services/order_write_service_core.py (transiciones)
EVIDENCIA: El análisis del código muestra que no todas las transiciones permitidas están implementadas, y la validación de transiciones inválidas es incompleta o inexistente en algunos casos.
HIPOTESIS_CAUSA: La implementación se hizo de manera incremental sin completar todas las transiciones válidas ni implementar adecuadamente la validación de transiciones inválidas.
ESTADO: ABIERTO