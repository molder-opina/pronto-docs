ID: PRONTO-CLIENT-001
FECHA: 2026-03-07
PROYECTO: pronto-client
SEVERIDAD: bloqueante
TITULO: pronto-client implementa lógica de negocio con escritura directa a DB
DESCRIPCION:
pronto-client está implementando endpoints de negocio con escritura directa a la base de datos, violando AGENTS.md sección 12.4.2 que establece que pronto-client solo puede renderizar SSR/UI y no puede definir ni mantener endpoints /api/* de negocio.

La autoridad única de API debe ser pronto-api en :6082 bajo "/api/*".

PASOS_REPRODUCIR:
1. Ejecutar: rg -n "db_session\.(add|commit)" pronto-client/src/pronto_clients/routes/api/
2. Observar múltiples archivos escribiendo directamente a DB
3. Ejecutar: rg -n "DEPRECATED" pronto-client/src/pronto_clients/routes/api/
4. Observar que solo __init__.py tiene marca DEPRECATED

RESULTADO_ACTUAL:
- 34 endpoints POST implementando lógica de mutación en pronto-client
- 5 archivos escribiendo directamente a DB:
  - waiter_calls.py (Crea WaiterCall, Notification)
  - stripe_payments.py (Modifica DiningSession, crea WaiterCall, Notification)
  - notifications.py (Modifica Notification)
  - split_bills.py (Crea/modifica SplitBill, SplitBillPerson, SplitBillAssignment)
  - feedback_email.py (Crea Feedback)
- 15 archivos sin marca DEPRECATED ni plan de retiro explícito

RESULTADO_ESPERADO:
- pronto-client solo implementa SSR/UI
- Todos los endpoints de negocio viven en pronto-api
- pronto-client expone endpoints /api/ solo como proxy técnico BFF temporal
- Cualquier endpoint temporal tiene marca DEPRECATED y plan de retiro explícito

UBICACION:
pronto-client/src/pronto_clients/routes/api/

EVIDENCIA:
- pronto-client/src/pronto_clients/routes/api/__init__.py:4-6 (único archivo con marca DEPRECATED)
- pronto-client/src/pronto_clients/routes/api/split_bills.py:128,141,147,340,341,406,588 (db_session.add, db_session.commit)
- pronto-client/src/pronto_clients/routes/api/stripe_payments.py:84,159,177,178 (db_session.add, db_session.commit)
- pronto-client/src/pronto_clients/routes/api/waiter_calls.py:170,195,238 (db_session.add, db_session.commit)
- pronto-client/src/pronto_clients/routes/api/notifications.py:105 (db_session.commit)
- pronto-client/src/pronto_clients/routes/api/feedback_email.py:253 (db_session.add)

HIPOTESIS_CAUSA:
Los endpoints de negocio se implementaron en pronto-client durante desarrollo inicial sin seguir la separación arquitectónica definida en AGENTS.md. No se agregó marca DEPRECATED ni plan de retiro cuando se documentó la arquitectura canónica.

ESTADO: ABIERTO
