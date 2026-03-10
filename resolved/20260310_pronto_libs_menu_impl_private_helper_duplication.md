ID: LIBS-20260310-MENU-IMPL-PRIVATE-HELPER-DUPLICATION
FECHA: 2026-03-10
PROYECTO: pronto-libs, pronto-docs
SEVERIDAD: media
TITULO: `menu_service_impl.py` seguía reteniendo helpers privados duplicados de `menu_mutation_service.py`
DESCRIPCION: Tras mover toda la autoridad pública de menú fuera de `menu_service_impl.py`, el archivo aún conservaba helpers privados duplicados (`_find_duplicate_item`, `_package_components_table_exists`, `_resolve_category_and_subcategory`, sync helpers, etc.). La búsqueda transversal mostró que ya no tenían consumidores reales en runtime; solo seguían vivos porque los tests unitarios apuntaban al módulo legacy. Esto mantenía deuda técnica y ruido innecesario en el shim.
PASOS_REPRODUCIR:
1. Revisar `pronto-libs/src/pronto_shared/services/menu_service_impl.py`.
2. Comparar sus helpers privados con `pronto-libs/src/pronto_shared/services/menu_mutation_service.py`.
3. Verificar con búsqueda transversal que los únicos consumidores directos del bloque privado del `impl` son tests unitarios.
RESULTADO_ACTUAL: `menu_service_impl.py` retiene helpers privados duplicados aunque ya no es autoridad pública ni runtime.
RESULTADO_ESPERADO: El `impl` queda como shim legacy puro de compatibilidad; los tests de helpers apuntan al módulo canónico (`menu_mutation_service.py`) y se elimina la duplicación privada del `impl`.
UBICACION:
- pronto-libs/src/pronto_shared/services/menu_service_impl.py
- pronto-libs/src/pronto_shared/services/menu_mutation_service.py
- pronto-libs/tests/unit/services/test_menu_service_impl_helpers.py
EVIDENCIA:
- `rg` mostró que los consumidores directos de los helpers privados del `impl` son solo `test_menu_service_impl_helpers.py`; en runtime la autoridad equivalente ya vive en `menu_mutation_service.py`.
HIPOTESIS_CAUSA: El refactor priorizó mover primero la surface pública y dejó pendiente la limpieza final del bloque privado legacy y de sus tests asociados.
ESTADO: RESUELTO
SOLUCION:
- `menu_service_impl.py` dejó de retener helpers privados duplicados del runtime de mutación; el archivo se redujo a un shim legacy explícito de compatibilidad con aliases públicos hacia `menu_query_service.py`, `menu_mutation_service.py`, `menu_label_service.py` y `menu_commercial_service.py`.
- Se eliminó el bloque privado duplicado del `impl`, por lo que el módulo ya no define funciones públicas propias (`public_defs=[]`) y quedó reducido a 95 líneas.
- Los tests de helpers se movieron al módulo canónico con `pronto-libs/tests/unit/services/test_menu_mutation_service_helpers.py`, y se eliminó `test_menu_service_impl_helpers.py`.
- `pronto-tests/tests/functionality/unit/test_menu_validation.py` dejó de parchear símbolos muertos del `impl`, manteniendo el fixture alineado con la autoridad real actual.
- Validación: `py_compile`, `25 passed` en unit tests de `pronto-libs` (`test_menu_service_public_facade.py` + `test_menu_query_facade.py` + `test_menu_utils_helpers.py` + `test_menu_mutation_service_helpers.py`) y `19 passed` en `pronto-tests/tests/functionality/unit/test_menu_validation.py` + `test_menu_home_dedupe_policy.py`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-10

