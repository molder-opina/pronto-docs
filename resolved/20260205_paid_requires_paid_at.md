---
ID: ERR-20260205-PAID-REQUIRES-PAIDAT
FECHA: 2026-02-05
PROYECTO: pronto-libs
SEVERIDAD: alta
TITULO: workflow_status=paid puede quedar sin paid_at si se usa mark_status directamente
DESCRIPCION: El modelo Order permite cambiar workflow_status con mark_status sin asegurar paid_at cuando el estado es paid. Aunque la state machine setea paid_at en _handle_pay, otros callers podrian marcar paid sin side-effects, violando el invariante workflow_status=paid => paid_at NOT NULL.
PASOS_REPRODUCIR: 1) Llamar Order.mark_status('paid') sin pasar por transition_order/state machine. 2) Persistir orden. 3) Revisar que paid_at quede NULL.
RESULTADO_ACTUAL: Es posible tener orden con workflow_status=paid y paid_at NULL.
RESULTADO_ESPERADO: Cada vez que workflow_status cambie a paid, paid_at debe setearse en el momento del movimiento.
UBICACION: pronto-libs/src/pronto_shared/models.py (Order.mark_status)
EVIDENCIA: mark_status no setea paid_at para estado paid.
HIPOTESIS_CAUSA: mark_status no aplica side-effects por estado, solo cambia workflow_status.
ESTADO: RESUELTO
---

SOLUCION: Se endurecio Order.mark_status para que cuando status sea paid, siempre setee paid_at si estaba NULL. Esto garantiza el invariante workflow_status=paid => paid_at NOT NULL incluso si algun caller marca paid sin pasar por la state machine.
COMMIT: b1b4855
FECHA_RESOLUCION: 2026-02-05
