ID: ERR-20260219-EMPLOYEES-ORDER-HEAD-MISSING
FECHA: 2026-02-19
PROYECTO: pronto-employees, pronto-static
SEVERIDAD: media
TITULO: Validación HEAD /api/orders/{id} en employees usa endpoint inexistente
DESCRIPCION: El módulo `employee-events` intenta validar existencia de orden con `HEAD /api/orders/{id}` antes de mostrar notificación, pero el backend employees no expone ruta por id en `/api/orders/*` para GET/HEAD.
PASOS_REPRODUCIR:
1. Emitir evento de nueva orden en employees
2. Revisar request de validación en frontend
3. Verificar respuesta de `/api/orders/{id}`
RESULTADO_ACTUAL: `HEAD /api/orders/{id}` devuelve 404.
RESULTADO_ESPERADO: Endpoint por id debe existir para validación rápida (200/404).
UBICACION:
- pronto-static/src/vue/employees/modules/employee-events.ts:374
- pronto-employees/src/pronto_employees/routes/api/orders.py
EVIDENCIA:
```bash
rg -n "authenticatedFetch\(`/api/orders/\$\{order_id\}`" pronto-static/src/vue/employees/modules/employee-events.ts
rg -n "@orders_bp\\.(get|head)\\(\"/orders/<uuid:order_id>\"" pronto-employees/src/pronto_employees/routes/api/orders.py
```
HIPOTESIS_CAUSA: El frontend asumía endpoint REST por id, pero el BFF de employees sólo tenía listado y mutaciones de estado.
ESTADO: RESUELTO
SOLUCION: Se agregó endpoint por ID en `orders.py` con `GET /api/orders/<uuid:order_id>` y `HEAD /api/orders/<uuid:order_id>` (misma función, decorador `route(..., methods=['HEAD'])`) protegido con `jwt_required`. Validación post-rebuild: `HEAD` y `GET` responden 401 sin autenticación (ya no 404).
COMMIT: N/A
FECHA_RESOLUCION: 2026-02-19
