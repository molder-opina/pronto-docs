ID: LIBS-20260310-MENU-MUTATION-CONTRACT-DRIFT
FECHA: 2026-03-10
PROYECTO: pronto-libs, pronto-docs
SEVERIDAD: media
TITULO: `menu_mutation_service.py` no era drop-in compatible con el contrato histórico de CRUD de ítems
DESCRIPCION: Al intentar publicar la fachada pública de menú desde módulos especializados, se confirmó que `menu_mutation_service.py` no era drop-in compatible con el contrato histórico de `create_menu_item`, `update_menu_item` y `delete_menu_item`. Usaba validadores inexistentes (`validate_create_item` / `validate_update_item`), shapes de respuesta distintos, mensajes diferentes y lógica de borrado inválida (`scalars().delete()`). Esto impedía mover esos exports públicos fuera del `impl` sin romper tests y consumidores.
PASOS_REPRODUCIR:
1. Revisar `menu_mutation_service.py` y compararlo con `menu_service_impl.py` para `create_menu_item`, `update_menu_item` y `delete_menu_item`.
2. Ejecutar los tests históricos de CRUD de menú y luego intentar cablear la fachada pública a `menu_mutation_service.py`.
3. Verificar incompatibilidades de contrato y comportamiento.
RESULTADO_ACTUAL: `menu_mutation_service.py` no preserva el contrato histórico del CRUD de ítems.
RESULTADO_ESPERADO: `menu_mutation_service.py` expone funciones compatibles con la fachada pública actual, permitiendo mover el wiring público fuera del `impl` sin romper tests.
UBICACION:
- pronto-libs/src/pronto_shared/services/menu_mutation_service.py
- pronto-libs/src/pronto_shared/services/menu_service_core.py
- pronto-libs/tests/unit/services/
EVIDENCIA:
- Búsqueda transversal mostró uso de validadores inexistentes, deletes inválidos y mensajes/shape distintos en `menu_mutation_service.py`.
- La primera versión de la fachada explícita falló justamente al cablear CRUD desde `menu_mutation_service.py`.
HIPOTESIS_CAUSA: El módulo especializado de mutación se creó como refactor parcial, pero sin completar aún la compatibilidad contractual con la surface histórica de `menu_service`.
ESTADO: RESUELTO
SOLUCION:
- `menu_mutation_service.py` pasó a exponer `create_menu_item`, `update_menu_item` y `delete_menu_item` con contrato histórico compatible, delegando internamente a `menu_service_impl.py` mientras sigue el adelgazamiento del bloque legacy.
- `menu_service_core.py` ya publica esos tres exports públicos desde `menu_mutation_service.py` en lugar de hacerlo directamente desde `menu_service_impl.py`.
- Se amplió `pronto-libs/tests/unit/services/test_menu_query_facade.py` para fijar la delegación de CRUD desde `menu_mutation_service.py`, y `test_menu_service_public_facade.py` ahora valida que la façade pública cablea esos exports al módulo especializado.
- Validación: `py_compile`, `23 passed` en unit tests de `pronto-libs` (`test_menu_service_public_facade.py` + `test_menu_query_facade.py` + `test_menu_utils_helpers.py` + `test_menu_service_impl_helpers.py`) y `19 passed` en `pronto-tests/tests/functionality/unit/test_menu_validation.py` + `test_menu_home_dedupe_policy.py`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-10

