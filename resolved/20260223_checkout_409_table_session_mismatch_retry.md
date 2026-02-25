ID: ERR-20260223-CHECKOUT-409-TABLE-MISMATCH-RETRY
FECHA: 2026-02-23
PROYECTO: pronto-client / pronto-api
SEVERIDAD: alta
TITULO: Confirmar pedido falla con 409 por TABLE_LOCATION_MISMATCH sin autorecuperación
DESCRIPCION: Al confirmar pedido desde tab Detalles, el backend puede responder 409 cuando la mesa de la sesión activa cambió respecto al payload del cliente. El frontend mostraba error pero no recuperaba automáticamente la mesa autorizada por sesión.
PASOS_REPRODUCIR:
1) Abrir cliente autenticado con carrito.
2) Cambiar mesa en backend/sesión activa (o quedar con mesa stale en frontend).
3) Presionar Confirmar Pedido.
RESULTADO_ACTUAL: POST /api/customer/orders responde 409 CONFLICT y el flujo queda detenido.
RESULTADO_ESPERADO: El frontend debe sincronizar la mesa devuelta por backend y reintentar una vez automáticamente antes de mostrar error final.
UBICACION: pronto-client/src/pronto_clients/templates/index.html
EVIDENCIA: Consola con XHR POST /api/customer/orders -> 409 CONFLICT y códigos TABLE_LOCATION_MISMATCH/TABLE_SESSION_MISMATCH.
HIPOTESIS_CAUSA: Manejo incompleto de errores de mesa; faltaba reconciliación y retry automático usando current_table_id/current_table_code del backend.
ESTADO: RESUELTO
SOLUCION: En /api/customer/orders se eliminó el bloqueo 409 por desalineación de mesa y ahora se alinea automáticamente al table_id autoritativo de la sesión activa antes de crear la orden.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-23
