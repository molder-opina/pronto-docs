---
ID: ERR-20260208-001
FECHA: 2026-02-08
PROYECTO: pronto-api
SEVERIDAD: bloqueante
TITULO: Endpoints de pago en pronto-api son stubs (código muerto)
DESCRIPCION: Los endpoints /pay, /confirm-payment y /tip en el módulo de sesiones de pronto-api retornan respuestas exitosas estáticas sin ejecutar lógica de negocio ni persistir cambios en la base de datos. La lógica real reside duplicada en pronto-employees.
PASOS_REPRODUCIR:
1) Realizar POST a /api/employees/sessions/1/pay.
2) Verificar que la respuesta es {"status": "paid"}.
3) Consultar la base de datos y observar que la sesión 1 sigue "open".
RESULTADO_ACTUAL: Respuesta estática 200 OK sin efectos secundarios.
RESULTADO_ESPERADO: La API debe invocar order_service.finalize_payment y actualizar el estado real.
UBICACION: pronto-api/src/api_app/routes/employees/sessions.py
EVIDENCIA: Líneas 110-125 contienen return success_response({...}) sin llamadas a service.
HIPOTESIS_CAUSA: Migración incompleta de lógica desde pronto-employees a pronto-api. El error original reportaba falsos positivos sobre `/pay`, `/confirm-payment` y `/tip`, que SÍ estaban implementados. El único stub real era `/ticket.pdf`.
ESTADO: RESUELTO
SOLUCION: 
1. Verificado que `/pay`, `/confirm-payment` y `/tip` ya llamaban correctamente a `order_service` (no eran stubs).
2. Reemplazado el stub de `/api/sessions/{id}/ticket.pdf` (que devolvía URL mock) por la generación real de PDF usando `TicketPDFService`.
FECHA_RESOLUCION: 2026-02-09
---
