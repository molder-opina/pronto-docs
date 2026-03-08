ID: CLIENT-20260307-007
FECHA: 2026-03-07
PROYECTO: pronto-client
SEVERIDAD: bloqueante
TITULO: rutas web publicas sin enforcement de autenticacion
DESCRIPCION:
  `pronto-client/src/pronto_clients/routes/web.py` exponía vistas SSR de negocio sin enforcement explícito
  de autenticación (`/`, `/checkout`, `/menu-alt`, `/feedback`, `/kiosk/<location>`), en contradicción
  con el guardrail P0 que prohíbe páginas/flujo sin auth salvo excepciones puntuales.
PASOS_REPRODUCIR:
  1. Revisar decorators y guards en `pronto-client/src/pronto_clients/routes/web.py`.
  2. Verificar que `home`, `checkout`, `menu_alt`, `feedback_form` y `kiosk_screen` no validaban sesión cliente.
RESULTADO_ACTUAL:
  Las vistas de negocio requieren sesión cliente; login/register son públicas explícitas; y kiosko ya no es accesible indiscriminadamente.
RESULTADO_ESPERADO:
  Solo login/register deben quedar públicos; el resto debe exigir autenticación válida y ownership cuando aplica.
UBICACION:
  - `pronto-client/src/pronto_clients/routes/web.py`
  - `pronto-client/src/pronto_clients/templates/auth.html`
  - `pronto-client/tests/test_web_auth_regressions.py`
ESTADO: RESUELTO
SOLUCION:
  Se añadió en `web.py` una capa de auth SSR basada en `session['customer_ref']` + `customer_session_store`, consistente con el canon de `pronto-client`.
  Cambios concretos:
  - nuevas rutas públicas `/login` y `/register`
  - `home`, `checkout`, `menu-alt` y `feedback` ahora redirigen a login si no hay sesión válida
  - `/feedback` valida ownership de `DiningSession.customer_id` contra el cliente autenticado
  - `/kiosk/<location>` ahora exige sesión kiosk coincidente o bootstrap autorizado por el mismo gate de kiosko
  - se añadió `auth.html` como superficie pública explícita para login/register
  Se agregaron regresiones self-contained en `pronto-client/tests/test_web_auth_regressions.py`.
  Validación: `python3 -m py_compile pronto-client/src/pronto_clients/routes/web.py pronto-client/tests/test_web_auth_regressions.py` => OK;
  `PYTHONPATH=pronto-client/src:pronto-libs/src pronto-api/.venv/bin/python -m pytest pronto-client/tests/test_web_auth_regressions.py -q` => `6 passed`.
COMMIT: b976433
FECHA_RESOLUCION: 2026-03-07
