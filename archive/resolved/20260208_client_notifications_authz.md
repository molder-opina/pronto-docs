---
ID: ERR-20260208-009
FECHA: 2026-02-08
PROYECTO: pronto-client
SEVERIDAD: alta
TITULO: Vulnerabilidad de Authz en Notificaciones de Clientes
DESCRIPCION: El endpoint de notificaciones del cliente solo filtra por recipient_type='customer', pero no valida que las notificaciones pertenezcan al cliente autenticado en el JWT. Un cliente podría listar notificaciones de otros usuarios simplemente consultando el endpoint.
PASOS_REPRODUCIR:
1) Autenticarse como Usuario A.
2) Llamar a GET /api/notifications.
3) Observar que se retornan todas las notificaciones generales sin filtro de ID de usuario.
RESULTADO_ACTUAL: Falta de aislamiento de datos entre clientes.
RESULTADO_ESPERADO: El endpoint debe filtrar por Notification.recipient_id == current_user['customer_id'].
UBICACION: pronto-client/src/pronto_clients/routes/api/notifications.py
EVIDENCIA: Consulta select() en línea 20 solo usa Notification.status y Notification.recipient_type.
HIPOTESIS_CAUSA: Implementación inicial genérica que no consideró el multi-inquilinato de notificaciones.
ESTADO: PENDIENTE
---
PLAN DE SOLUCION:
1. Obtener customer_id desde g.current_user (inyectado por el middleware JWT).
2. Añadir filtro .where(Notification.recipient_id == customer_id) a la consulta.
3. Devolver lista vacía si no hay usuario autenticado.
