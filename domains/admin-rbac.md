## Dominio `Admin / RBAC`

### Superficies principales
- `pronto-api`
- `pronto-employees` para flujo web real por consola admin/system

### Rutas clave
- `/api/admin/permissions/system`
- `/api/admin/permissions/roles/<role_key>/add`
- `/api/admin/permissions/roles/<role_key>/remove`
- `/api/admin/permissions/roles/<role_key>/reset`
- `/api/employees`
- `/api/employees/roles`
- `/api/employees/roles/<int:role_id>/permissions/bulk`
- `/admin/api/*`
- `/system/api/*`

### Reglas importantes
- Los roles canónicos siguen siendo: `waiter`, `chef`, `cashier`, `admin`, `system`.
- La gestión RBAC debe alinearse con `pronto-libs` y el sistema unificado de permisos.
- Es un dominio sensible: validar scope, actor y permisos antes de automatizar mutaciones.
- El proxy de employees permite reproducir el flujo SSR real sin mover la lógica fuera de `pronto-api`.

### Flujos típicos
1. Login `admin` o `system`.
2. Consultar permisos del sistema.
3. Gestionar empleados y roles.
4. Ajustar bindings o revocaciones según política RBAC.

### Documentos relacionados
- `../API_DOMAINS_INDEX.md`
- `../SYSTEM_ROUTES_CATALOG.md`
- `../SYSTEM_ROUTES_ENDPOINTS.md`
- `../SYSTEM_ROUTES_MATRIX.md`
- `../contracts/pronto-api/domain_contracts.md`
- `../contracts/pronto-employees/domain_contracts.md`