ID: 20260303_admin_config_shows_system_keys_that_403_on_save
FECHA: 2026-03-03
PROYECTO: pronto-employees | pronto-static | pronto-tests
SEVERIDAD: alta
TITULO: Admin ve parámetros system en configuración y Guardar falla con 403
DESCRIPCION: La pantalla `/admin/dashboard/config` mostraba parámetros `system.*` que no pertenecen al scope admin. Al intentar guardarlos desde la consola admin, el backend respondía 403 y el frontend redirigía a `authorization-error`, dejando botones `Guardar` visibles que no funcionaban para ese panel.
PASOS_REPRODUCIR:
1. Iniciar sesión en `http://localhost:6081/admin/dashboard/config`.
2. Buscar un parámetro de `system`, por ejemplo `system.api.items_per_page` o `system.performance.poll_interval_ms`.
3. Clic en `Editar` y luego en `Guardar`.
RESULTADO_ACTUAL:
- La consola admin mostraba parámetros de infraestructura.
- El click en `Guardar` de esos parámetros devolvía 403 y redirigía a `/admin/authorization-error?...`.
RESULTADO_ESPERADO:
- En `/admin/dashboard/config` solo deben aparecer parámetros editables por admin.
- Todos los botones `Guardar` visibles en ese panel deben funcionar sin 403.
UBICACION:
- pronto-employees/src/pronto_employees/routes/api/config.py
- pronto-static/src/vue/employees/admin/views/config/SystemSettings.vue
- pronto-tests/tests/functionality/e2e/test_config_settings_roundtrip_live.py
EVIDENCIA:
- Validación en navegador:
  - `restaurant_name` guarda con `PUT /admin/api/config/<uuid> => 200`
  - `/admin/dashboard/config` deja de mostrar la sección `system`
- Suite live:
  - `pronto-tests/.venv-test/bin/python -m pytest pronto-tests/tests/functionality/e2e/test_config_settings_roundtrip_live.py -q`
  - Resultado final: `3 passed`
HIPOTESIS_CAUSA:
- El endpoint SSR `/{scope}/api/config` en pronto-employees devolvía el inventario completo sin filtrar por scope y exponía llaves `system.*` en la consola admin.
- La resolución de scope en el SSR no era consistente y podía depender del path en lugar del header `X-App-Context`.
ESTADO: RESUELTO
SOLUCION:
- Se filtró `/{scope}/api/config` por scope real de consola, priorizando `X-App-Context`.
- `/admin` ahora recibe solo parámetros no `system.*`.
- `/system` recibe únicamente parámetros `system.*`.
- Se añadió cobertura en pronto-tests para asegurar que el inventario de configuración está filtrado por scope y que el roundtrip/restauración sigue funcionando.
- Se endureció el helper de login del suite live para tolerar el arranque del servicio tras restart.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03
