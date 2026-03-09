## Dominio `Branding / Config`

### Superficie principal
- `pronto-api`

### Rutas clave
- `/api/branding/config`
- `/api/branding/logo`
- `/api/branding/generate/<asset_type>`
- `/api/branding/upload/<asset_type>`
- `/api/config`
- `/api/config/public`
- `/api/public/config`
- `/api/public/settings/<key>`
- `/api/settings/public/<key>`

### Reglas importantes
- Mezcla configuración pública, configuración operativa y branding visual.
- La parte pública puede ser leída por clientes/UI; las mutaciones de branding/config requieren auth employee.
- Es importante distinguir entre config pública de consumo y config administrativa editable.

### Flujos típicos
1. Consultar configuración pública para bootstrap UI.
2. Consultar o editar configuración operativa.
3. Subir/generar assets de branding.
4. Validar propagación en clientes y consolas.

### Documentos relacionados
- `../SYSTEM_ROUTES_CATALOG.md`
- `../SYSTEM_ROUTES_SPEC.md`
- `../SYSTEM_ROUTES_ENDPOINTS.md`
- `../pronto-api/POSTMAN_USAGE.md`
- `../contracts/pronto-api/domain_contracts.md`