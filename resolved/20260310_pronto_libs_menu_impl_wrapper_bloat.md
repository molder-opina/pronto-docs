ID: LIBS-20260310-MENU-IMPL-WRAPPER-BLOAT
FECHA: 2026-03-10
PROYECTO: pronto-libs, pronto-docs
SEVERIDAD: media
TITULO: `menu_service_impl.py` seguía reteniendo wrappers triviales y helper muerto tras salir del wiring público
DESCRIPCION: Una vez que `menu_service_core.py` dejó de depender públicamente de `menu_service_impl.py`, el archivo aún conservaba múltiples wrappers triviales hacia `menu_query_service.py` y `menu_commercial_service.py`, además de un helper muerto (`_parse_group_selection_type`) y imports sin uso. Eso mantenía tamaño y ruido innecesarios en el bloque legacy, sin aportar autoridad real.
PASOS_REPRODUCIR:
1. Revisar `menu_service_impl.py`.
2. Verificar que `invalidate_menu_cache`, `get_full_menu`, `list_menu`, `get_popular_items`, `get_menu_item_detail` y gran parte del bloque comercial solo delegan a módulos especializados.
3. Verificar que `_parse_group_selection_type` ya no tiene consumidores dentro del `impl`.
RESULTADO_ACTUAL: `menu_service_impl.py` conserva wrappers/reexports triviales y código muerto tras dejar de ser parte del wiring público.
RESULTADO_ESPERADO: El `impl` mantiene solo compatibilidad interna necesaria y helpers reales; los wrappers triviales pasan a aliases nominales o salen del archivo, y se elimina código muerto/imports sobrantes.
UBICACION:
- pronto-libs/src/pronto_shared/services/menu_service_impl.py
- pronto-libs/tests/unit/services/test_menu_query_facade.py
EVIDENCIA:
- Búsqueda transversal mostró que `menu_query_service.py` y `menu_commercial_service.py` ya son autoridad real para ese bloque, mientras el `impl` conserva wrappers de pocos renglones.
HIPOTESIS_CAUSA: El adelgazamiento del `impl` se hizo por etapas, priorizando primero la façade pública y dejando el cleanup interno para un corte posterior.
ESTADO: RESUELTO
SOLUCION:
- `menu_service_impl.py` dejó de retener wrappers triviales hacia `menu_query_service.py` y `menu_commercial_service.py`; esos símbolos ahora quedan como aliases nominales importados a nivel módulo.
- Se eliminó el helper muerto `_parse_group_selection_type` del `impl` y el import muerto de `json`.
- Tras el adelgazamiento, `menu_service_impl.py` quedó reducido de 922 a 728 líneas y conserva solo 5 funciones públicas reales: `create_menu_item`, `update_menu_item`, `delete_menu_item`, `update_menu_item_prep_time` y `get_item_schedules`.
- `pronto-libs/tests/unit/services/test_menu_query_facade.py` se actualizó para fijar el nuevo rol del `impl`: los símbolos query ya no se testean como wrappers que delegan en runtime, sino como aliases nominales al servicio canónico.
- Validación: `py_compile`, `25 passed` en unit tests de `pronto-libs` (`test_menu_service_public_facade.py` + `test_menu_query_facade.py` + `test_menu_utils_helpers.py` + `test_menu_service_impl_helpers.py`) y `19 passed` en `pronto-tests/tests/functionality/unit/test_menu_validation.py` + `test_menu_home_dedupe_policy.py`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-10

