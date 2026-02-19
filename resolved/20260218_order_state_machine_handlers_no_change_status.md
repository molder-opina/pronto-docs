ID: ERR-20260218-OSM-HANDLERS
FECHA: 2026-02-18
PROYECTO: pronto-libs
SEVERIDAD: bloqueante
TITULO: OrderStateMachine handlers no cambian workflow_status
DESCRIPCION: Todos los handlers en OrderStateMachine (_handle_accept_or_queue, _handle_kitchen_start, _handle_kitchen_complete, _handle_deliver, _handle_mark_awaiting_payment, _handle_pay, _handle_cancel) ejecutaban side-effects pero no llamaban _change_status(). El método apply_transition() solo invoca _change_status() como fallback cuando NO hay handler registrado. Como TODOS los eventos tienen handler, workflow_status nunca se actualizaba por esta vía. Bug dormido porque _transition_order_in_session() en order_service.py no usa el state machine.
PASOS_REPRODUCIR: Invocar order_state_machine.apply_transition() con cualquier contexto válido.
RESULTADO_ACTUAL: Side-effects aplicados pero workflow_status permanece sin cambiar.
RESULTADO_ESPERADO: workflow_status cambia al estado objetivo después de aplicar side-effects.
UBICACION: pronto-libs/src/pronto_shared/services/order_state_machine.py
EVIDENCIA: Todos los handlers carecían de llamada a self._change_status(context.order, context.event)
HIPOTESIS_CAUSA: Diseño original del state machine asumía que apply_transition siempre usaría el fallback, pero luego se registraron handlers para todos los eventos.
ESTADO: RESUELTO
SOLUCION: Agregada llamada a self._change_status(context.order, context.event) al final de cada handler.
COMMIT: pendiente
FECHA_RESOLUCION: 2026-02-18
