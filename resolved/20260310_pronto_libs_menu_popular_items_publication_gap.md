ID: LIBS-20260310-MENU-POPULAR-ITEMS-PUBLICATION-GAP
FECHA: 2026-03-10
PROYECTO: pronto-libs
SEVERIDAD: media
TITULO: `get_popular_items` seguía viviendo en `menu_service_impl.py` pese a la publicación de la fachada query
DESCRIPCION: Tras publicar la capa query pública desde `menu_query_service.py`, `get_popular_items` seguía manteniendo su implementación real en `menu_service_impl.py`. Eso dejaba incompleta la extracción del bloque query: la fachada pública ya apuntaba al módulo especializado, pero una de sus funciones todavía dependía de la implementación legacy como autoridad real.
PASOS_REPRODUCIR:
1. Revisar `menu_query_service.py` y `menu_service_impl.py`.
2. Observar que `menu_query_service.get_popular_items()` solo delega al `impl`.
3. Verificar que el resto de la publicación pública ya sale desde `menu_query_service.py`.
RESULTADO_ACTUAL: `get_popular_items` aún se implementa en `menu_service_impl.py`.
RESULTADO_ESPERADO: `menu_query_service.py` aloja la implementación real de `get_popular_items` y `menu_service_impl.py` queda como wrapper de compatibilidad.
UBICACION:
- pronto-libs/src/pronto_shared/services/menu_query_service.py
- pronto-libs/src/pronto_shared/services/menu_service_impl.py
- pronto-libs/tests/unit/services/test_menu_query_facade.py
EVIDENCIA:
- `rg` mostró la función definida en ambos módulos, pero con implementación real solo en `menu_service_impl.py`.
HIPOTESIS_CAUSA: La publicación de la fachada query se hizo por etapas y este endpoint quedó pendiente como residual intermedio.
ESTADO: RESUELTO
SOLUCION:
- `menu_query_service.py` pasó a alojar la implementación real de `get_popular_items`, incluyendo caching Redis y consulta agregada por órdenes pagadas.
- `menu_service_impl.py` quedó como wrapper de compatibilidad para `get_popular_items`, delegando en la capa query canónica.
- Se amplió `pronto-libs/tests/unit/services/test_menu_query_facade.py` para fijar que `menu_service_impl.get_popular_items()` delega a `menu_query_service.get_popular_items()`.
- Validación: `py_compile`, `4 passed` en `test_menu_query_facade.py` y `19 passed` en `test_menu_validation.py` + `test_menu_home_dedupe_policy.py`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-10

