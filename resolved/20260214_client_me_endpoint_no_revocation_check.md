ID: BUG-20260214-003
FECHA: 2026-02-14
PROYECTO: pronto-client
SEVERIDAD: alta
TITULO: /api/me no verifica revocación de customer_ref
DESCRIPCION: |
  El endpoint GET /api/me en pronto-client obtiene customer_ref de flask.session y
  busca los datos en Redis, pero NO verifica si el customer_ref fue revocado (logout).
  Como `revoke()` en customer_session_store NO borra la key principal (solo crea una
  key de revocación separada), `/api/me` puede retornar datos del cliente incluso
  después de haber hecho logout.
PASOS_REPRODUCIR: |
  1. Login como cliente → obtener customer_ref en session.
  2. Logout → se ejecuta revoke(customer_ref) + session.pop("customer_ref").
  3. Si el browser aún tiene la cookie de session (por timing o race condition),
     GET /api/me devuelve los datos del cliente porque la key principal sigue en Redis.
RESULTADO_ACTUAL: |
  /api/me solo verifica si customer_ref existe en Redis, no si está revocado.
RESULTADO_ESPERADO: |
  /api/me debe verificar `is_revoked(customer_ref)` antes de retornar datos.
  Si está revocado, limpiar session y retornar `{"customer": null}`.
UBICACION: pronto-client/src/pronto_clients/routes/api/auth.py (función me(), líneas 196-218)
EVIDENCIA: Línea 210 llama `get_customer(customer_ref)` sin verificar `is_revoked()` primero. Comparar con `require_customer_session` en pronto-api que SÍ verifica revocación (auth/decorators.py línea 41).
HIPOTESIS_CAUSA: Se implementó el flujo de revocación en el decorator de pronto-api pero se omitió en el endpoint directo de pronto-client.
ESTADO: RESUELTO
SOLUCION: Añadido chequeo `is_revoked(customer_ref)` en endpoint `/me` antes de llamar `get_customer()`. Si está revocado, se limpia session y retorna `{"customer": null}`. También se añadió `session.clear()` en login/logout para evitar datos residuales.
COMMIT: pendiente
FECHA_RESOLUCION: 2026-02-14
