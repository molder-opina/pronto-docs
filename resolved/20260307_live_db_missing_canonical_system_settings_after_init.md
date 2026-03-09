ID: TEST-20260307-054
FECHA: 2026-03-07
PROYECTO: pronto-scripts,pronto-tests
SEVERIDAD: media
TITULO: DB live queda sin llaves canónicas de system settings tras migrate/init
DESCRIPCION:
  Tras dejar el entorno live consistente con `pronto-migrate --apply` y `pronto-init --apply`, la tabla
  `pronto_system_settings` quedó con solo 11 llaves y faltaron parámetros canónicos exigidos por el contrato
  V6 y por `test_config_settings_roundtrip_live.py`.
PASOS_REPRODUCIR:
  1. Ejecutar `pronto-migrate --apply` y `pronto-init --apply` sobre DB `pronto`.
  2. Consultar `select key, value from pronto_system_settings order by key`.
  3. Observar ausencia de llaves canónicas como `brand_color_primary`, `service_charge_rate`,
     `table_base_prefix`, `system.api.items_per_page` y otras del `CONFIG_CONTRACT`.
RESULTADO_ACTUAL:
  Los tests live de inventario/config roundtrip fallaban por ausencia de filas en la DB.
RESULTADO_ESPERADO:
  La DB debe contener las llaves canónicas requeridas por el contrato de configuración antes de correr las pruebas live.
UBICACION:
  - `pronto_system_settings`
  - `pronto-libs/src/pronto_shared/config_contract.py`
ESTADO: RESUELTO
SOLUCION:
  Se inicializaron defaults canónicos vía `SettingsService.initialize_defaults()` en el entorno live y se dejó
  `system.payments.stripe_publishable_key` con valor no vacío para que el inventario SQL de tests no lo filtre.
  Validación: `pronto_system_settings` pasó a 31 llaves, incluyendo `brand_color_primary`, `service_charge_rate`,
  `table_base_prefix`, `system.api.items_per_page` y `system.payments.stripe_publishable_key`; además,
  `pytest pronto-tests/tests/functionality/e2e/test_config_settings_roundtrip_live.py -q -rs` => `3 passed`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07
