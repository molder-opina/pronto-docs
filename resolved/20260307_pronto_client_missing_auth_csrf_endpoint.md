ID: CLIENT-20260307-005
FECHA: 2026-03-07
PROYECTO: pronto-client
SEVERIDAD: alta
TITULO: frontend invoca /api/auth/csrf pero no existe endpoint backend
DESCRIPCION:
  `templates/index.html` y el cliente Vue invocaban `GET /api/auth/csrf`, pero en
  `routes/api/auth.py` solo existían `/login`, `/register` y `/logout`. Esto rompía
  el refresh de token CSRF y dejaba flujos de mutación dependientes de un endpoint inexistente.
PASOS_REPRODUCIR:
  1. Revisar `pronto-client/src/pronto_clients/routes/api/auth.py` rutas declaradas.
  2. Revisar llamadas a `/api/auth/csrf` en frontend cliente.
RESULTADO_ACTUAL:
  El BFF ahora expone `GET /api/auth/csrf` y devuelve `csrf_token` con `generate_csrf()`.
RESULTADO_ESPERADO:
  El endpoint debe existir y responder con token CSRF refrescado para el frontend.
UBICACION:
  - `pronto-client/src/pronto_clients/routes/api/auth.py`
ESTADO: RESUELTO
SOLUCION:
  Se agregó `@auth_bp.get("/csrf")` en el BFF de `pronto-client`, devolviendo `success_response({"csrf_token": generate_csrf()})`.
  Validación: `python3 -m py_compile pronto-client/src/pronto_clients/routes/api/auth.py` => OK; verificación textual confirma presencia de
  `@auth_bp.get("/csrf")`, `generate_csrf` y `success_response` en el módulo.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07
