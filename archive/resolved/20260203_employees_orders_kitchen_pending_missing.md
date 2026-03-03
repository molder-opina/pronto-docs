---
ID: ERR-20260203-ORDERS-KITCHEN-PENDING
FECHA: 2026-02-03
PROYECTO: pronto-static/pronto-employees
SEVERIDAD: alta
TITULO: Empleados llama /api/orders/kitchen/pending sin endpoint en pronto-employees
DESCRIPCION: El módulo de cocina consulta /api/orders/kitchen/pending, pero no existe ruta en pronto-employees. No hay proxy hacia pronto-api en el servicio de empleados.
PASOS_REPRODUCIR: 1) Abrir tablero de cocina. 2) Esperar carga de pedidos pendientes. 3) Ver request a /api/orders/kitchen/pending.
RESULTADO_ACTUAL: 404 en /api/orders/kitchen/pending.
RESULTADO_ESPERADO: Endpoint /api/orders/kitchen/pending disponible en pronto-employees o ajustar UI al endpoint real.
UBICACION: pronto-static/src/vue/employees/modules/kitchen-board.ts:1046,1302
EVIDENCIA: fetch('/api/orders/kitchen/pending') en kitchen-board.ts:1046 y 1302; no existe ruta equivalente en pronto-employees/src/pronto_employees/routes.
HIPOTESIS_CAUSA: Endpoint movido/eliminado en backend sin actualizar frontend de empleados.
ESTADO: RESUELTO
SOLUCION: Se elimino el endpoint especial /api/orders/kitchen/pending y la UI ahora usa /api/orders con filtrado status=queued.
COMMIT: N/A
FECHA_RESOLUCION: 2026-02-04
---
