---
ID: ERR-20260203-NOTIF-CALL-ADMIN
FECHA: 2026-02-03
PROYECTO: pronto-employees/pronto-api/pronto-static
SEVERIDAD: media
TITULO: Llamada admin sin endpoint dedicado
DESCRIPCION: La UI de empleados necesitaba un endpoint dedicado para llamadas administrativas. Se normalizo a /api/notifications/admin/call y se elimino la ruta legacy.
PASOS_REPRODUCIR: 1) Disparar llamada administrativa desde UI. 2) Ver request POST a /api/notifications/admin/call.
RESULTADO_ACTUAL: Llamada administrativa registrada y notificada.
RESULTADO_ESPERADO: Endpoint dedicado disponible y sin rutas legacy.
UBICACION: pronto-api/src/api_app/routes/notifications.py; pronto-static/src/vue/employees/modules/employee-events.ts; pronto-static/src/vue/employees/modules/waiter-board.ts
EVIDENCIA: fetch('/api/notifications/admin/call') en frontend; endpoint en pronto-api.
HIPOTESIS_CAUSA: Endpoint faltante en BFF de empleados.
ESTADO: RESUELTO
SOLUCION: Se implemento /api/notifications/admin/call en pronto-api y se migro el frontend.
COMMIT: N/A
FECHA_RESOLUCION: 2026-02-04
---
