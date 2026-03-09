ID: TEST-20260307-055
FECHA: 2026-03-07
PROYECTO: pronto-api,pronto-tests
SEVERIDAD: media
TITULO: admin no puede actualizar system.api.items_per_page aunque el bootstrap público depende de esa llave
DESCRIPCION:
  El test live `test_public_bootstrap_uses_system_items_per_page` fallaba porque `PUT /api/config/<id>`
  rechazaba a `admin` con 403 cuando la llave objetivo era `system.api.items_per_page`. El endpoint trataba toda
  llave `system.*` como exclusiva de `system`, aunque ese parámetro canónico se consume en `GET /api/config/public`
  como `items_per_page` del bootstrap público.
PASOS_REPRODUCIR:
  1. Login web como `admin@cafeteria.test`.
  2. Resolver el id de `system.api.items_per_page` en `pronto_system_settings`.
  3. Ejecutar `PUT /admin/api/config/<id>` con `value=25`.
  4. Observar `500` en employees y `403` upstream desde `pronto-api`.
RESULTADO_ACTUAL:
  Admin no podía actualizar el parámetro canónico que usa el bootstrap público para `items_per_page`.
RESULTADO_ESPERADO:
  Admin debe poder actualizar específicamente `system.api.items_per_page` sin exponer el resto de `system.*`.
UBICACION:
  - `pronto-api/src/api_app/routes/config.py`
ESTADO: RESUELTO
SOLUCION:
  Se agregó un allowlist mínimo `_ADMIN_PUBLIC_SYSTEM_UPDATE_ALLOWLIST = {"system.api.items_per_page"}` y el gate
  de update ahora usa `_can_scope_update_key`, manteniendo el inventario `system.*` oculto para admin pero
  permitiendo la actualización puntual que alimenta el bootstrap público. Validación:
  `pytest pronto-tests/tests/functionality/e2e/test_config_settings_roundtrip_live.py -q -rs` => `3 passed`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07
