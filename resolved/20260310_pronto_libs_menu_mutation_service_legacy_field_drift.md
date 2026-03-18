ID: LIBS-20260310-MENU-MUTATION-SERVICE-LEGACY-FIELD-DRIFT
FECHA: 2026-03-10
PROYECTO: pronto-libs
SEVERIDAD: media
TITULO: `menu_mutation_service.py` conserva campos legacy incompatibles con el modelo actual
DESCRIPCION: Tras estabilizar `menu_service_impl.py`, `menu_home_module_service.py` y `menu_commercial_service.py`, la búsqueda transversal dejó cuatro ocurrencias restantes del mismo patrón concentradas en `menu_mutation_service.py`. Ese módulo todavía usa nombres de campos legacy (`ProductLabelMap.menu_item_id`, `MenuPackageComponent.menu_item_id`) incompatibles con el modelo actual (`product_id`, `package_item_id`, `label_id`, `display_order`).
PASOS_REPRODUCIR:
1. Ejecutar búsqueda transversal sobre servicios de menú.
2. Observar que las únicas ocurrencias restantes del patrón quedaron en `menu_mutation_service.py`.
3. Comparar el módulo contra `menu_models.py`.
RESULTADO_ACTUAL: `menu_mutation_service.py` mantiene referencias legacy aunque el resto del refactor ya usa el modelo actual.
RESULTADO_ESPERADO: El módulo de mutación queda alineado al modelo canónico y no conserva referencias legacy del mismo patrón.
UBICACION:
- pronto-libs/src/pronto_shared/services/menu_mutation_service.py
EVIDENCIA:
- `rg` posterior al fix anterior dejó 4 ocurrencias en `menu_mutation_service.py` y ninguna en los demás servicios activos del bloque menú.
HIPOTESIS_CAUSA: El módulo quedó como residuo de una extracción parcial del refactor de menú y no fue alineado cuando cambiaron los nombres canónicos del modelo.
ESTADO: RESUELTO
SOLUCION:
- `menu_mutation_service.py` se alineó al modelo actual en las cuatro ocurrencias restantes del patrón: `ProductLabelMap.product_id`, `MenuPackageComponent.package_item_id` y `label_id` se usan ya como campos canónicos.
- También se corrigieron las asociaciones internas para usar `display_order` en `MenuItemModifierGroup` y `MenuPackageComponent`, en lugar del antiguo `sort_order`.
- Validación: `python3 -m py_compile` sobre servicios de menú tocados, búsqueda transversal `rg` sin ocurrencias restantes del patrón en `pronto-libs/src/pronto_shared/services`, y rerun verde de `test_menu_validation.py` + `test_menu_home_dedupe_policy.py` (`19 passed`).
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-10

