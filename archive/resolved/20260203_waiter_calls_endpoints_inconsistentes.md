---
ID: PRONTO-ERR-20260203-002
FECHA: 2026-02-03
PROYECTO: pronto-static/pronto-api/pronto-libs
SEVERIDAD: alta
TITULO: Frontend empleados dependia de rutas legacy de llamadas
DESCRIPCION: El frontend de empleados dependia de rutas legacy para llamadas de mesero. Se migro a /api/notifications/waiter/* y se eliminaron referencias legacy.
PASOS_REPRODUCIR: 1) Abrir dashboard de empleados. 2) Ver requests a /api/notifications/waiter/pending y /api/notifications/waiter/confirm/<id>.
RESULTADO_ACTUAL: Requests usan rutas nuevas y responden OK.
RESULTADO_ESPERADO: Endpoints dedicados disponibles sin rutas legacy.
UBICACION: pronto-static/src/vue/employees/modules/employee-events.ts; pronto-static/src/vue/employees/modules/waiter-board.ts; pronto-api/src/api_app/routes/notifications.py
EVIDENCIA: fetch('/api/notifications/waiter/pending') en UI; endpoints implementados.
HIPOTESIS_CAUSA: Rutas legacy no migradas.
ESTADO: RESUELTO
SOLUCION: Se implementaron endpoints /api/notifications/waiter/* y se actualizo el frontend.
COMMIT: N/A
FECHA_RESOLUCION: 2026-02-04
---
