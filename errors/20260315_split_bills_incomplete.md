ID: PRONTO-PAY-033
FECHA: 2026-03-15
PROYECTO: pronto-libs, pronto-api
SEVERIDAD: alta
TITULO: Implementación incompleta de cuentas divididas con violaciones de autoridad de estados
DESCRIPCION: La funcionalidad de cuentas divididas está implementada pero tiene violaciones críticas de la autoridad única de estados. El servicio split_bill_service_core.py realiza escrituras directas de payment_status fuera de la máquina de estados canónica, lo que puede causar inconsistencias en los estados y transiciones.
PASOS_REPRODUCIR:
1. Analizar split_bill_service_core.py línea 201
2. Observar la asignación directa: person.payment_status = PaymentStatus.PAID.value
3. Verificar que esta escritura no pasa por la máquina de estados canónica
4. Crear una cuenta dividida y procesar pagos
5. Observar posibles inconsistencias en los estados
RESULTADO_ACTUAL: Violación crítica de la regla P0 de autoridad única de estados en la funcionalidad de cuentas divididas, lo que puede causar inconsistencias en los estados y transiciones.
RESULTADO_ESPERADO: Todas las modificaciones de estados en cuentas divididas deben pasar por la máquina de estados canónica (order_state_machine.py).
UBICACION:
- pronto-libs/src/pronto_shared/services/split_bill_service_core.py:201
- pronto-libs/src/pronto_shared/services/order_state_machine.py
EVIDENCIA: La línea 201 en split_bill_service_core.py muestra una asignación directa de payment_status, violando la regla P0 que prohíbe escrituras directas de estados fuera del servicio canónico.
HIPOTESIS_CAUSA: La funcionalidad de cuentas divididas fue implementada antes de establecer la regla de autoridad única de estados, o no se actualizó para cumplir con esta regla crítica.
ESTADO: ABIERTO