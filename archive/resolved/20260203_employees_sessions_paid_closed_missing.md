---
ID: ERR-20260203-SESSIONS-PAID-CLOSED
FECHA: 2026-02-03
PROYECTO: pronto-static/pronto-employees
SEVERIDAD: alta
TITULO: Empleados llama /api/sessions/(paid, paid-recent, closed) sin endpoints en pronto-employees
DESCRIPCION: Módulos de caja, cocina y sesiones consultan /api/sessions/paid, /api/sessions/paid-recent y /api/sessions/closed, pero no existen rutas en pronto-employees.
PASOS_REPRODUCIR: 1) Abrir tablero de caja o cocina. 2) Ver requests a /api/sessions/paid o /api/sessions/closed. 3) Revisar respuesta.
RESULTADO_ACTUAL: 404 en /api/sessions/paid, /api/sessions/paid-recent y /api/sessions/closed.
RESULTADO_ESPERADO: Endpoints de sesiones disponibles en pronto-employees o ajuste de UI al endpoint real.
UBICACION: pronto-static/src/vue/employees/modules/kitchen-board.ts:923; pronto-static/src/vue/employees/modules/waiter-board.ts:3122; pronto-static/src/vue/employees/modules/cashier-board.ts:767; pronto-static/src/vue/employees/components/ClosedSessionsManager.vue:139; pronto-static/src/vue/employees/modules/sessions-manager.ts:421-422
EVIDENCIA: fetch('/api/sessions/paid') en kitchen-board.ts:923; fetch('/api/sessions/paid-recent') en waiter-board.ts:3122; fetch('/api/sessions/closed') en cashier-board.ts:767 y ClosedSessionsManager.vue:139; sin rutas en pronto-employees/src/pronto_employees/routes.
HIPOTESIS_CAUSA: API de sesiones removida de pronto-employees sin actualizar frontend.
ESTADO: RESUELTO
SOLUCION: Se elimino el uso de /api/sessions/(paid, paid-recent, closed) y la UI ahora deriva sesiones cerradas desde /api/orders con estados paid/cancelled.
COMMIT: N/A
FECHA_RESOLUCION: 2026-02-04
---
