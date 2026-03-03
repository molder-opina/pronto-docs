ID: ERR-20260219-EMPLOYEES-REALTIME-ENDPOINTS-MISSING
FECHA: 2026-02-19
PROYECTO: pronto-employees, pronto-static
SEVERIDAD: alta
TITULO: Endpoints realtime de employees faltantes generan 404
DESCRIPCION: El frontend de employees usa polling en `/api/realtime/orders` y `/api/realtime/notifications`, pero el backend no expone esas rutas en el BFF de employees.
PASOS_REPRODUCIR:
1. Autenticar en employees
2. Abrir tablero con polling realtime
3. Revisar requests hacia `/api/realtime/orders` o `/api/realtime/notifications`
RESULTADO_ACTUAL: Respuesta 404 `{"error":"Recurso no encontrado"}`.
RESULTADO_ESPERADO: Endpoints realtime deben existir y retornar `events` + `last_id`.
UBICACION:
- pronto-static/src/vue/employees/core/realtime.ts:181,191
- pronto-static/src/vue/employees/App.vue:236
- pronto-employees/src/pronto_employees/routes/api/ (sin blueprint realtime)
EVIDENCIA:
```bash
docker exec pronto-employees-1 python -c "import requests; print(requests.get('http://127.0.0.1:5000/api/realtime/orders').status_code); print(requests.get('http://127.0.0.1:5000/api/realtime/notifications').status_code)"
# 404
# 404
```
HIPOTESIS_CAUSA: Refactor del frontend mantuvo clientes realtime, pero no se implementó el blueprint `/api/realtime/*` en pronto-employees.
ESTADO: RESUELTO
SOLUCION: Se agregó el blueprint `/api/realtime/*` en `pronto-employees` con endpoints `GET /api/realtime/orders` y `GET /api/realtime/notifications`, usando servicios canónicos `get_order_events` y `get_notification_events` de `pronto_shared`. Se registró el blueprint en `routes/api/__init__.py` y tras rebuild los endpoints responden 401 (autenticación requerida) en lugar de 404.
COMMIT: N/A
FECHA_RESOLUCION: 2026-02-19
