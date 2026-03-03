---
ID: ERR-20260205-PAID-RECENT-STATUS-CONTRADICTION
FECHA: 2026-02-05
PROYECTO: pronto-employees
SEVERIDAD: alta
TITULO: paid_recent_minutes puede devolver vacio si status no incluye paid
DESCRIPCION: El endpoint GET /api/orders aplica primero el filtro status=IN(...) y luego aplica paid_recent_minutes forzando workflow_status='paid'. Si el caller manda status que no incluye 'paid' (ej status=cancelled) junto con paid_recent_minutes, la consulta queda contradictoria y retorna 0 resultados. El contrato requiere que paid_recent_minutes fuerce status=paid siempre.
PASOS_REPRODUCIR: 1) Llamar GET /api/orders?status=cancelled&paid_recent_minutes=15. 2) Observar que la respuesta retorna 0 aunque existan ordenes pagadas recientes.
RESULTADO_ACTUAL: Retorna lista vacia por combinacion de filtros contradictorios.
RESULTADO_ESPERADO: paid_recent_minutes debe forzar status=paid (ignorando otros status) y filtrar solo por paid_at.
UBICACION: pronto-employees/src/pronto_employees/routes/api/orders.py
EVIDENCIA: paid_recent_minutes solo fuerza status=paid cuando no viene status, pero igual se aplica filtro status IN(...) antes de workflow_status='paid'.
HIPOTESIS_CAUSA: Enforce de paid_recent_minutes implementado de forma parcial.
ESTADO: RESUELTO
---

SOLUCION: Cuando paid_recent_minutes viene presente, el BFF fuerza status=paid siempre (ignora status previos) y filtra exclusivamente por paid_at.
COMMIT: b1b4855
FECHA_RESOLUCION: 2026-02-05

