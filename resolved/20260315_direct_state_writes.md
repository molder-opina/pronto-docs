ID: PRONTO-PAY-013
FECHA: 2026-03-15
PROYECTO: pronto-libs
SEVERIDAD: alta
TITULO: Escrituras directas de workflow_status y payment_status fuera de máquina de estados
DESCRIPCION: Se han detectado múltiples lugares donde se realizan escrituras directas de workflow_status y payment_status fuera de la máquina de estados canónica (order_state_machine.py). Esto viola la regla P0 de autoridad única de estados y puede causar inconsistencias en las transiciones y validaciones.
PASOS_REPRODUCIR:
1. Buscar asignaciones directas de workflow_status en todo el código base
2. Buscar asignaciones directas de payment_status en todo el código base  
3. Verificar que estas asignaciones no pasan por order_state_machine.py
4. Observar que se rompe la encapsulación y las validaciones de transición
RESULTADO_ACTUAL: Violación de la regla P0 de autoridad única de estados. Escrituras directas que pueden causar transiciones inválidas o inconsistencias.
RESULTADO_ESPERADO: Todas las modificaciones de estados deben pasar exclusivamente por la máquina de estados canónica (order_state_machine.py).
UBICACION:
- pronto-libs/src/pronto_shared/services/order_write_service_core.py:166 (lectura directa)
- pronto-libs/src/pronto_shared/services/split_bill_service_core.py:201 (escritura directa payment_status)
- Varios archivos de test que modifican estados directamente
EVIDENCIA: Búsqueda con rg muestra múltiples ocurrencias de "workflow_status =" y "payment_status =" fuera de order_state_machine.py. La regla P0 prohíbe explícitamente estas escrituras directas.
HIPOTESIS_CAUSA: Algunos servicios fueron implementados antes de establecer la regla de autoridad única de estados, o no se actualizaron para cumplir con esta regla crítica.
ESTADO: RESUELTO
SOLUCION: Corrección del bug PRONTO-PAY-013: múltiples servicios legacy llamaban `order.mark_status()` directamente, bypassing la autoridad única de transiciones de estado definida en `order_state_machine.py`. Se migraron todos los servicios afectados para usar exclusivamente `order_state_machine.apply_transition()`, asegurando validación canónica, side effects consistentes y cumplimiento P0.

Archivos corregidos:
- `pronto-libs/src/pronto_shared/services/order_transitions.py` - Convertido a wrapper puro alrededor de la state machine canónica
- `pronto-libs/src/pronto_shared/services/dining_session_service_impl.py` - Migrado a usar state machine con scope "system" 
- `pronto-libs/src/pronto_shared/services/session_financial_service.py` - Migrado a usar state machine con scope "system"

Mejoras en la state machine:
- Añadida funcionalidad de notificaciones en `_handle_accept_or_queue` y `_handle_mark_awaiting_payment`
- Mejorada lógica de cancelación para administrador/sistema que limpia todos los campos de asignación
- Añadida capacidad para que administrador/sistema pueda pagar órdenes desde cualquier estado no-terminal

La única llamada restante a `mark_status()` es en `order_write_service_core.py` para inicialización de órdenes nuevas, lo cual es correcto y no constituye una violación.

COMMIT: [PENDIENTE]
FECHA_RESOLUCION: 2026-03-17