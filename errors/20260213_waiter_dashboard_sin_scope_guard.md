ID: 20260213_waiter_dashboard_sin_scope_guard
FECHA: 2026-02-13
PROYECTO: pronto-employees
SEVERIDAD: bloqueante
TITULO: /waiter/dashboard accesible sin autenticacion
DESCRIPCION: Se detecto que el blueprint de waiter no aplica ScopeGuard en before_request, por lo que `/waiter/dashboard` responde 200 sin JWT/sesion valida.
PASOS_REPRODUCIR: 1) Ejecutar `curl -i http://localhost:6081/waiter/dashboard`. 2) Observar HTTP 200 sin cookies de auth. 3) Comparar con `/admin/dashboard` que responde 302 a login.
RESULTADO_ACTUAL: Acceso anonimo permitido al dashboard de waiter.
RESULTADO_ESPERADO: Redireccion a `/waiter/login` cuando no hay autenticacion o scope activo waiter.
UBICACION: pronto-employees/src/pronto_employees/routes/waiter/auth.py
EVIDENCIA: `curl` sin autenticacion devuelve `200` en `/waiter/dashboard`.
HIPOTESIS_CAUSA: Omision accidental del hook `@waiter_bp.before_request` al refactor del blueprint.
ESTADO: ABIERTO
