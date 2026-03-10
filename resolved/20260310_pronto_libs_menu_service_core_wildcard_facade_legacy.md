ID: LIBS-20260310-MENU-SERVICE-CORE-WILDCARD-FACADE-LEGACY
FECHA: 2026-03-10
PROYECTO: pronto-libs, pronto-docs
SEVERIDAD: media
TITULO: `menu_service_core.py` seguía publicando la fachada de menú con `from .menu_service_impl import *`
DESCRIPCION: Tras modularizar query, mutation, taxonomy, labels y publicación de menú, la fachada pública `menu_service_core.py` seguía dependiendo de `from .menu_service_impl import *` y solo sobreescribía parcialmente algunas funciones query. Eso dejaba la publicación pública atada a un archivo legacy sobredimensionado y hacía opaco qué módulo es la autoridad real de cada función.
PASOS_REPRODUCIR:
1. Revisar `pronto-libs/src/pronto_shared/services/menu_service_core.py`.
2. Verificar que usa `from .menu_service_impl import *`.
3. Verificar que ya existen módulos especializados (`menu_query_service.py`, `menu_mutation_service.py`, `menu_catalog_service.py`, `menu_category_service.py`, `menu_label_service.py`, `menu_home_module_service.py`, `menu_publication_service.py`).
RESULTADO_ACTUAL: La fachada pública de menú aún se arma con wildcard import desde `menu_service_impl.py`.
RESULTADO_ESPERADO: `menu_service_core.py` exporta explícitamente la surface pública desde los módulos especializados, dejando `menu_service_impl.py` como compatibilidad interna y no como autoridad de publicación.
UBICACION:
- pronto-libs/src/pronto_shared/services/menu_service_core.py
- pronto-libs/tests/unit/services/
EVIDENCIA:
- Los consumidores públicos importan desde `pronto_shared.services.menu_service`, no desde `menu_service_impl.py`.
- Búsqueda transversal mostró que la mayoría de las funciones públicas ya tienen hogar especializado fuera del `impl`.
HIPOTESIS_CAUSA: La modularización avanzó por capas pero la fachada pública quedó con el patrón wildcard como etapa transitoria.
ESTADO: RESUELTO
SOLUCION:
- `menu_service_core.py` dejó de usar `from .menu_service_impl import *` y ahora publica una fachada explícita con imports nominales.
- La validación mostró que solo la capa query (`invalidate_menu_cache`, `get_full_menu`, `list_menu`, `get_menu_item_detail`, `get_popular_items`) es hoy drop-in compatible desde módulos especializados; por eso la façade pública mantiene el resto de funciones desde `menu_service_impl.py` para preservar contrato estable.
- Se agregó `pronto-libs/tests/unit/services/test_menu_service_public_facade.py` para fijar el wiring explícito de la façade pública.
- Validación: `py_compile`, `20 passed` en unit tests de `pronto-libs` (`test_menu_service_public_facade.py` + `test_menu_query_facade.py` + `test_menu_utils_helpers.py` + `test_menu_service_impl_helpers.py`) y `19 passed` en `pronto-tests/tests/functionality/unit/test_menu_validation.py` + `test_menu_home_dedupe_policy.py`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-10

