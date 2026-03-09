## Dominio `Auth`

### Superficies principales
- `pronto-api` para auth canónica
- `pronto-client` para auth del cliente en navegador
- `pronto-employees` para login web por scope

### Rutas clave
- Employee API: `/api/auth/login`, `/api/auth/me`, `/api/auth/logout`, `/api/auth/refresh`
- Legacy alias expuesto por `pronto-api`: `/api/employees/auth/login`, `/api/employees/auth/me`, `/api/employees/auth/logout`, `/api/employees/auth/refresh`
- Cliente API/BFF: `/api/client-auth/csrf`, `/api/client-auth/login`, `/api/client-auth/register`, `/api/client-auth/logout`, `/api/client-auth/me` (`GET` y `PUT`)
- Employees web: `/<scope>/login`, `/<scope>/logout`

### Reglas importantes
- Employees usan JWT por scope; no usar sesión Flask para auth de empleados.
- Cliente puede requerir `X-CSRFToken` en mutaciones vía BFF.
- Logins de consola por scope son excepción controlada de CSRF según guardrails.
- Para employees browser real, el punto de entrada natural es `pronto-employees`.

### Flujos típicos
1. Obtener CSRF cliente si aplica.
2. Login o registro.
3. Consultar `/me` para validar contexto autenticado.
4. Continuar con `menu`, `orders` o `sessions`.

### Documentos relacionados
- `../API_DOMAINS_INDEX.md`
- `../SYSTEM_ROUTES_MATRIX.md`
- `../SYSTEM_ROUTES_SPEC.md`
- `../pronto-api/POSTMAN_USAGE.md`
- `../contracts/pronto-api/domain_contracts.md`
- `../contracts/pronto-client/domain_contracts.md`
- `../contracts/pronto-employees/domain_contracts.md`