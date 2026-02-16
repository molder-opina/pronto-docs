---
ID: ERR-20260204-ORDER-STATUS-TIMESTAMP
FECHA: 2026-02-04
PROYECTO: pronto-libs/pronto-client
SEVERIDAD: alta
TITULO: Cambios de estado no siempre registran fecha/hora del movimiento en historial
DESCRIPCION: Algunos cambios de estado se aplican con asignacion directa a workflow_status o con append manual a OrderStatusHistory sin changed_at explicito, lo que provoca que no se registre consistentemente la fecha/hora exacta del movimiento en cada cambio.
PASOS_REPRODUCIR: 1) Ejecutar request_order_check en pronto-client (marca awaiting_payment) y revisar pronto_order_status_history. 2) Revisar order_state_machine apply_transition (append manual). 3) Comparar con cambios via Order.mark_status.
RESULTADO_ACTUAL: No todos los cambios pasan por Order.mark_status; el historial puede no tener timestamp consistente al momento del movimiento.
RESULTADO_ESPERADO: Cada cambio de estado debe registrar fecha/hora del movimiento en OrderStatusHistory.changed_at en el momento de aplicarse.
UBICACION: pronto-client/src/pronto_clients/routes/api/orders.py:571; pronto-libs/src/pronto_shared/services/order_state_machine.py:154-200; pronto-libs/src/pronto_shared/models.py:796-835
EVIDENCIA: order.workflow_status = OrderStatus.AWAITING_PAYMENT.value (sin mark_status); context.order.history.append(OrderStatusHistory(status=...)) (sin changed_at).
HIPOTESIS_CAUSA: Uso mixto de state machine/assign directo en lugar de un unico punto (Order.mark_status) para cambios de estado.
ESTADO: RESUELTO
SOLUCION: Se centralizo el cambio de estado en Order.mark_status y se setea changed_at explicitamente en cada entrada de historial.
COMMIT: b5cd31b
FECHA_RESOLUCION: 2026-02-04
---
