ID: LIBS-20260310-MENU-INVALIDATE-CACHE-PUBLICATION-GAP
FECHA: 2026-03-10
PROYECTO: pronto-libs
SEVERIDAD: baja
TITULO: `invalidate_menu_cache` seguía implementándose en `menu_service_impl.py`
DESCRIPCION: Después de mover el bloque público de queries de menú, `invalidate_menu_cache` todavía mantenía su implementación real en `menu_service_impl.py`. Aunque es un helper pequeño, seguía dejando incompleta la autoridad del módulo query/cache canónico.
PASOS_REPRODUCIR:
1. Revisar `menu_query_service.py` y `menu_service_impl.py`.
2. Observar que `menu_query_service.invalidate_menu_cache()` aún delega al `impl`.
3. Verificar que la implementación real de borrado de keys Redis sigue en `menu_service_impl.py`.
RESULTADO_ACTUAL: `invalidate_menu_cache` aún se implementa en `menu_service_impl.py`.
RESULTADO_ESPERADO: `menu_query_service.py` aloja la implementación real de invalidación de caché y `menu_service_impl.py` queda como wrapper de compatibilidad.
UBICACION:
- pronto-libs/src/pronto_shared/services/menu_query_service.py
- pronto-libs/src/pronto_shared/services/menu_service_impl.py
- pronto-libs/tests/unit/services/test_menu_query_facade.py
EVIDENCIA:
- `rg` mostró `invalidate_menu_cache()` definido en ambos módulos, pero con implementación real solo en `menu_service_impl.py`.
HIPOTESIS_CAUSA: La publicación de la capa query se hizo priorizando reads y este helper de cache quedó como residual menor.
ESTADO: RESUELTO
SOLUCION:
- `menu_query_service.py` pasó a alojar la implementación real de `invalidate_menu_cache`, incluyendo el borrado de keys Redis bajo `menu:full:*`.
- `menu_service_impl.py` quedó como wrapper de compatibilidad para `invalidate_menu_cache`.
- Se amplió `pronto-libs/tests/unit/services/test_menu_query_facade.py` con cobertura del wrapper y de la invalidación directa de claves cache.
- Validación: `py_compile`, `11 passed` en `test_menu_query_facade.py` y `19 passed` en `test_menu_validation.py` + `test_menu_home_dedupe_policy.py`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-10

