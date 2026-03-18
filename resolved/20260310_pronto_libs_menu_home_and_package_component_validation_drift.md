ID: LIBS-20260310-MENU-HOME-PACKAGE-VALIDATION-DRIFT
FECHA: 2026-03-10
PROYECTO: pronto-libs, pronto-tests
SEVERIDAD: media
TITULO: El refactor de menú dejó drift entre modelo actual y helpers de módulos home/package components
DESCRIPCION: Al continuar el refactor de menú en `pronto-libs` y correr la validación focalizada de `test_menu_validation.py` y `test_menu_home_dedupe_policy.py`, aparecieron fallos por drift entre el modelo canónico actual y varios helpers de compatibilidad. `menu_service_impl.py` seguía tocando `package_components` para productos normales y disparaba cargas/borrrados innecesarios; `menu_home_module_service.py` seguía usando nombres stale (`source_id`, `menu_item_id`, `product_label_id`) aunque el modelo actual usa `source_ref_id`, `source_item_kind`, `product_id` y `label_id`; y `menu_commercial_service._resolve_module_items(...)` había perdido compatibilidad con callers que pasan un catálogo precalculado para dedupe intra-módulo.
PASOS_REPRODUCIR:
1. Ejecutar `test_menu_validation.py` y `test_menu_home_dedupe_policy.py` con el wrapper estable de pytest.
2. Observar fallos en create/update/delete de menú y en resolución de módulos home por label.
3. Revisar `menu_service_impl.py`, `menu_home_module_service.py` y `menu_commercial_service.py` contra `menu_models.py`.
RESULTADO_ACTUAL: Corregido.
RESULTADO_ESPERADO: Los helpers de menú respetan el modelo actual, no tocan `package_components` cuando no aplica y mantienen compatibilidad con callers legacy aún usados por tests.
UBICACION:
- pronto-libs/src/pronto_shared/services/menu_service_impl.py
- pronto-libs/src/pronto_shared/services/menu_home_module_service.py
- pronto-libs/src/pronto_shared/services/menu_commercial_service.py
- pronto-tests/tests/functionality/unit/test_menu_validation.py
- pronto-tests/tests/functionality/unit/test_menu_home_dedupe_policy.py
EVIDENCIA:
- `test_menu_validation.py` fallaba por accesos a `pronto_menu_package_components` durante create/update/delete de productos normales.
- `test_menu_home_dedupe_policy.py` fallaba porque `_resolve_module_items(...)` ya no aceptaba el catálogo precalculado del caller y porque `menu_home_module_service.py` usaba atributos stale de `ProductLabelMap` y `MenuHomeModuleProduct`.
HIPOTESIS_CAUSA: El refactor modular de menú publicó parcialmente servicios nuevos y dejó wrappers/compatibilidad apuntando a nombres legacy o a relaciones que ahora solo aplican para combos/packages.
ESTADO: RESUELTO
SOLUCION:
- `menu_service_impl.py` ahora evita tocar `package_components` para ítems que no son `combo`/`package`, protege `_sync_menu_package_components()` cuando la tabla no está disponible y elimina ítems con deletes explícitos para no disparar lazy-load innecesario de relaciones de combos en este setup de tests.
- `menu_home_module_service.py` se alineó al modelo actual: usa `source_ref_id`/`source_item_kind`, `MenuHomeModuleProduct.product_id`, `ProductLabelMap.product_id` y `ProductLabelMap.label_id`.
- `menu_commercial_service._resolve_module_items(...)` recuperó compatibilidad con callers legacy que pasan un catálogo precalculado para dedupe intra-módulo.
- Validación: `python3 -m py_compile` de servicios tocados y `pronto-tests/tests/functionality/unit/test_menu_validation.py` + `test_menu_home_dedupe_policy.py` verdes (`19 passed`).
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-10

