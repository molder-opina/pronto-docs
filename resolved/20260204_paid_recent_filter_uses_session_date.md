---
ID: ERR-20260204-PAID-RECENT-DATE
FECHA: 2026-02-04
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: Filtros de pagos recientes usan fecha de sesión en lugar de fecha de orden
DESCRIPCION: En vistas de pagos/cerradas derivadas desde órdenes, el filtro de fecha se aplica usando closed_at de la sesión cuando existe, en lugar de usar la fecha/hora real del movimiento de la orden (paid/cancelled). Esto puede mostrar u ocultar pagos recientes incorrectamente.
PASOS_REPRODUCIR: 1) Tener una sesión cerrada con órdenes pagadas. 2) Cambiar filtros de fecha (today/last7/custom). 3) Comparar resultados cuando session.closed_at difiere del paid_at/historial de la orden.
RESULTADO_ACTUAL: El filtro usa timestamps de sesión y no el timestamp del cambio de estado de la orden.
RESULTADO_ESPERADO: El filtro de pagos recientes debe usar la fecha/hora del movimiento de la orden (paid) y para cerradas también cancelled cuando aplique.
UBICACION: pronto-static/src/vue/employees/modules/waiter-board.ts; pronto-static/src/vue/employees/modules/cashier-board.ts; pronto-static/src/vue/employees/modules/kitchen-board.ts; pronto-static/src/vue/employees/modules/sessions-manager.ts; pronto-static/src/vue/employees/components/ClosedSessionsManager.vue
EVIDENCIA: Derivación de closed_at prioriza session.closed_at sobre order.paid_at/history.
HIPOTESIS_CAUSA: Reuso de modelo de sesión legacy al migrar de /api/sessions/* a /api/orders.
ESTADO: RESUELTO
SOLUCION: Los filtros de pagos/cerradas ahora usan timestamps del movimiento de la orden (paid/cancelled) via paid_at/history.changed_at, y no session.closed_at.
COMMIT: N/A
FECHA_RESOLUCION: 2026-02-04
---
