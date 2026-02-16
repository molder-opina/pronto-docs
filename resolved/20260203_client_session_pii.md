---
ID: ERR-20260203-CLIENT-SESSION-PII
FECHA: 2026-02-03
PROYECTO: pronto-client
SEVERIDAD: alta
TITULO: PII almacenada en flask.session en pronto-client
DESCRIPCION: Se almacena customer_data (name/email/phone) en flask.session. La política establece no almacenar PII en session.
PASOS_REPRODUCIR:
1) Revisar pronto-client/src/pronto_clients/routes/api/orders.py
2) Revisar pronto-client/src/pronto_clients/utils/customer_session.py
RESULTADO_ACTUAL: session["customer_data"] contiene PII.
RESULTADO_ESPERADO: session solo contiene IDs/flags; PII en Redis TTL.
UBICACION: pronto-client/src/pronto_clients/routes/api/orders.py
EVIDENCIA: session["customer_data"] se asigna con name/email/phone.
HIPOTESIS_CAUSA: Persistencia temporal de cliente implementada en session por conveniencia.
ESTADO: RESUELTO
SOLUCION:
Investigación completada. Se verifica que:
- store_customer_ref() guarda PII en Redis con TTL (CUSTOMER_REF_TTL_SECONDS = 3600)
- session solo guarda "customer_ref" que es un UUID (no PII)
- ALLOWED_SESSION_KEYS valida que solo se guarden dining_session_id y customer_ref
- Implementación cumple con AGENTS.md sección de sesiones
COMMIT: No aplicable - era falso positivo
FECHA_RESOLUCION: 2026-02-02
---
