---
ID: ERR-20260205-EMP-ORDER-ACTIONS
FECHA: 2026-02-05
PROYECTO: pronto-static/pronto-employees/pronto-api
SEVERIDAD: bloqueante
TITULO: UI empleados ejecuta acciones de orden (/accept, /kitchen/*, /deliver) pero no existen endpoints
DESCRIPCION: Módulos de empleados (kitchen-board, orders-board, waiter-board) construyen acciones que llaman /api/orders/<id>/accept, /api/orders/<id>/kitchen/start, /api/orders/<id>/kitchen/ready y /api/orders/<id>/deliver. Además, cuando usan `requestJSON`/`authenticatedFetch` (core/http), esos endpoints se reescriben a /<scope>/api/orders/* (ej: /chef/api/orders/*). En el backend, pronto-employees solo expone GET /api/orders (sin endpoints de acción) y pronto-api no expone esos endpoints; por lo tanto las acciones retornan 404.
PASOS_REPRODUCIR: 1) Abrir dashboard empleados (cocina o mesero). 2) Intentar avanzar una orden con botones (iniciar, listo, entregar). 3) Ver request a /api/orders/<id>/kitchen/start, etc.
RESULTADO_ACTUAL: 404 en endpoints de acción (o /<scope>/api/* por rewrite); la UI muestra error/toast y el estado no cambia.
RESULTADO_ESPERADO: Endpoints de acción existentes (en el BFF de empleados o en API) que actualicen el estado de la orden respetando OrderStatus/ScopeGuard/JWT.
UBICACION: pronto-static/src/vue/employees/modules/kitchen-board.ts:77-86; pronto-static/src/vue/employees/modules/orders-board.ts:74-120
EVIDENCIA: endpoints en kitchen-board.ts; `pronto-static/src/vue/employees/core/http.ts` reescribe /api/* -> /<scope>/api/*; escaneo de rutas muestra solo /api/orders (GET), /api/orders/<id>/cancel, /api/orders/<id>/modify, /api/orders/<id>/request-check.
HIPOTESIS_CAUSA: Migración a estado canónico (OrderStatus) quedó incompleta; UI apuntando a endpoints no implementados en backend.
ESTADO: RESUELTO
---

SOLUCION:
Se implementaron endpoints de acciones de orden en `/api/orders/*` en `pronto-employees` y se elimino el rewrite `/<scope>/api/*` en el wrapper HTTP.

COMMIT:
multi:f03ce0b,237f17b,2f6533a

FECHA_RESOLUCION:
2026-02-05
