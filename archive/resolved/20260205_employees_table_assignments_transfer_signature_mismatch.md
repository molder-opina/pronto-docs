---
ID: 20260205-EMP-TABLE-TRANSFER-ARGS
FECHA: 2026-02-05
PROYECTO: pronto-employees
SEVERIDAD: alta
TITULO: Table transfer accept/reject llama servicios con firma incorrecta
DESCRIPCION: Los endpoints de transferencias de mesa en pronto-employees invocan `accept_transfer_request` y `reject_transfer_request` con el orden de parametros incorrecto y asumen un tipo de retorno distinto al real. Esto puede causar 404/500 o respuestas incorrectas al aceptar/rechazar solicitudes de transferencia.
PASOS_REPRODUCIR: 1. Abrir el modal de asignacion de mesas (table-assignment) y crear/recibir una solicitud de transferencia. 2. Intentar aceptar o rechazar la solicitud desde la UI. 3. Observar que el backend falla o responde error.
RESULTADO_ACTUAL: El backend llama a los servicios con argumentos invertidos (waiter_id como transfer_request_id) y trata el retorno como (data,status) cuando el servicio retorna un dict/list o un tuple con orden distinto, provocando errores o comportamiento inesperado.
RESULTADO_ESPERADO: El backend debe llamar `accept_transfer_request(transfer_request_id, accepting_waiter_id, transfer_orders=...)` y `reject_transfer_request(transfer_request_id, rejecting_waiter_id)` y manejar correctamente su retorno.
UBICACION: `pronto-employees/src/pronto_employees/routes/api/table_assignments.py` y `pronto-libs/src/pronto_shared/services/waiter_table_assignment_service.py`
EVIDENCIA: En `table_assignments.py` se llama `accept_transfer_request(waiter_id, request_id, ...)` pero la firma real es `accept_transfer_request(transfer_request_id, accepting_waiter_id, ...)`. Similar para `reject_transfer_request`.
HIPOTESIS_CAUSA: Confusion por nombres de parametros (request_id vs waiter_id) y no verificar la firma/retorno del servicio compartido antes de integrar el endpoint.
ESTADO: RESUELTO
---

SOLUCION:
Se alinearon firmas/argumentos del flujo de transferencias de mesas con los servicios en `pronto_shared` y se expuso API estable.

COMMIT:
2f6533a

FECHA_RESOLUCION:
2026-02-05
