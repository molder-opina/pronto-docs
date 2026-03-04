ID: 20260303_waiter_request_payment_import_error_and_realtime_proxy_timeout
FECHA: 2026-03-03
PROYECTO: pronto-employees
SEVERIDAD: alta
TITULO: Acciones de mesero fallan y realtime de waiter entra en timeout por desalineación de imports y long-poll
DESCRIPCION: En `/waiter/dashboard/waiter` el botón de acción para órdenes entregadas no funciona y el store reporta `Workflow action failed: Error interno del servidor`. En paralelo, el polling realtime de órdenes y notificaciones responde `504 GATEWAY TIMEOUT` de forma recurrente desde el proxy scope-aware de employees.
PASOS_REPRODUCIR:
1. Iniciar sesión como `waiter`.
2. Ir a `/waiter/dashboard/waiter`.
3. Hacer clic en la acción de una orden `delivered` para solicitar pago.
4. Observar errores en consola y warnings recurrentes de realtime.
RESULTADO_ACTUAL: La acción devuelve error interno del servidor; en logs aparece `ImportError: cannot import name 'create_waiter_call' from pronto_shared.services.waiter_call_service`. Además `/waiter/api/realtime/orders` y `/waiter/api/realtime/notifications` responden `504` por timeout.
RESULTADO_ESPERADO: La acción `Solicitar pago` debe completar correctamente y realtime debe funcionar sin reintentos en timeout bajo el proxy SSR.
UBICACION:
- /Users/molder/projects/github-molder/pronto/pronto-employees/src/pronto_employees/routes/api/orders.py
- /Users/molder/projects/github-molder/pronto/pronto-static/src/vue/employees/shared/core/realtime.ts
- /Users/molder/projects/github-molder/pronto/pronto-employees/src/pronto_employees/routes/api/proxy_console_api.py
EVIDENCIA:
- Logs de pronto-employees con `ImportError` en `request_payment`
- Respuestas `504` en `/waiter/api/realtime/orders` y `/waiter/api/realtime/notifications`
- Consola frontend con `[OrdersStore] Workflow action failed`
HIPOTESIS_CAUSA:
- La ruta de employees importa `create_waiter_call` desde un módulo incorrecto (`waiter_call_service` en vez de `waiter_calls`) y además usa una firma que ya no coincide con el servicio canónico.
- El cliente realtime usa long-poll de 5000ms, igual al timeout máximo del proxy SSR, provocando expiraciones por carrera temporal.
ESTADO: RESUELTO
SOLUCION:
- La ruta `request-payment` en `pronto-employees` ahora usa el servicio canónico `pronto_shared.services.waiter_calls.create_waiter_call`, toma el `table_number` desde la sesión asociada a la orden y deja de depender de atributos inexistentes del modelo `Order`.
- El cliente realtime de employees envía `timeout_ms=4500`, quedando por debajo del timeout máximo permitido del proxy SSR scope-aware y evitando `504` recurrentes en `/waiter/api/realtime/*`.
- Se agregó cobertura Playwright para validar que `waiter` puede solicitar pago sobre una orden `delivered` y que realtime scoped no devuelve `504`.
COMMIT: db28ce9,4edc94f,2720172
FECHA_RESOLUCION: 2026-03-03
