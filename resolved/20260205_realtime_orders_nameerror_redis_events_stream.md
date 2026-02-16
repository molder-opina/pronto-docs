---
ID: ERR-20260205-REALTIME-ORDERS-REDIS-STREAM-NAMEERROR
FECHA: 2026-02-05
PROYECTO: pronto-libs/pronto-api
SEVERIDAD: alta
TITULO: /api/realtime/orders falla 500 por NameError REDIS_EVENTS_STREAM no definido
DESCRIPCION: El endpoint /api/realtime/orders (pronto-api) falla con HTTP 500 por NameError en pronto_shared.socketio_manager.read_events_from_stream al referenciar REDIS_EVENTS_STREAM sin definir. Esto rompe el realtime de ordenes y bloquea consumidores.
PASOS_REPRODUCIR:
1) Levantar servicios api + redis.
2) Ejecutar GET /api/realtime/orders con JWT valido.
RESULTADO_ACTUAL: HTTP 500 con traceback NameError: name 'REDIS_EVENTS_STREAM' is not defined.
RESULTADO_ESPERADO: HTTP 200 con payload success_response, events vacio si no hay eventos.
UBICACION: pronto-libs/src/pronto_shared/socketio_manager.py:read_events_from_stream
EVIDENCIA: docker logs pronto-api-1 muestra NameError REDIS_EVENTS_STREAM al llamar get_order_events().
HIPOTESIS_CAUSA: Constante REDIS_EVENTS_STREAM fue renombrada/eliminada sin actualizar todas las rutas de lectura del stream.
ESTADO: RESUELTO
---

SOLUCION: Se definieron/centralizaron las constantes del stream Redis usadas por socketio_manager/read_events_from_stream para evitar NameError y asegurar compatibilidad con get_order_events().
COMMIT: 0b29aca
FECHA_RESOLUCION: 2026-02-05
