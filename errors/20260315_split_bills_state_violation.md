ID: PRONTO-PAY-005
FECHA: 2026-03-15
PROYECTO: pronto-libs
SEVERIDAD: alta
TITULO: Split bills viola autoridad única de estados con escritura directa
DESCRIPCION: El servicio split_bill_service_core.py viola la regla de autoridad única de estados definida en AGENTS.md al realizar escrituras directas de payment_status fuera de la máquina de estados canónica. Esto rompe la encapsulación y puede causar inconsistencias.
PASOS_REPRODUCIR:
1. Analizar el código en split_bill_service_core.py línea 201
2. Observar la asignación directa: person.payment_status = PaymentStatus.PAID.value
3. Verificar que esta escritura no pasa por la máquina de estados canónica
RESULTADO_ACTUAL: Violación de la regla P0 de autoridad única de estados. Escrituras directas que pueden causar inconsistencias.
RESULTADO_ESPERADO: Todas las modificaciones de estados deben pasar por la máquina de estados canónica (order_state_machine.py).
UBICACION:
- pronto-libs/src/pronto_shared/services/split_bill_service_core.py:201
- pronto-libs/src/pronto_shared/services/order_state_machine.py
EVIDENCIA: La línea 201 en split_bill_service_core.py muestra una asignación directa de payment_status, violando la regla P0 que prohíbe escrituras directas de estados fuera del servicio canónico.
HIPOTESIS_CAUSA: El módulo de split bills fue implementado antes de establecer la regla de autoridad única de estados, o no se actualizó para cumplir con esta regla.
ESTADO: ABIERTO