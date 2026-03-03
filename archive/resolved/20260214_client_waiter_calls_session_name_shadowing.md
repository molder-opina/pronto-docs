ID: BUG-20260214-007
FECHA: 2026-02-14
PROYECTO: pronto-client
SEVERIDAD: bloqueante
TITULO: waiter_calls.py name shadowing: flask.session sobreescrita por SQLAlchemy session
DESCRIPCION: |
  En get_waiter_call_status y get_waiter_call_status_alt, el auth guard usa
  `session.get("customer_ref")` (flask.session), pero inmediatamente después
  `with get_session() as session:` sobreescribe la variable `session` con la
  sesión de SQLAlchemy. Esto causa un UnboundLocalError o comportamiento
  inesperado porque Python trata `session` como variable local en todo el scope
  de la función al ver la asignación en el `with`.
  Bug introducido al agregar auth guard (BUG-20260214-005) sin renombrar la
  variable del context manager.
PASOS_REPRODUCIR: |
  1. Hacer GET /api/call-waiter/status/1 con customer_ref válido en session.
  2. Python lanza UnboundLocalError: 'session' referenced before assignment.
RESULTADO_ACTUAL: |
  `with get_session() as session:` sobreescribe flask.session en el scope local.
  El auth guard `session.get("customer_ref")` falla.
RESULTADO_ESPERADO: |
  El context manager debe usar un nombre diferente (`db_session`) para no
  colisionar con el import de flask.session.
UBICACION: pronto-client/src/pronto_clients/routes/api/waiter_calls.py (funciones get_waiter_call_status y get_waiter_call_status_alt)
EVIDENCIA: Líneas 258 y 295 usaban `with get_session() as session:` colisionando con `from flask import session` en línea 8.
HIPOTESIS_CAUSA: Al agregar el auth guard se reutilizó el nombre `session` ya existente en el context manager sin notar la colisión con el import de flask.
ESTADO: RESUELTO
SOLUCION: Renombrado `with get_session() as session:` a `with get_session() as db_session:` en ambas funciones.
COMMIT: pendiente
FECHA_RESOLUCION: 2026-02-14
