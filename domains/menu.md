## Dominio `Menu`

### Superficies principales
- `pronto-api` como fuente canónica de catálogo
- `pronto-client` para consumo browser del cliente

### Rutas clave
- API canónica: `/api/menu`, `/api/menu-items/<uuid:item_id>`, `/api/menu-items/popular`, `/api/menu-items/recommendations`
- BFF cliente: `/api/menu`, `/api/menu/categories`, `/api/menu/items`
- Operación employee: `/api/menu-categories`, `/api/menu-subcategories`

### Subdominios operativos
- Taxonomía: `/api/menu-categories`, `/api/menu-subcategories`, `/api/menu-labels`
- Publicación home: `/api/menu-home-modules*`
- Modifiers: `/api/modifiers*`

### Reglas importantes
- `GET /api/menu` aparece en más de una capa por compatibilidad.
- `pronto-client` todavía expone `menu/categories` y `menu/items` como BFF/proxy de compatibilidad.
- El cliente SSR/BFF consume vistas de menú orientadas a browser.
- Las mutaciones de catálogo son operativas y requieren auth employee + CSRF.

### Flujos típicos
1. Consultar menú runtime.
2. Resolver categorías/items para UI.
3. Consultar detalle de item cuando sea necesario.
4. Pasar a creación de orden.

### Documentos relacionados
- `../SYSTEM_ROUTES_SPEC.md`
- `../SYSTEM_ROUTES_CATALOG.md`
- `../SYSTEM_ROUTES_ENDPOINTS.md`
- `../pronto-api/API_CONSUMPTION_EXAMPLES.md`
- `../contracts/pronto-api/domain_contracts.md`
- `../contracts/pronto-client/domain_contracts.md`