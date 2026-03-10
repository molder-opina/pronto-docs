ID: LIBS-20260310-MENU-MUTATION-RESIDUAL-IMPL-DEPENDENCY
FECHA: 2026-03-10
PROYECTO: pronto-libs, pronto-docs
SEVERIDAD: media
TITULO: `menu_mutation_service.py` seguía delegando CRUD real de ítems a `menu_service_impl.py`
DESCRIPCION: Aunque la façade pública ya exportaba `create_menu_item`, `update_menu_item` y `delete_menu_item` desde `menu_mutation_service.py`, ese módulo aún delegaba internamente la implementación real al `menu_service_impl.py`. Esto mantenía al `impl` como autoridad efectiva del CRUD, dejaba tests funcionales parcheando el módulo incorrecto y preservaba duplicación/deuda técnica innecesaria.
PASOS_REPRODUCIR:
1. Revisar `pronto-libs/src/pronto_shared/services/menu_mutation_service.py`.
2. Confirmar que `create_menu_item`, `update_menu_item` y `delete_menu_item` importan y llaman a `menu_service_impl.py`.
3. Revisar `pronto-tests/tests/functionality/unit/test_menu_validation.py` y observar que el fixture parchea `menu_service_impl` para que el CRUD funcione.
RESULTADO_ACTUAL: `menu_mutation_service.py` no es todavía autoridad real de CRUD; depende del `impl`.
RESULTADO_ESPERADO: `menu_mutation_service.py` contiene la implementación real compatible del CRUD y `menu_service_impl.py` queda como compatibilidad mínima/apunta a ese módulo.
UBICACION:
- pronto-libs/src/pronto_shared/services/menu_mutation_service.py
- pronto-libs/src/pronto_shared/services/menu_service_impl.py
- pronto-tests/tests/functionality/unit/test_menu_validation.py
EVIDENCIA:
- Búsqueda transversal confirmó que el CRUD público ya sale de `menu_mutation_service.py`, pero ese módulo seguía delegando su trabajo a `menu_service_impl.py`.
HIPOTESIS_CAUSA: El refactor se hizo en dos pasos: primero se movió el wiring público y luego quedó pendiente mover la implementación real.
ESTADO: RESUELTO
SOLUCION:
- `menu_mutation_service.py` dejó de delegar `create_menu_item`, `update_menu_item` y `delete_menu_item` a `menu_service_impl.py`; ahora contiene la implementación real compatible del CRUD, incluyendo validación, sincronización de modifier groups/package components y recommendation periods.
- `menu_service_impl.py` pasó a conservar esas tres funciones como compatibilidad mínima importada desde `menu_mutation_service.py`, reduciendo la autoridad efectiva del `impl`.
- `pronto-tests/tests/functionality/unit/test_menu_validation.py` se actualizó para parchear `menu_mutation_service.py`, que ahora es la autoridad real del CRUD, y `pronto-libs/tests/unit/services/test_menu_query_facade.py` fija que `menu_service_impl.py` expone aliases hacia `menu_mutation_service.py` para esas tres funciones.
- Validación: `py_compile`, `25 passed` en unit tests de `pronto-libs` (`test_menu_query_facade.py` + `test_menu_service_public_facade.py` + `test_menu_utils_helpers.py` + `test_menu_service_impl_helpers.py`) y `19 passed` en `pronto-tests/tests/functionality/unit/test_menu_validation.py` + `test_menu_home_dedupe_policy.py`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-10

