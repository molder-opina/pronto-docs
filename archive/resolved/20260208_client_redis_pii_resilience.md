---
ID: ERR-20260208-016
FECHA: 2026-02-08
PROYECTO: pronto-client
SEVERIDAD: alta
TITULO: Falta de resiliencia en el guardrail de PII ante fallos de Redis
DESCRIPCION: El sistema de protección de PII (`customer_session.py`) depende de Redis para almacenar datos sensibles de clientes anónimos. Si Redis no está disponible, la función `store_customer_ref` retorna un string vacío y loguea una advertencia, pero permite que la aplicación continúe. Esto resulta en la pérdida de información de contacto del cliente (necesaria para el ticket) o, peor aún, incita a los desarrolladores a reintroducir la PII en `flask.session` para "arreglar" el flujo, violando el guardrail de seguridad.
PASOS_REPRODUCIR:
1) Apagar el servicio de Redis.
2) Realizar un pedido como cliente invitado proporcionando email/teléfono.
3) Observar que la orden se crea pero el campo `customer_ref` en la respuesta está vacío.
4) Intentar recuperar los datos del cliente para el ticket y fallar.
RESULTADO_ACTUAL: Degradación silenciosa con pérdida de datos y riesgo de violación de guardrails.
RESULTADO_ESPERADO: El sistema debe manejar el fallo de Redis de forma explícita. Si es crítico, debe rechazar la operación con un error claro; si no, debe cifrar temporalmente la PII en el cliente o usar un almacén persistente alternativo (como la propia DB cifrada).
UBICACION: pronto-client/src/pronto_clients/utils/customer_session.py
EVIDENCIA: Líneas 42-45 contienen un `return ""` si no hay cliente de Redis.
HIPOTESIS_CAUSA: Diseño del guardrail asumiendo disponibilidad total de Redis.
ESTADO: PENDIENTE
---
PLAN DE SOLUCION:
1. Implementar un fallback en `store_customer_ref`: si Redis falla, almacenar la PII cifrada (usando la clave secreta del sistema) directamente en la base de datos `pronto_customers` marcada como "temporal".
2. Asegurar que `get_customer_data` sepa buscar tanto en Redis (vía ref) como en la DB cifrada como fallback.
3. Notificar al sistema de monitoreo sobre la indisponibilidad de Redis.
