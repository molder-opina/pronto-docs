ID: 20260303_config_roundtrip_public_bootstrap_and_boolean_alias_failures
FECHA: 2026-03-03
PROYECTO: pronto-employees | pronto-libs | pronto-tests
SEVERIDAD: alta
TITULO: Configuración runtime no redondea bien bootstrap público y falla con aliases de tipo boolean
DESCRIPCION: Al ejecutar una prueba live de roundtrip sobre todos los parámetros configurados desde /admin/dashboard/config, varios parámetros no quedaban reflejados correctamente en el bootstrap público SSR o se serializaban de forma inconsistente al persistirse y restaurarse. El caso afectaba la validación end-to-end del panel de configuración.
PASOS_REPRODUCIR:
1. Iniciar sesión en http://localhost:6081/admin/dashboard/config con un admin válido.
2. Ejecutar el suite live pronto-tests/tests/functionality/e2e/test_config_settings_roundtrip_live.py.
3. Observar el roundtrip de restaurant_name, waiter_can_collect, show_estimated_time y service_charge_rate.
RESULTADO_ACTUAL:
- restaurant_name no se reflejaba en /admin/api/public/config.
- waiter_can_collect no aparecía en /admin/api/public/config.
- show_estimated_time con value_type=boolean se persistía como True/False capitalizado y no normalizaba a true/false.
- la restauración exacta de float perdía el formato textual original (ej. 0.10 -> 0.1).
RESULTADO_ESPERADO:
- Todo parámetro mutado debe persistir y reflejarse correctamente en DB y en el bootstrap público cuando corresponda.
- Los aliases bool/boolean deben normalizarse igual.
- El suite debe restaurar el valor original sin dejar drift.
UBICACION:
- pronto-employees/src/pronto_employees/routes/api/config.py
- pronto-libs/src/pronto_shared/services/business_config_service.py
- pronto-tests/tests/functionality/e2e/test_config_settings_roundtrip_live.py
EVIDENCIA:
- pronto-tests/.venv-test/bin/python -m pytest pronto-tests/tests/functionality/e2e/test_config_settings_roundtrip_live.py -q
- Resultado final: 2 passed
- Verificación posterior en PostgreSQL:
  - restaurant_name=Pronto-1772179654
  - waiter_can_collect=true
  - system.api.items_per_page=10
  - system.performance.poll_interval_ms=5000
HIPOTESIS_CAUSA:
- El bootstrap público SSR de pronto-employees usaba llaves legacy/fallbacks erróneos y no exponía waiter_can_collect.
- business_config_service solo normalizaba value_type=bool y no value_type=boolean.
- El suite restauraba floats usando coerción a float, perdiendo formato textual original.
ESTADO: RESUELTO
SOLUCION:
- Se corrigió el bootstrap público SSR de pronto-employees para leer restaurant_name desde la llave canónica y exponer waiter_can_collect.
- Se agregó soporte a aliases boolean/boolean en la normalización y persistencia de business_config_service.
- Se endureció el suite live de pronto-tests para recorrer todos los parámetros seteados, validar roundtrip, restaurar valores y comparar restauración canónica para booleanos y floats.
- Se registró el marker integration en pronto-tests/pytest.ini.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03
