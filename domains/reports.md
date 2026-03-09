## Dominio `Reports`

### Superficies principales
- `pronto-api`
- `pronto-employees` vía proxy para el flujo web real

### Rutas clave
- `/api/reports`
- `/api/reports/kpis`
- `/api/reports/sales`
- `/api/reports/top-products`
- `/api/reports/peak-hours`
- `/api/reports/category-performance`
- `/api/reports/customer-segments`
- `/api/reports/operational-metrics`
- `/api/reports/waiter-performance`
- `/api/reports/waiter-tips`

### Analítica relacionada
- `/api/analytics/*`
- `/api/realtime/orders`
- `/api/realtime/notifications`

### Reglas importantes
- Normalmente se consumen con auth employee/admin.
- El proxy de employees es útil para reproducir el flujo real de consola.
- Este dominio es principalmente lectura; validar actor y scope antes de automatizar consultas.

### Flujos típicos
1. Consultar KPIs.
2. Bajar a ventas/productos/segmentos.
3. Complementar con analytics o realtime según el caso.

### Documentos relacionados
- `../SYSTEM_ROUTES_MATRIX.md`
- `../SYSTEM_ROUTES_SPEC.md`
- `../pronto-api/POSTMAN_USAGE.md`
- `../pronto-api/INSOMNIA_USAGE.md`
- `../contracts/pronto-api/domain_contracts.md`
- `../contracts/pronto-employees/domain_contracts.md`