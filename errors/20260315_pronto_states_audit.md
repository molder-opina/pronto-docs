ID: PRONTO-STATES-AUDIT-20260315
FECHA: 2026-03-15
PROYECTO: ALL (pronto-libs, pronto-api)
SEVERIDAD: alta
TITULO: Auditoria de estados del sistema - Hallazgos de inconsistencia

DESCRIPCION:
Auditoria completa de todos los estados del sistema: OrderStatus, PaymentStatus, SessionStatus, TableStatus, etc.

PASOS_REPRODUCIR:
Revisar archivos:
- pronto-libs/src/pronto_shared/constants.py
- pronto-libs/src/pronto_shared/state_definitions.py
- pronto-libs/src/pronto_shared/services/order_state_machine*.py

RESULTADO_ACTUAL:
Inconsistencias encontradas en el manejo de estados.

RESULTADO_ESPERADO:
Todos los estados deben tener máquina de estados canónica y modificarse solo a través de ella.

UBICACION:
pronto-libs/src/pronto_shared/

EVIDENCIA:

=== DEFINICIONES DE ESTADOS EN constants.py ===

1. OrderStatus - OK
   - NEW, QUEUED, PREPARING, READY, DELIVERED, PAID, CANCELLED
   - Aliases legacy: AWAITING_PAYMENT->delivered, SERVED->delivered, COMPLETED->paid
   - Tiene OrderStateMachine: OK

2. PaymentStatus - OK
   - UNPAID, AWAITING_TIP, PROCESSING, PAID_PENDING_CONFIRMATION, PAID, FAILED
   - Se modifica a través de OrderStateMachine: OK

3. SessionStatus - PARCIAL
   - OPEN, ACTIVE, AWAITING_TIP, AWAITING_PAYMENT, AWAITING_PAYMENT_CONFIRMATION, PAID, CLOSED, MERGED
   - NO tiene SessionStateMachine - ASIGNACIONES DIRECTAS

4. TableStatus - PARCIAL
   - AVAILABLE, OCCUPIED, RESERVED, INDISPOSED
   - Sin máquina de estados dedicada

5. WaiterCallStatus - PARCIAL
   - PENDING, CONFIRMED, CANCELLED, RESOLVED
   - Sin máquina de estados dedicada

6. ModificationStatus - OK
   - PENDING, APPROVED, REJECTED, APPLIED

7. Invoice status - SIN ENUM
   - Usa strings hardcodeados: "pending", "issued", "sent", "cancelled", "failed"
   - NO hay enum definido

8. Notification status - SIN ENUM
   - Usa strings hardcodeados: "unread", "read"
   - NO hay enum definido

=== MAQUINAS DE ESTADOS ===

1. OrderStateMachine - OK
   - Ubicacion: order_state_machine_core.py, order_state_machine.py
   - Funciones canónicas: mark_order_paid, mark_order_unpaid, mark_order_awaiting_tip, mark_order_cancelled
   - order.mark_status() - solo debería usarse internamente

2. SessionStateMachine - NO EXISTE
   - ASIGNACIONES DIRECTAS ENCONTRADAS:
     - order_payment_service.py:100 - dining_session.status = SessionStatus.AWAITING_TIP.value
     - order_payment_service.py:235 - dining_session.status = SessionStatus.AWAITING_PAYMENT.value
     - order_payment_service.py:444 - dining_session.status = SessionStatus.PAID.value
     - dining_session_service_impl.py:529 - dining_session.status = SessionStatus.CLOSED.value
     - order_service_impl.py:712,919,1096 - dining_session.status = SessionStatus.PAID.value
     - split_bill_service_core.py:216 - dining_session.status = SessionStatus.PAID.value
     - payment_service.py:65 - dining_session.status = SessionStatus.PAID.value
     - session_manager.py:99,133,152 - dining_session.status = SessionStatus.CLOSED.value

=== PROBLEMAS ENCONTRADOS ===

1. SessionStatus se modifica directamente sin máquina de estados (ALTA)
   - 17+ asignaciones directas encontradas
   - No hay validación de transiciones
   - Recomendación: Crear SessionStateMachine

2. Invoice status sin enum dedicado (MEDIA)
   - Usa strings hardcodeados en lugar de enum
   -来找我: constants.py

3. Notification status sin enum dedicado (MEDIA)
   - Usa strings hardcodeados
   - Asignación directa en notifications.py:143: notification_obj.status = "read"

4. TableStatus sin máquina de estados (BAJA)
   - No hay validación de transiciones

5. WaiterCallStatus sin máquina de estados (BAJA)
   - No hay validación de transiciones

HIPOTESIS_CAUSA:
- OrderStateMachine fue implementado siguiendo AGENTS.md seccion 29
- SessionStateMachine nunca fue creado - deuda técnica
- Otros estados (Invoice, Notification) no fueron priorizados

ESTADO: ABIERTO

SOLUCION:
1. Crear SessionStateMachine (similar a OrderStateMachine)
   - Mover todas las asignaciones directas de dining_session.status a funciones canónicas
   - Validar transiciones de OPEN->ACTIVE->AWAITING_PAYMENT->PAID->CLOSED
   - Crear archivo: session_state_machine.py

2. Crear InvoiceStatus enum en constants.py
   - Reemplazar strings "pending", "issued", etc. con enum

3. Crear NotificationStatus enum en constants.py
   - Reemplazar strings "unread", "read" con enum

COMMIT: N/A
FECHA_RESOLUCION: N/A
