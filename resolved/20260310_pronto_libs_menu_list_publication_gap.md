ID: LIBS-20260310-MENU-LIST-PUBLICATION-GAP
FECHA: 2026-03-10
PROYECTO: pronto-libs
SEVERIDAD: media
TITULO: `list_menu` seguía implementándose en `menu_service_impl.py`
DESCRIPCION: Tras mover `get_popular_items` y `get_menu_item_detail` a la capa query, `list_menu` todavía mantenía su implementación real en `menu_service_impl.py` aunque en la práctica solo componía `get_runtime_menu_payload()` y normalizaba la respuesta legacy `categories`. Eso dejaba otra pieza simple del bloque query todavía publicada desde el `impl`.
PASOS_REPRODUCIR:
1. Revisar `menu_query_service.py` y `menu_service_impl.py`.
2. Observar que `menu_query_service.list_menu()` aún delega al `impl`.
3. Verificar que `menu_service_impl.list_menu()` no depende de serializers privados complejos.
RESULTADO_ACTUAL: `list_menu` aún se implementa en `menu_service_impl.py`.
RESULTADO_ESPERADO: `menu_query_service.py` aloja la implementación real de `list_menu` y `menu_service_impl.py` queda como wrapper de compatibilidad.
UBICACION:
- pronto-libs/src/pronto_shared/services/menu_query_service.py
- pronto-libs/src/pronto_shared/services/menu_service_impl.py
- pronto-libs/tests/unit/services/test_menu_query_facade.py
EVIDENCIA:
- `rg` mostró `list_menu()` definido en ambos módulos, pero con implementación real solo en `menu_service_impl.py`.
HIPOTESIS_CAUSA: El refactor modular de menú se movió por etapas y la variante legacy de listado quedó pendiente por ser un wrapper sencillo sobre el runtime payload.
ESTADO: RESUELTO
SOLUCION:
- `menu_query_service.py` pasó a alojar la implementación real de `list_menu`, construyendo la respuesta legacy `categories` a partir de `get_runtime_menu_payload()` del módulo de catálogo.
- `menu_service_impl.py` quedó como wrapper de compatibilidad para `list_menu`, delegando en la capa query canónica.
- Se amplió `pronto-libs/tests/unit/services/test_menu_query_facade.py` con cobertura del wrapper y de la reconstrucción de `categories` desde taxonomy/catalog items.
- Validación: `py_compile`, `7 passed` en `test_menu_query_facade.py` y `19 passed` en `test_menu_validation.py` + `test_menu_home_dedupe_policy.py`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-10

