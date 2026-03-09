ID: LIBS-20260309-001
FECHA: 2026-03-09
PROYECTO: pronto-libs
SEVERIDAD: alta
TITULO: delete_role y delete_table permiten eliminar recursos aún en uso
DESCRIPCION:
  `RBACService.delete_role(...)` y `TableService.delete_table(...)` podían eliminar recursos todavía en uso,
  dejando referencias lógicas inválidas o rompiendo flujos operativos.
PASOS_REPRODUCIR:
  1. Invocar `RBACService.delete_role(...)` con un rol custom asignado a empleados.
  2. Invocar `TableService.delete_table(...)` con sesiones activas asociadas.
RESULTADO_ACTUAL:
  Ambos servicios rechazan la eliminación cuando el recurso sigue en uso.
RESULTADO_ESPERADO:
  No permitir borrar roles/mesas con dependencias activas.
UBICACION:
  - pronto-libs/src/pronto_shared/services/rbac_service.py
  - pronto-libs/src/pronto_shared/services/table_service_core.py
EVIDENCIA:
  - `python3 -m py_compile pronto-libs/src/pronto_shared/services/rbac_service.py pronto-libs/src/pronto_shared/services/table_service_core.py pronto-libs/tests/unit/services/test_rbac_service.py pronto-libs/tests/unit/services/test_table_service_core.py` => OK
  - `cd pronto-libs && .venv/bin/python -m pytest tests/unit/services/test_rbac_service.py tests/unit/services/test_table_service_core.py -q` => `7 passed`
HIPOTESIS_CAUSA:
  El refactor hacia RBAC dinámico y validaciones de dining sessions quedó incompleto y dejó deletions sin guardas de uso.
ESTADO: RESUELTO
SOLUCION:
  Se añadió una verificación en `RBACService.delete_role(...)` para bloquear el borrado de roles custom si existen empleados con `Employee.role == role.name`. También se agregó una verificación en `TableService.delete_table(...)` para bloquear soft/hard delete cuando existan dining sessions activas asociadas a la mesa (`open`, `active`, `awaiting_tip`, `awaiting_payment`, `awaiting_payment_confirmation`). Se agregaron tests unitarios focalizados para ambos servicios.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-09