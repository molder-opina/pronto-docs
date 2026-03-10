ID: LIBS-20260310-MENU-IMPL-DUPLICATE-DETECTION-TRUNCATED
FECHA: 2026-03-10
PROYECTO: pronto-libs, pronto-docs
SEVERIDAD: alta
TITULO: `_find_duplicate_item` en `menu_service_impl.py` quedó truncada y no ejecuta la búsqueda real
DESCRIPCION: Durante el adelgazamiento de `menu_service_impl.py` se detectó que `_find_duplicate_item(...)` quedó cortada después del guard clause `if not normalized: return None`. La consulta real (`select(MenuItem)...`) quedó accidentalmente debajo de `_package_components_table_exists(...)` y es inalcanzable. Eso rompe la detección de duplicados en los paths de creación/edición del módulo legacy.
PASOS_REPRODUCIR:
1. Revisar `pronto-libs/src/pronto_shared/services/menu_service_impl.py`.
2. Verificar que `_find_duplicate_item(...)` termina tras `if not normalized: return None`.
3. Verificar que la consulta que usa `category_id`, `normalized` y `exclude_item_id` quedó debajo de `return inspect(bind).has_table(...)` dentro de `_package_components_table_exists(...)`.
RESULTADO_ACTUAL: `_find_duplicate_item(...)` devuelve `None` para cualquier nombre no vacío y nunca ejecuta la consulta esperada.
RESULTADO_ESPERADO: `_find_duplicate_item(...)` debe construir y ejecutar la query de búsqueda de duplicados; `_package_components_table_exists(...)` debe contener solo la lógica de existencia de tabla.
UBICACION:
- pronto-libs/src/pronto_shared/services/menu_service_impl.py
EVIDENCIA:
- Búsqueda transversal `rg` mostró dos implementaciones de `_find_duplicate_item(...)`: la de `menu_mutation_service.py` correcta y la de `menu_service_impl.py` truncada.
- El bloque con `query = select(MenuItem)...` quedó textual e inalcanzable dentro de `menu_service_impl.py`.
HIPOTESIS_CAUSA: Residuo de refactor/manual move al adelgazar `menu_service_impl.py`, con bloque de query desplazado por debajo de otra función.
ESTADO: RESUELTO
SOLUCION:
- Se restauró la query real de `_find_duplicate_item(...)` en `menu_service_impl.py`, que había quedado truncada tras el guard clause `if not normalized: return None`.
- `_package_components_table_exists(...)` quedó nuevamente limitado a la verificación de existencia de tabla, sin lógica inalcanzable mezclada.
- Se agregó `pronto-libs/tests/unit/services/test_menu_service_impl_helpers.py` con cobertura útil para `_find_duplicate_item(...)` y `_package_components_table_exists(...)`.
- Validación: `py_compile`, `14 passed` en `pronto-libs/tests/unit/services/test_menu_service_impl_helpers.py` + `test_menu_query_facade.py`, y `19 passed` en `pronto-tests/tests/functionality/unit/test_menu_validation.py` + `test_menu_home_dedupe_policy.py`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-10

