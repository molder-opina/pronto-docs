ID: LIBS-20260310-MENU-COMMERCIAL-FACADE-PUBLICATION-GAP
FECHA: 2026-03-10
PROYECTO: pronto-libs, pronto-docs
SEVERIDAD: media
TITULO: La façade pública de menú seguía cableando categorías/home/publication/runtime payload vía `menu_service_impl.py`
DESCRIPCION: Tras mover query, CRUD de ítems y prep time/schedules fuera de la publicación directa del `impl`, aún quedaba un bloque amplio de exports públicos (`get_runtime_menu_payload`, `list_menu_taxonomy`, categorías/subcategorías, labels públicos, home modules y publication`) cableado desde `menu_service_impl.py`. Sin embargo, esas funciones ya delegaban a `menu_commercial_service.py`, que existe precisamente como capa de compatibilidad/reexport. Esto mantenía una dependencia pública innecesaria del `impl`.
PASOS_REPRODUCIR:
1. Revisar `menu_service_core.py`.
2. Verificar que todavía importa varias funciones públicas desde `menu_service_impl.py`.
3. Revisar `menu_service_impl.py` y confirmar que esas funciones ya solo delegan a `menu_commercial_service.py`.
RESULTADO_ACTUAL: La façade pública aún depende del `impl` para exports que ya tienen capa de compatibilidad comercial.
RESULTADO_ESPERADO: `menu_service_core.py` publica ese bloque restante desde `menu_commercial_service.py`, dejando `menu_service_impl.py` fuera del wiring público.
UBICACION:
- pronto-libs/src/pronto_shared/services/menu_service_core.py
- pronto-libs/src/pronto_shared/services/menu_commercial_service.py
EVIDENCIA:
- `menu_service_impl.py` contiene wrappers simples hacia `menu_commercial_service.py` para runtime payload, taxonomy, categorías, labels públicos y home/publication.
HIPOTESIS_CAUSA: El refactor se hizo por etapas y la façade pública quedó con un wiring mixto aunque ya existía una capa de compatibilidad adecuada fuera del `impl`.
ESTADO: RESUELTO
SOLUCION:
- `menu_service_core.py` dejó de cablear runtime payload/taxonomy, categorías/subcategorías, labels públicos, home modules y publication desde `menu_service_impl.py`.
- Ese bloque público ahora se publica desde `menu_commercial_service.py`, que ya funciona como capa de compatibilidad/reexport para esos módulos especializados.
- `test_menu_service_public_facade.py` se actualizó para fijar ese wiring explícito y confirmar que la façade pública de menú ya no depende directamente del `impl`.
- Validación: `py_compile`, `25 passed` en unit tests de `pronto-libs` (`test_menu_service_public_facade.py` + `test_menu_query_facade.py` + `test_menu_utils_helpers.py` + `test_menu_service_impl_helpers.py`) y `19 passed` en `pronto-tests/tests/functionality/unit/test_menu_validation.py` + `test_menu_home_dedupe_policy.py`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-10

