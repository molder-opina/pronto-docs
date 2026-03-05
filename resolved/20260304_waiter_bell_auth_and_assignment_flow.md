ID: ERR-20260304-WAITER-BELL-AUTH-ASSIGNMENT
FECHA: 2026-03-04
PROYECTO: pronto-static,pronto-api,pronto-client,pronto-libs
SEVERIDAD: alta
TITULO: Flujo de campanita no cumple gating por login ni señalización clara de mesas sin mesero asignado
DESCRIPCION: La llamada al mesero requiere reforzar gating por sesión autenticada del cliente, filtrado de llamadas por asignación de mesero en la consola waiter y señal visual de mesas no asignadas en bandeja de notificaciones.
PASOS_REPRODUCIR: 1) Abrir cliente sin login y observar estado de la campanita 2) Generar llamada con mesa sin asignación 3) Revisar bandeja de notificaciones en /waiter.
RESULTADO_ACTUAL: El estado de la campanita depende principalmente de session_id local y la bandeja no distingue visualmente llamadas de mesas sin asignación; además se requiere acelerar confirmación cliente con cache Redis.
RESULTADO_ESPERADO: Campanita habilitada solo con login+sesión activa, notificaciones waiter filtradas por asignación (o broadcast sin asignación), color distintivo en bandeja para mesas no asignadas y confirmación al cliente con mayor rapidez usando Redis.
UBICACION: pronto-static/src/vue/clients/modules/client-base.ts, pronto-static/src/vue/employees/shared/components/NotificationPanel.vue, pronto-static/src/vue/employees/shared/store/orders.ts, pronto-api/src/api_app/routes/employees/notifications.py, pronto-client/src/pronto_clients/routes/api/waiter_calls.py, pronto-libs/src/pronto_shared/services/waiter_calls.py
EVIDENCIA: Revisión de código actual del flujo call-waiter, pending notifications y confirmación de llamadas.
HIPOTESIS_CAUSA: Falta de validación combinada (auth+session) en UI cliente, parseo incompleto de payload notifications en store employees, ausencia de filtro por waiter asignado en endpoint pending y falta de fast-path Redis para status de waiter_call.
ESTADO: RESUELTO
SOLUCION: Se aplicó gating cliente por login+sesión activa para campana, filtro y etiquetado de llamadas sin mesero asignado en panel de notificaciones de empleados, y endurecimiento del flujo de confirmación admin/mesero con eventos realtime y cobertura Playwright de regresión.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-04
