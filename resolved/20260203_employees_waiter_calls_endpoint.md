---
ID: ERR-20260203-005
FECHA: 2026-02-03
PROYECTO: pronto-static/pronto-api/pronto-libs
SEVERIDAD: alta
TITULO: Empleados usaban rutas legacy para llamadas de mesero
DESCRIPCION: El frontend de empleados consumia rutas legacy para llamadas de mesero. Se migro a /api/notifications/waiter/* y se implementaron endpoints en pronto-api.
PASOS_REPRODUCIR: 1) Abrir panel de empleados. 2) Ver requests a /api/notifications/waiter/pending y /api/notifications/waiter/confirm/<id>.
RESULTADO_ACTUAL: Llamadas y confirmaciones funcionan con rutas nuevas.
RESULTADO_ESPERADO: Rutas dedicadas y sin dependencias legacy.
UBICACION: pronto-static/src/vue/employees/modules/employee-events.ts; pronto-static/src/vue/employees/modules/waiter-board.ts; pronto-api/src/api_app/routes/notifications.py
EVIDENCIA: fetch('/api/notifications/waiter/pending') y fetch('/api/notifications/waiter/confirm/<id>') en UI; endpoints en pronto-api.
HIPOTESIS_CAUSA: Rutas legacy no migradas a BFF de empleados.
ESTADO: RESUELTO
SOLUCION: Se implementaron endpoints /api/notifications/waiter/* en pronto-api y se actualizo el frontend.
COMMIT: N/A
FECHA_RESOLUCION: 2026-02-04
---
