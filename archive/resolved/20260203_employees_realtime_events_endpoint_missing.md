---
ID: ERR-20260203-REALTIMEEVENTS
FECHA: 2026-02-03
PROYECTO: pronto-employees/pronto-api/pronto-static
SEVERIDAD: media
TITULO: Realtime de empleados sin endpoints dedicados
DESCRIPCION: El modulo de eventos de empleados no tenia endpoints dedicados para polling de eventos. Se separo realtime de ordenes y notificaciones para eliminar rutas legacy.
PASOS_REPRODUCIR: 1) Abrir dashboard de empleados. 2) Ver requests a /api/realtime/notifications y /api/realtime/orders.
RESULTADO_ACTUAL: Polling dividido por dominio y sin rutas legacy.
RESULTADO_ESPERADO: Endpoints dedicados funcionando y UI consumiendo rutas nuevas.
UBICACION: pronto-api/src/api_app/routes/realtime.py; pronto-static/src/vue/employees/modules/employee-events.ts; pronto-static/src/vue/employees/core/realtime.ts
EVIDENCIA: fetch('/api/realtime/notifications') y fetch('/api/realtime/orders') en frontend; endpoints en pronto-api.
HIPOTESIS_CAUSA: Rutas realtime legacy no migradas.
ESTADO: RESUELTO
SOLUCION: Se implementaron /api/realtime/notifications y /api/realtime/orders en pronto-api y se migro el frontend a las rutas nuevas.
COMMIT: N/A
FECHA_RESOLUCION: 2026-02-04
---
