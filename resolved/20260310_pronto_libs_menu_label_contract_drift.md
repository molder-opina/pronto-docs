ID: LIBS-20260310-MENU-LABEL-CONTRACT-DRIFT
FECHA: 2026-03-10
PROYECTO: pronto-libs, pronto-docs
SEVERIDAD: media
TITULO: `menu_label_service.py` no era drop-in compatible para `update_menu_item_prep_time` y `get_item_schedules`
DESCRIPCION: Al continuar la reducción de dependencia pública de `menu_service_impl.py`, se confirmó que `menu_label_service.py` no preservaba el contrato histórico de `update_menu_item_prep_time` y `get_item_schedules`. El módulo especializado devolvía shapes distintos, validaciones extra y leía relaciones diferentes (`day_periods` en vez de `schedules`), impidiendo mover esos exports públicos fuera del `impl` sin riesgo de ruptura.
PASOS_REPRODUCIR:
1. Comparar `update_menu_item_prep_time` y `get_item_schedules` entre `menu_service_impl.py` y `menu_label_service.py`.
2. Revisar la ruta API `pronto-api/src/api_app/routes/employees/menu_items.py`.
3. Verificar que el contrato público espera el shape histórico del `impl`.
RESULTADO_ACTUAL: `menu_label_service.py` no es drop-in compatible para esos dos exports públicos.
RESULTADO_ESPERADO: `menu_label_service.py` expone funciones compatibles con el contrato histórico y la façade pública puede cablearlas desde el módulo especializado sin romper comportamiento.
UBICACION:
- pronto-libs/src/pronto_shared/services/menu_label_service.py
- pronto-libs/src/pronto_shared/services/menu_service_core.py
- pronto-libs/tests/unit/services/
EVIDENCIA:
- `menu_label_service.py` devolvía `{"item": ...}` para prep time y construía schedules desde `day_periods`, mientras el `impl` devolvía `{"id", "preparation_time_minutes"}` y leía `item.schedules`.
HIPOTESIS_CAUSA: El módulo de labels mezcló concerns de etiquetas con lecturas/escrituras de disponibilidad y tiempos sin cerrar todavía la compatibilidad contractual con la façade histórica.
ESTADO: RESUELTO
SOLUCION:
- `menu_label_service.py` pasó a exponer `update_menu_item_prep_time` y `get_item_schedules` con contrato histórico compatible, delegando internamente a `menu_service_impl.py` mientras sigue el adelgazamiento del bloque legacy.
- `menu_service_core.py` ya publica esos dos exports públicos desde `menu_label_service.py` en lugar de hacerlo directamente desde `menu_service_impl.py`.
- Se amplió `pronto-libs/tests/unit/services/test_menu_query_facade.py` para fijar la delegación desde `menu_label_service.py`, y `test_menu_service_public_facade.py` ahora valida que la façade pública cablea esos exports al módulo especializado.
- Validación: `py_compile`, `25 passed` en unit tests de `pronto-libs` (`test_menu_service_public_facade.py` + `test_menu_query_facade.py` + `test_menu_utils_helpers.py` + `test_menu_service_impl_helpers.py`) y `19 passed` en `pronto-tests/tests/functionality/unit/test_menu_validation.py` + `test_menu_home_dedupe_policy.py`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-10

