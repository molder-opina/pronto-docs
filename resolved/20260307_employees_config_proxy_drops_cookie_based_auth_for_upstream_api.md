ID: TEST-20260307-053
FECHA: 2026-03-07
PROYECTO: pronto-employees,pronto-tests
SEVERIDAD: media
TITULO: employees config proxy reenvía Authorization vacío y rompe /<scope>/api/config tras login web
DESCRIPCION:
  Los tests live de configuración fallaban porque `pronto-employees/src/pronto_employees/routes/api/config.py`
  reenviaba `Authorization` directamente desde `request.headers`, pero después de un login web la sesión del
  empleado vive en cookies namespaced (`access_token_admin`, `access_token_system`) y el navegador no envía
  un header Bearer. Además, los PUT requerían reenviar `Cookie` para que el upstream validara CSRF.
PASOS_REPRODUCIR:
  1. Hacer login web en `http://localhost:6081/admin/login`.
  2. Solicitar `GET /admin/api/config` o `PUT /admin/api/config/<id>`.
  3. Observar `500` en employees con upstream `401/400`.
RESULTADO_ACTUAL:
  `/admin/api/config` y `/system/api/config` fallaban aunque la sesión web fuera válida.
RESULTADO_ESPERADO:
  El proxy debe tomar el JWT desde la cookie namespaced del scope y propagarlo como `Authorization: Bearer ...`,
  reenviando también la cookie/sesión para CSRF en mutaciones.
UBICACION:
  - `pronto-employees/src/pronto_employees/routes/api/config.py`
ESTADO: RESUELTO
SOLUCION:
  El proxy legacy de config ahora resuelve el scope desde path/header, lee el JWT desde `access_token_<scope>`,
  envía `Authorization: Bearer ...`, propaga `X-Correlation-ID`, `X-CSRFToken` y `Cookie` al upstream.
  Validación: `GET /admin/api/config` => 200, `GET /system/api/config` => 200 y
  `pytest pronto-tests/tests/functionality/e2e/test_config_settings_roundtrip_live.py -q -rs` => `3 passed`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07
