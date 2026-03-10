ID: LIBS-20260310-MENU-ITEM-DETAIL-PUBLICATION-GAP
FECHA: 2026-03-10
PROYECTO: pronto-libs, pronto-tests
SEVERIDAD: media
TITULO: `get_menu_item_detail` seguía implementándose en `menu_service_impl.py`
DESCRIPCION: Tras publicar la fachada query y mover `get_popular_items`, el endpoint de detalle de ítem de menú seguía manteniendo su implementación real en `menu_service_impl.py`. Además, sus helpers de serialización asociados (`_serialize_item_modifier_groups`, `_serialize_package_components`) también seguían viviendo ahí, por lo que la capa query aún no era autoridad real para ese flujo.
PASOS_REPRODUCIR:
1. Revisar `menu_query_service.py` y `menu_service_impl.py`.
2. Observar que `menu_query_service.get_menu_item_detail()` todavía delega al `impl`.
3. Verificar que el `impl` concentra la serialización de modifier groups y package components usada por ese flujo.
RESULTADO_ACTUAL: La capa query pública aún depende del `impl` como autoridad real para el detalle de ítem.
RESULTADO_ESPERADO: `menu_query_service.py` aloja la implementación real de `get_menu_item_detail` y de sus helpers de serialización asociados; `menu_service_impl.py` queda solo como wrapper de compatibilidad.
UBICACION:
- pronto-libs/src/pronto_shared/services/menu_query_service.py
- pronto-libs/src/pronto_shared/services/menu_service_impl.py
- pronto-libs/tests/unit/services/test_menu_query_facade.py
EVIDENCIA:
- `rg` mostró que `get_menu_item_detail`, `_serialize_item_modifier_groups` y `_serialize_package_components` seguían vivos y consumidos desde `menu_service_impl.py`.
HIPOTESIS_CAUSA: El refactor modular de menú se publicó por etapas y el flujo de detalle quedó pendiente por depender de helpers privados del `impl`.
ESTADO: RESUELTO
SOLUCION:
- `menu_query_service.py` pasó a alojar la implementación real de `get_menu_item_detail`, junto con los helpers `_serialize_item_modifier_groups` y `_serialize_package_components` que sostienen ese flujo.
- `menu_service_impl.py` quedó con wrappers de compatibilidad para ese detalle de ítem y para ambos helpers, de modo que `get_full_menu` siga funcionando mientras el refactor continúa.
- Se amplió `pronto-libs/tests/unit/services/test_menu_query_facade.py` con cobertura útil del flujo real de serialización y de la delegación desde `menu_service_impl.py`.
- Validación: `py_compile`, `5 passed` en `test_menu_query_facade.py` y `19 passed` en `test_menu_validation.py` + `test_menu_home_dedupe_policy.py`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-10

