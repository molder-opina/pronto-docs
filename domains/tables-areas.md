## Dominio `Tables / Areas`

### Superficies principales
- `pronto-api`
- `pronto-employees`

### Rutas clave
- `/api/tables`
- `/api/tables/<uuid:table_id>`
- `/api/tables/tables/<uuid:table_id>/qr`
- `/api/areas`
- `/api/table-assignments/assign`
- `/api/table-assignments/unassign/<uuid:table_id>`
- `/api/table-assignments/my-tables`
- `/api/table-assignments/transfer-requests`

### Reglas importantes
- Este dominio cruza operación de piso, asignación de mesas y topología física del restaurante.
- La apertura de sesión de cliente depende indirectamente de `table_id` válido.
- Mutaciones de mesas/áreas y transferencias requieren auth employee y validación de permisos.

### Flujos típicos
1. Consultar catálogo de áreas y mesas.
2. Asignar o desasignar mesas.
3. Revisar conflictos o transferencias.
4. Continuar con órdenes y sesiones ligadas a esa mesa.

### Documentos relacionados
- `../SYSTEM_ROUTES_SPEC.md`
- `../SYSTEM_ROUTES_MATRIX.md`
- `../SYSTEM_ROUTES_ENDPOINTS.md`
- `../SYSTEM_ROUTES_CATALOG.md`
- `../contracts/pronto-api/domain_contracts.md`
- `../contracts/pronto-employees/domain_contracts.md`