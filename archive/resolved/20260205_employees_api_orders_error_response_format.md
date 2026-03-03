---
ID: ERR-20260205-EMPLOYEES-API-ORDERS-ERROR-RESPONSE
FECHA: 2026-02-05
PROYECTO: pronto-employees
SEVERIDAD: media
TITULO: /api/orders devuelve errores fuera de success_response/error_response
DESCRIPCION: El endpoint GET /api/orders en pronto-employees retorna {"error": "..."} en validaciones de query params, en lugar de usar el contrato estandar error_response. Esto rompe consistencia de contratos UI↔backend y dificulta QA.
PASOS_REPRODUCIR: 1) Llamar GET /api/orders?paid_recent_minutes=abc. 2) Observar que el payload de error no usa error_response.
RESULTADO_ACTUAL: 400 con body {"error": "..."}.
RESULTADO_ESPERADO: 400 con body retornado por pronto_shared.serializers.error_response (contrato estandar).
UBICACION: pronto-employees/src/pronto_employees/routes/api/orders.py
EVIDENCIA: return {"error": "paid_recent_minutes invalido"}, HTTPStatus.BAD_REQUEST
HIPOTESIS_CAUSA: Implementacion inicial del endpoint sin aplicar helper error_response.
ESTADO: RESUELTO
---

SOLUCION: Se reemplazaron retornos {"error": "..."} por error_response(...) para mantener el contrato estandar en endpoints /routes/api/.
COMMIT: b1b4855
FECHA_RESOLUCION: 2026-02-05
