ID: PROMPT-23
FECHA: 2026-02-17
PROYECTO: PRONTO-System
SEVERIDAD: alta
TITULO: PROMPT 23 - Workflow de Ordenes Canonico

DESCRIPCION:
Falta crear prompt para implementar el workflow de ordenes canonico con maquina de estados formal.

CONTENIDO PROMPT:

```
Implementa el workflow de ordenes canonico para PRONTO con maquina de estados formal:

ESTADOS DE ORDEN (workflow_status):

new         - Orden creada por cliente
queued      - Mesero acepto orden
preparing   - Chef preparando orden
ready       - Orden lista para entregar
delivered   - Orden entregada al cliente
cancelled   - Orden cancelada (Estado terminal)

TRANSICIONES VALIDAS:
new        → queued      (mesero acepta)
new        → cancelled   (cliente o admin cancela)
queued     → preparing   (chef inicia)
queued     → ready      (quick-serve)
queued     → cancelled  (mesero o admin cancela)
preparing  → ready     (chef termina)
preparing  → cancelled  (chef o admin cancela)
ready      → delivered (mesero entrega)
delivered  → paid      (pago completado)
delivered  → cancelled  (admin cancela)

ESTADOS DE PAGO (payment_status):
unpaid     - Sin pagar
paid       - Pagado

SESION/DINING SESSION (status):
open       - Sesion abierta (cliente ordenando)
active     - Sesion activa con ordenes
awaiting_tip    - Propina solicitada
awaiting_payment - Cliente pidio la cuenta (check)
paid       - Sesion pagada y cerrada

REGLAS DE WORKFLOW:

1. Orden automatica a queued: Si la mesa tiene mesero asignado, al crear orden se acepta automaticamente
2. Quick-serve: Si todos los items son is_quick_serve=true, la orden pasa directamente a ready
3. Pago directo: El pago puede completarse en cualquier momento (no requiere awaiting_payment)
4. Check solicitado: Se registra check_requested_at cuando el cliente pide la cuenta desde la app, pero no es requisito para pagar
5. Roles para pago: Mesero, Cajero, Admin, System pueden iniciar y confirmar pagos

IMPLEMENTACION REQUERIDA:

1. Constantes canonicas en pronto-libs/src/pronto_shared/constants.py:
   - OrderStatus (enum)
   - PaymentStatus (enum)
   - DiningSessionStatus (enum)

2. Maquina de estados en pronto-libs/src/pronto_shared/services/order_state_machine.py:
   - Metodo validate_transition(from_state, to_state)
   - Excepcion si transicion no permitida
   - Logging de intentos invalidos

3.order_service.py debe USAR la maquina de estados:
   - accept_order() → validate_transition(new, queued)
   - start_preparing() → validate_transition(queued, preparing)
   - mark_ready() → validate_transition(preparing, ready)
   - deliver() → validate_transition(ready, delivered)
   - mark_paid() → validate_transition(delivered, paid)
   - cancel_order() → validar transicion a cancelled

4. PROHIBICIONES (P0):
   - NO escribir workflow_status = ... fuera de order_state_machine.py
   - NO escribir payment_status = ... fuera de order_state_machine.py
   - NO usar strings magicos como "new", "queued", "preparing" fuera de constants.py

5. VALIDACIONES GATE:
   - Ejecutar: rg -n --hidden "workflow_status\s*=" pronto-api/src | rg -v "order_state_machine\.py"
   - Ejecutar: rg -n --hidden "payment_status\s*="  pronto-api/src | rg -v "order_state_machine\.py"
   - Si produce output ⇒ REJECTED

Entrega:
- constants.py con enums
- order_state_machine.py con transiciones
- order_service.py refactorizado
- Tests de validacion
- Gate de verificacion
```

PASOS_REPRODUCIR:
1. Verificar artefactos canónicos:
   - `pronto-libs/src/pronto_shared/constants.py`
   - `pronto-libs/src/pronto_shared/services/order_state_machine.py`
   - `pronto-libs/src/pronto_shared/services/order_service.py`
2. Verificar transiciones y validación:
   - buscar `OrderStatus`, `PaymentStatus`, `ORDER_TRANSITIONS`
   - buscar `OrderStateMachine` y `validate_transition(...)`
3. Ejecutar gate de autoridad de estado:
   - `rg -n --hidden "workflow_status\\s*=" pronto-api/src | rg -v "order_state_machine\\.py"`
   - `rg -n --hidden "payment_status\\s*=" pronto-api/src | rg -v "order_state_machine\\.py"`

RESULTADO_ACTUAL:
- Existe máquina de estados canónica en `order_state_machine.py` con `ORDER_TRANSITIONS` y `validate_transition`.
- `constants.py` define enums de estado canónicos (`OrderStatus`, `PaymentStatus`, `SessionStatus`).
- Gate de autoridad de estados sin coincidencias fuera de archivos permitidos.

RESULTADO_ESPERADO:
Workflow de órdenes gobernado por autoridad única de transiciones y sin escrituras directas de estado fuera del servicio canónico.

UBICACION:
- pronto-libs/src/pronto_shared/constants.py
- pronto-libs/src/pronto_shared/services/order_state_machine.py
- pronto-libs/src/pronto_shared/services/order_service.py
- pronto-api/src/

EVIDENCIA:
Validaciones ejecutadas el 2026-02-18: detección de clases/transiciones canónicas y cero hallazgos en el gate regex de escrituras directas.

HIPOTESIS_CAUSA:
Pendiente documental de cierre del prompt pese a que la implementación canónica ya estaba consolidada.

ESTADO: RESUELTO
SOLUCION:
Se validó la implementación de la máquina de estados formal y el cumplimiento del gate de autoridad de estados, cerrando el incidente documental del prompt 23.

COMMIT: pendiente
FECHA_RESOLUCION: 2026-02-18
