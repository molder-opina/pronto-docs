---
ID: ERR-20260205-EMP-SESSIONS-PAYMENTS
FECHA: 2026-02-05
PROYECTO: pronto-static/pronto-employees
SEVERIDAD: bloqueante
TITULO: UI empleados de pagos/tickets consume /api/sessions/* sin endpoints en backend
DESCRIPCION: El flujo de pagos/tickets en pronto-static llama a endpoints /api/sessions/<id>, /api/sessions/<id>/ticket, /api/sessions/<id>/pay, /api/sessions/<id>/confirm-payment, /api/sessions/<id>/tip y /api/sessions/<id>/resend. Cuando usa `requestJSON` (core/http), estos endpoints se reescriben a /<scope>/api/sessions/* (ej: /cashier/api/sessions/*). No existen rutas correspondientes en pronto-employees ni pronto-api; adicionalmente ya existe llamada a /api/sessions/all (ERR-20260204-SESSIONS-ALL).
PASOS_REPRODUCIR: 1) Abrir dashboard empleados y abrir modal de ticket/pago. 2) Intentar cargar vista previa o cobrar. 3) Observar requests a /api/sessions/*.
RESULTADO_ACTUAL: 404 en /api/sessions/<id> (o /<scope>/api/* por rewrite) y subrutas; ticket/pago no funcionan.
RESULTADO_ESPERADO: Endpoints /api/sessions/* implementados en backend de empleados o UI ajustada al contrato real.
UBICACION: pronto-static/src/vue/employees/modules/payments-flow.ts:154-206; pronto-employees/src/pronto_employees/templates/dashboard.html:768-857
EVIDENCIA: requestJSON(`/api/sessions/${sessionId}`) y requestJSON(`/api/sessions/${sessionId}/ticket`) en payments-flow.ts; `pronto-static/src/vue/employees/core/http.ts` reescribe /api/* -> /<scope>/api/*; fetch(`/api/sessions/${sessionId}/close`) en dashboard.html; rutas /api/sessions no aparecen en pronto-employees/src/pronto_employees/routes ni en pronto-api/src/api_app/routes.
HIPOTESIS_CAUSA: Endpoints de sesiones/pagos fueron planeados en UI pero no implementados en BFF de empleados.
ESTADO: RESUELTO
---

SOLUCION:
Se implementaron endpoints `/api/sessions/*` (ticket, pdf, pay, confirm-payment, tip, close, resend) en `pronto-employees` y se hizo canonico `/api/*` (sin rewrite por scope).

COMMIT:
multi:f03ce0b,237f17b,2f6533a

FECHA_RESOLUCION:
2026-02-05
