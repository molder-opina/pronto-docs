ID: BUG-20260309-E2E-EMPLOYEE-STALE-REFRESH
FECHA: 2026-03-09
PROYECTO: pronto-static
SEVERIDAD: alta
TITULO: Los tableros de empleados pueden quedar con filas stale tras acciones de workflow por mezcla de realtime parcial y fetch cacheable
DESCRIPCION: En el flujo E2E real, después de aceptar/iniciar/listar/entregar órdenes, las consolas de waiter/chef mostraron filas con información vieja o en tabs incorrectos hasta refrescos posteriores. La revisión del store confirmó que el problema no está en los componentes, sino en el store compartido: el realtime solo muta `workflow_status` localmente y el fetch posterior no fuerza `no-store`, permitiendo carreras con objetos parciales o respuestas cacheadas.
PASOS_REPRODUCIR:
1. Abrir consola waiter/chef en `http://127.0.0.1:6081/`.
2. Ejecutar acciones de workflow reales sobre una orden (`accept`, `kitchen-start`, `kitchen-ready`, `deliver`).
3. Observar el cambio inmediato en la tabla y tabs (`Activas`, `Seguimiento`, `Mesas`).
4. Comparar el estado visible con el payload real recargado por API.
RESULTADO_ACTUAL:
- `processWorkflowAction()` hacía merge optimista y luego `fetchOrders()`.
- El realtime `orders.status_changed` solo tocaba `workflow_status` del objeto local.
- Si además cambiaban `session`, `check_requested_at`, waiter/delivery data o la orden debía moverse de tablero, el objeto quedaba stale temporalmente.
- El wrapper HTTP no forzaba `cache: 'no-store'` para GET.
RESULTADO_ESPERADO: Ante cambios de workflow/realtime, la consola debe terminar con el objeto completo y fresco de backend, sin depender de mutaciones parciales ni de caché del navegador/proxy.
UBICACION:
- pronto-static/src/vue/employees/shared/store/orders.ts
- pronto-static/src/vue/employees/shared/core/http.ts
- pronto-libs/src/pronto_shared/supabase/realtime.py
EVIDENCIA:
- Se endureció `requestJSON` con `cache: 'no-store'` para GET y el store ahora hace refetch explícito tras `orders.status_changed` y acciones de workflow.
- `vitest` en employees quedó verde y el rerun browser real confirmó accept/start/ready/deliver/request-check/pay sin filas stale bloqueando el flujo.
HIPOTESIS_CAUSA: El store combinaba dos fuentes de actualización incompatibles: eventos realtime mínimos que solo conocían el nuevo status y fetches GET potencialmente cacheables. Esa combinación dejaba ventanas donde la UI conservaba objetos incompletos o desactualizados.
ESTADO: RESUELTO
SOLUCION: Se eliminó la dependencia de caché para GET y se privilegió el refetch completo como reconciliación posterior a realtime/workflow. Se añadieron pruebas unitarias del store para exigir `cache: 'no-store'` y la recarga tras cambios de estado.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-09

