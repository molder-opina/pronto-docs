---
ID: ERR-20260205-PAY-BLOCK-SESSION-NONTERMINAL
FECHA: 2026-02-05
PROYECTO: pronto-libs
SEVERIDAD: alta
TITULO: Se permite pagar una orden aunque existan ordenes NON_TERMINAL en el mismo session_id
DESCRIPCION: El invariante requiere que `paid` sea el ultimo estado y que no coexista con estados no terminales dentro del mismo `session_id`. Actualmente se puede transicionar una orden a `paid` aunque el session_id tenga otras ordenes en estados no terminales, creando mezcla `paid + NON_TERMINAL`.
PASOS_REPRODUCIR: 1) Tener 2 ordenes en un mismo session_id. 2) Dejar una en `queued` (o cualquier NON_TERMINAL). 3) Pagar la otra. 4) Ver que la sesion queda con mezcla de estados.
RESULTADO_ACTUAL: Se permite `workflow_status=paid` en una orden mientras otra orden del mismo session_id permanece en estado no terminal.
RESULTADO_ESPERADO: La transicion a `paid` debe fallar (409) si existen ordenes no terminales en el mismo session_id.
UBICACION: pronto-libs/src/pronto_shared/services/order_service.py (_transition_order_in_session)
EVIDENCIA: No existe validacion que consulte otras ordenes del mismo session_id antes de permitir `paid`.
HIPOTESIS_CAUSA: Falta guardrail de integridad a nivel de transicion.
ESTADO: RESUELTO
---

SOLUCION: Se agrego un guardrail en _transition_order_in_session para bloquear la transicion a paid (HTTP 409) si existen otras ordenes del mismo session_id en estados no terminales (new/queued/preparing/ready/delivered/awaiting_payment).
COMMIT: b5cd31b
FECHA_RESOLUCION: 2026-02-05
