ID: LIBS-20260310-MENU-HELPER-AUTHORITY-DRIFT
FECHA: 2026-03-10
PROYECTO: pronto-libs, pronto-docs
SEVERIDAD: media
TITULO: La capa query de menú seguía dependiendo de helpers privados del `menu_service_impl`
DESCRIPCION: Tras publicar la superficie pública query/cache en `menu_query_service.py`, la implementación completa de `get_full_menu` aún importaba helpers privados desde `menu_service_impl.py` (`_normalize_item_name`, `_get_products_local_now`, `_is_item_available_by_schedule`, `_get_current_period_key`). Además, `_normalize_item_name` seguía duplicada en `menu_mutation_service.py`. Esto dejaba un acoplamiento interno innecesario y duplicación del mismo comportamiento.
PASOS_REPRODUCIR:
1. Revisar `menu_query_service.py` y localizar imports desde `menu_service_impl.py` dentro de `get_full_menu`.
2. Revisar `menu_service_impl.py` y `menu_mutation_service.py` para `_normalize_item_name`.
3. Verificar que el helper existe duplicado y que la capa query no usa todavía un módulo utilitario común.
RESULTADO_ACTUAL: `menu_query_service.py` depende de helpers privados del `impl` y `_normalize_item_name` está duplicada en al menos dos módulos.
RESULTADO_ESPERADO: Los helpers compartidos viven en `menu_utils.py` y tanto `menu_query_service.py` como `menu_service_impl.py` / `menu_mutation_service.py` los reutilizan desde ahí.
UBICACION:
- pronto-libs/src/pronto_shared/services/menu_query_service.py
- pronto-libs/src/pronto_shared/services/menu_service_impl.py
- pronto-libs/src/pronto_shared/services/menu_mutation_service.py
- pronto-libs/src/pronto_shared/services/menu_utils.py
EVIDENCIA:
- Búsqueda transversal `rg` mostró `menu_query_service.py` usando `_get_products_local_now`, `_get_current_period_key`, `_normalize_item_name` y `_is_item_available_by_schedule`, pero definidos en `menu_service_impl.py`; además `_normalize_item_name` aparece duplicada en `menu_mutation_service.py`.
HIPOTESIS_CAUSA: El refactor modular se centró primero en la superficie pública y dejó los helpers internos compartidos sin reubicar en un módulo utilitario común.
ESTADO: RESUELTO
SOLUCION:
- Los helpers compartidos `_normalize_item_name`, `_get_products_local_now`, `_is_item_available_by_schedule` y `_get_current_period_key` se movieron a `menu_utils.py` como autoridad única.
- `menu_query_service.py` dejó de importar helpers privados desde `menu_service_impl.py`.
- `menu_mutation_service.py` dejó de duplicar `_normalize_item_name` y ahora reutiliza `menu_utils.py`.
- Se agregó `pronto-libs/tests/unit/services/test_menu_utils_helpers.py` con cobertura para normalización, periodos overnight, disponibilidad por schedule y fallback de timezone.
- Validación: `py_compile`, `19 passed` en `pronto-libs/tests/unit/services/test_menu_utils_helpers.py` + `test_menu_service_impl_helpers.py` + `test_menu_query_facade.py`, y `19 passed` en `pronto-tests/tests/functionality/unit/test_menu_validation.py` + `test_menu_home_dedupe_policy.py`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-10

