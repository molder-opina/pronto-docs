ID: LIBS-20260310-ORDER-SERVICE-PRIVATE-REEXPORTS-IN-TESTS
FECHA: 2026-03-10
PROYECTO: pronto-libs
SEVERIDAD: media
TITULO: Tests siguen importando helpers privados desde `order_service_impl.py` y sostienen reexports legacy innecesarios
DESCRIPCION: Tras la extracción de `order_helpers.py` y `order_transitions.py`, varios tests seguían importando helpers privados (`_resolve_customer_display_name`, `_order_requires_kitchen`, `_get_employee_preference`, `_set_employee_preference`, `_normalize_status_value`, `_resolve_order_status`, `_transition_order_in_session`) desde `order_service_impl.py`. Eso forzaba mantener reexports legacy privados en `__all__` de `order_service_impl.py` aunque sus módulos canónicos ya existían.
PASOS_REPRODUCIR:
1. Buscar consumidores de `_resolve_customer_display_name`, `_order_requires_kitchen`, `_get_employee_preference`, `_set_employee_preference`, `_normalize_status_value`, `_resolve_order_status`, `_transition_order_in_session` en el monorepo.
2. Revisar `pronto-libs/tests/unit/services/test_order_service.py`.
3. Revisar `pronto-tests/tests/functionality/unit/test_order_state_machine_v2.py`.
4. Revisar `__all__` en `pronto-libs/src/pronto_shared/services/order_service_impl.py`.
RESULTADO_ACTUAL: Corregido.
RESULTADO_ESPERADO: Los tests importan desde `order_helpers.py` y `order_transitions.py`, y `order_service_impl.py` deja de reexportar helpers privados por `__all__`.
UBICACION:
- pronto-libs/src/pronto_shared/services/order_service_impl.py
- pronto-libs/tests/unit/services/test_order_service.py
- pronto-tests/tests/functionality/unit/test_order_state_machine_v2.py
EVIDENCIA:
- `rg` mostró consumidores solo en tests para esos helpers privados fuera de sus módulos canónicos.
- `__all__` de `order_service_impl.py` seguía incluyendo nombres privados (`_...`) después de la extracción.
HIPOTESIS_CAUSA: Refactor parcial donde se extrajeron módulos canónicos, pero los tests quedaron apuntando al facade viejo y obligaron a sostener superficie legacy innecesaria.
ESTADO: RESUELTO
SOLUCION:
- `pronto-libs/tests/unit/services/test_order_service.py` dejó de importar helpers privados desde `order_service_impl.py` y ahora consume `order_helpers.py` y `order_transitions.py` de forma canónica.
- `pronto-tests/tests/functionality/unit/test_order_state_machine_v2.py` dejó de importar `_transition_order_in_session` desde `order_service_impl.py` y ahora lo importa desde `order_transitions.py`.
- `order_service_impl.py` recortó `__all__` para dejar de reexportar helpers privados (`_...`) y sostener solo la superficie pública/canónica restante.
- Validación: `python3 -m py_compile` de archivos tocados y `pronto-libs/tests/unit/services/test_order_service.py` verde (`20 passed`).
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-10

