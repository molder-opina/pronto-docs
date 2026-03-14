# BUG-003 - RBAC solo roles canónicos (sin custom roles)

- Fecha: 2026-03-14
- Repo: `pronto-api`
- Estado: aplicado

## D0 verificación previa
1. Búsqueda ejecutada:
   - `rg -n "CustomRoleRequest|UpdateCustomRoleRequest|create_custom_role|update_custom_role" ...`
   - revisión manual de `pronto-api/src/api_app/routes/employees/employees.py`
2. Evidencia:
   - Se encontró CRUD de roles en endpoint legacy `/api/employees/roles*`.
3. Clasificación D0: `EXISTE`.
4. Decisión D0: `modificar`.

## Implementación
- Archivo modificado: `pronto-api/src/api_app/routes/employees/employees.py`
- Acciones:
  - `POST/PUT/DELETE /roles` deshabilitados (`403`).
  - `GET /roles` y `GET /roles/<id>` conectados a `RBACService` canónico.
  - `PUT /roles/<id>/permissions/bulk` usa `RBACService.bulk_update_role_permissions`.
  - endpoint legacy de revoke de role marcado `410`.

## Validación
- `custom_role_symbols=0` en barrido transversal target.
- `python3 -m py_compile pronto-api/src/api_app/routes/employees/employees.py` ✅
