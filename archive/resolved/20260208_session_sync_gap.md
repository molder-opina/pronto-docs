---
ID: ERR-20260208-017
FECHA: 2026-02-08
PROYECTO: pronto-api / pronto-client
SEVERIDAD: media
TITULO: Desfase de estado entre JWT y Base de Datos (Session Sync)
DESCRIPCION: El sistema utiliza JWT para rastrear la sesión de comedor (dining_session_id). Sin embargo, no existe una validación que verifique si la sesión almacenada en el token sigue "open" en la base de datos o si ha expirado por TTL en el servidor. Un cliente podría realizar pedidos usando un token cuya sesión ya fue cerrada o liquidada en el dashboard de empleados.
PASOS_REPRODUCIR:
1) Abrir una sesión y obtener el token.
2) Un empleado cierra la sesión desde el dashboard (status='closed').
3) El cliente intenta realizar un nuevo pedido con el token original.
RESULTADO_ACTUAL: El pedido se procesa (si el service lo permite) o falla crípticamente, porque el token sigue siendo "válido" para el middleware de Flask pero la sesión en DB es inválida.
RESULTADO_ESPERADO: El middleware o el service de órdenes debe validar el estado de DiningSession.status antes de proceder.
UBICACION: pronto-api/src/api_app/routes/client_sessions.py y pronto_shared/services/order_write_service.py
EVIDENCIA: La ruta /me solo valida la expiración del JWT, no el estado de la fila en pronto_dining_sessions.
HIPOTESIS_CAUSA: Arquitectura stateless de JWT que no consulta la DB para validaciones de estado de sesión por performance.
ESTADO: PENDIENTE
---
PLAN DE SOLUCION:
1. Añadir una verificación de estado en el endpoint /api/sessions/validate y /api/sessions/me.
2. Si la sesión en DB está cerrada o expirada, forzar la invalidación del token en el cliente (retornar 401 SESSION_INVALID).
3. Implementar la misma validación en el service de creación de órdenes.
