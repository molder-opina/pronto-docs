ID: LIBS-20260310-MENU-LABEL-RESIDUAL-IMPL-DEPENDENCY
FECHA: 2026-03-10
PROYECTO: pronto-libs, pronto-docs
SEVERIDAD: media
TITULO: `menu_label_service.py` seguía delegando `update_menu_item_prep_time` y `get_item_schedules` a `menu_service_impl.py`
DESCRIPCION: Aunque la façade pública ya exportaba `update_menu_item_prep_time` y `get_item_schedules` desde `menu_label_service.py`, el módulo especializado seguía delegando ambos símbolos a `menu_service_impl.py`. Esto dejaba al `impl` como autoridad real para prep time/schedules y frenaba el adelgazamiento final del bloque legacy.
PASOS_REPRODUCIR:
1. Revisar `pronto-libs/src/pronto_shared/services/menu_label_service.py`.
2. Confirmar que `update_menu_item_prep_time` y `get_item_schedules` importan y llaman a `menu_service_impl.py`.
3. Comparar con las implementaciones reales todavía presentes en `menu_service_impl.py`.
RESULTADO_ACTUAL: `menu_label_service.py` no es todavía autoridad real para prep time/schedules.
RESULTADO_ESPERADO: `menu_label_service.py` contiene la implementación real compatible y `menu_service_impl.py` conserva solo aliases mínimos hacia ese módulo.
UBICACION:
- pronto-libs/src/pronto_shared/services/menu_label_service.py
- pronto-libs/src/pronto_shared/services/menu_service_impl.py
- pronto-libs/tests/unit/services/test_menu_query_facade.py
EVIDENCIA:
- Búsqueda transversal mostró imports directos desde `menu_service_impl.py` dentro de `menu_label_service.py` para ambos símbolos.
HIPOTESIS_CAUSA: El refactor se hizo por etapas: primero wiring público, luego quedó pendiente mover la implementación real fuera del `impl`.
ESTADO: RESUELTO
SOLUCION:
- `menu_label_service.py` dejó de delegar `update_menu_item_prep_time` y `get_item_schedules` a `menu_service_impl.py`; ahora contiene la implementación real compatible para ambos casos.
- `menu_service_impl.py` pasó a conservar esos dos símbolos solo como aliases mínimos importados desde `menu_label_service.py`, completando el traslado de autoridad pública fuera del `impl`.
- `pronto-libs/tests/unit/services/test_menu_query_facade.py` se actualizó para fijar esos aliases de compatibilidad en `menu_service_impl.py`.
- Validación: `py_compile`, `25 passed` en unit tests de `pronto-libs` (`test_menu_query_facade.py` + `test_menu_service_public_facade.py` + `test_menu_utils_helpers.py` + `test_menu_service_impl_helpers.py`) y `19 passed` en `pronto-tests/tests/functionality/unit/test_menu_validation.py` + `test_menu_home_dedupe_policy.py`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-10

