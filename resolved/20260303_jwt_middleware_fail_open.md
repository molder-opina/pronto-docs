ID: SEC-20260303-004
FECHA: 2026-03-03
PROYECTO: pronto-libs
SEVERIDAD: media
TITULO: Validación de scope tipo "fail-open" en jwt_middleware.py

DESCRIPCION: |
  La función `validate_api_scope` en `jwt_middleware.py` utilizaba lógica fail-open para rutas scopeadas inválidas, permitiendo saltar validación de scope cuando no coincidía el patrón esperado.

RESULTADO_ACTUAL: |
  Las rutas scopeadas con prefijo inválido podían omitir validación de scope.

RESULTADO_ESPERADO: |
  El Scope Guard debe ser fail-closed para rutas scopeadas inválidas y responder error explícito.

UBICACION: |
  - `pronto-libs/src/pronto_shared/jwt_middleware.py` (función `validate_api_scope`)

ESTADO: RESUELTO

SOLUCION: |
  Se cambió `validate_api_scope` a fail-closed para rutas `/<scope>/api/*` con scope inválido, respondiendo `400` con código `INVALID_SCOPE_PATH`. Se mantuvo bypass explícito para rutas canónicas `/api/*` para no interferir con `pronto-api`.

COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-05
