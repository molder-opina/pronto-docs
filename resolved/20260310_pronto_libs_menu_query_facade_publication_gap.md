ID: LIBS-20260310-MENU-QUERY-FACADE-PUBLICATION-GAP
FECHA: 2026-03-10
PROYECTO: pronto-libs, pronto-tests
SEVERIDAD: media
TITULO: La fachada pública de menú seguía exponiendo la capa query desde `menu_service_impl.py`
DESCRIPCION: Al continuar el refactor de menú en `pronto-libs`, se detectó que la fachada pública (`menu_service` → `menu_service_core`) seguía reexportando `get_full_menu`, `list_menu`, `get_menu_item_detail`, `get_popular_items` e `invalidate_menu_cache` directamente desde `menu_service_impl.py`, mientras `menu_query_service.py` coexistía como capa paralela y con lógica parcialmente stale. Esto dejaba una publicación incompleta del refactor y mantenía dos superficies para el mismo bloque query.
PASOS_REPRODUCIR:
1. Revisar `menu_service.py` y `menu_service_core.py`.
2. Verificar que `menu_service_core.py` reexporta `*` desde `menu_service_impl.py`.
3. Comparar con `menu_query_service.py` y los consumidores públicos en `pronto-api`/`pronto-employees`.
RESULTADO_ACTUAL: La fachada pública de menú no publicaba todavía la capa query desde el módulo especializado.
RESULTADO_ESPERADO: La fachada pública mantiene imports estables pero publica las funciones query desde `menu_query_service.py`, con delegación a la implementación canónica actual mientras el refactor sigue avanzando.
UBICACION:
- pronto-libs/src/pronto_shared/services/menu_query_service.py
- pronto-libs/src/pronto_shared/services/menu_service_core.py
- pronto-libs/tests/unit/services/test_menu_query_facade.py
EVIDENCIA:
- Los consumidores externos importaban desde `pronto_shared.services.menu_service`, pero `menu_service_core.py` aún hacía `from .menu_service_impl import *` sin override explícito para la capa query.
HIPOTESIS_CAUSA: El refactor modular de menú avanzó por capas (`commercial`, `catalog`, `home`, etc.) pero la fachada pública no se actualizó al mismo ritmo para el bloque query.
ESTADO: RESUELTO
SOLUCION:
- `menu_query_service.py` dejó de mantener implementaciones paralelas para `invalidate_menu_cache`, `get_full_menu`, `list_menu`, `get_menu_item_detail` y `get_popular_items`; ahora delega a la implementación canónica vigente de forma explícita.
- `menu_service_core.py` sigue manteniendo `from .menu_service_impl import *` por compatibilidad, pero ahora sobreescribe explícitamente la superficie query pública con las funciones de `menu_query_service.py`.
- Se agregó `pronto-libs/tests/unit/services/test_menu_query_facade.py` para fijar que `menu_query_service` delega al `impl` y que `menu_service` expone esas funciones desde la capa query.
- Validación: `py_compile`, `pronto-libs/tests/unit/services/test_menu_query_facade.py` verde (`3 passed`) y rerun verde de `pronto-tests/tests/functionality/unit/test_menu_validation.py` + `test_menu_home_dedupe_policy.py` (`19 passed`).
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-10

