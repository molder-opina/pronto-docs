ID: LIBS-20260310-MENU-FULL-MENU-PUBLICATION-GAP
FECHA: 2026-03-10
PROYECTO: pronto-libs, pronto-tests
SEVERIDAD: media
TITULO: `get_full_menu` seguía implementándose en `menu_service_impl.py`
DESCRIPCION: Tras mover `list_menu`, `get_menu_item_detail` y `get_popular_items` a la capa query, `get_full_menu` seguía manteniendo su implementación real en `menu_service_impl.py`. Ese era el residual principal del bloque query de menú y el último punto fuerte donde la autoridad seguía en el `impl`.
PASOS_REPRODUCIR:
1. Revisar `menu_query_service.py` y `menu_service_impl.py`.
2. Observar que `menu_query_service.get_full_menu()` todavía delega al `impl`.
3. Verificar que `menu_service_impl.py` conserva la lógica de cache, carga de categorías/items y construcción del payload completo.
RESULTADO_ACTUAL: `get_full_menu` aún se implementa en `menu_service_impl.py`.
RESULTADO_ESPERADO: `menu_query_service.py` aloja la implementación real de `get_full_menu` y `menu_service_impl.py` queda como wrapper de compatibilidad.
UBICACION:
- pronto-libs/src/pronto_shared/services/menu_query_service.py
- pronto-libs/src/pronto_shared/services/menu_service_impl.py
- pronto-libs/tests/unit/services/test_menu_query_facade.py
EVIDENCIA:
- `rg` mostró `get_full_menu()` definido en ambos módulos, pero con implementación real solo en `menu_service_impl.py`.
HIPOTESIS_CAUSA: El flujo completo de menú se dejó para el final por depender de cache, cargas ORM y lógica de compatibilidad cliente/empleados.
ESTADO: RESUELTO
SOLUCION:
- `menu_query_service.py` pasó a alojar la implementación real de `get_full_menu`, incluyendo cache Redis, carga ORM de categorías/items y compatibilidad cliente/empleados.
- `menu_service_impl.py` quedó como wrapper de compatibilidad para `get_full_menu`.
- Se amplió `pronto-libs/tests/unit/services/test_menu_query_facade.py` con cobertura del wrapper, del camino de cache hit y de la construcción básica del payload sin cache.
- Validación: `py_compile`, `9 passed` en `test_menu_query_facade.py` y `19 passed` en `test_menu_validation.py` + `test_menu_home_dedupe_policy.py`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-10

