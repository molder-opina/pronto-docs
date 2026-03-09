# Pronto-Employees Documentation

## Overview

Pronto-Employees is the comprehensive employee management and operational dashboard for restaurant staff. It provides role-based interfaces for waiters, chefs, cashiers, and administrators to manage orders, customers, menu items, and business operations.

**Port:** 6081
**Framework:** Flask (Python), TypeScript (Frontend)
**Authentication:** JWT-based authentication with role-based access control (RBAC)

## Architecture

### Core Components

```
pronto-employees/
├── src/
│   └── pronto_employees/
│       ├── app.py              # Flask application factory
│       ├── routes/
│       │   ├── api/            # Proxy scope-aware y utilidades web
│       │   ├── waiter/         # Rutas waiter
│       │   ├── chef/           # Rutas chef
│       │   ├── cashier/        # Rutas cashier
│       │   ├── admin/          # Rutas admin
│       │   └── system/         # Rutas system
│       ├── decorators/         # Authentication decorators
│       └── utils/              # Utility functions
├── tests/                      # Regression/security tests del servicio
├── docs/                       # Documentación local del servicio
├── tools/                      # Tooling operativo local
├── requirements.txt            # Python dependencies
└── Dockerfile                  # Container configuration
```

## Role-Based Interfaces

### Console Selector
- `GET /` - Console selection page for role selection
- `GET /console` - Console selector endpoint

### Waiter Console (`/waiter`)
- `GET /waiter` - Waiter dashboard
- `GET /waiter/dashboard` - Main waiter dashboard
- `GET /waiter/api/<path:subpath>` - Proxy técnico hacia `pronto-api`
- `GET|POST /waiter/login` - Waiter login web
- `GET|POST /waiter/logout` - Waiter logout web

### Chef Console (`/chef`)
- `GET /chef` - Chef dashboard
- `GET /chef/dashboard` - Kitchen orders display
- `GET /chef/api/<path:subpath>` - Proxy técnico hacia `pronto-api`
- `GET|POST /chef/login` - Chef login web
- `GET|POST /chef/logout` - Chef logout web

### Cashier Console (`/cashier`)
- `GET /cashier` - Cashier dashboard
- `GET /cashier/dashboard` - Payment management
- `GET /cashier/api/<path:subpath>` - Proxy técnico hacia `pronto-api`
- `GET|POST /cashier/login` - Cashier login web
- `GET|POST /cashier/logout` - Cashier logout web

### Admin Console (`/admin`)
- `GET /admin` - Admin dashboard
- `GET /admin/dashboard` - Administrative overview
- `GET /admin/api/<path:subpath>` - Proxy técnico hacia `pronto-api`
- `GET|POST /admin/login` - Admin login web
- `GET|POST /admin/logout` - Admin logout web

### System Console (`/system`)
- `GET /system` - System admin dashboard
- `GET /system/login` - System login
- `POST /system/login` - System login
- `GET /system/api/<path:subpath>` - Proxy técnico hacia `pronto-api`
- `GET|POST /system/logout` - System logout web

## API Endpoints

Este servicio **no es la API de negocio canónica**; su superficie `/.../api/*` es un proxy scope-aware hacia `pronto-api`.

### Superficies web por scope
- `/{scope}/login` y `/{scope}/logout` para web auth por consola
- `/{scope}/dashboard` para entrada SSR de cada consola
- `/{scope}/api`, `/{scope}/api/`, `/{scope}/api/<path:subpath>` para proxy técnico transport-only

### Endpoints proxied representativos
- `/{scope}/api/orders`
- `/{scope}/api/sessions`
- `/{scope}/api/employees/roles`
- `/{scope}/api/reports/kpis`
- `/{scope}/api/branding/config`

### Reglas operativas
- El proxy conserva aislamiento por scope (`waiter`, `chef`, `cashier`, `admin`, `system`)
- La lógica de negocio vive en `pronto-api`
- Las mutaciones a `/{scope}/api/*` deben propagar CSRF y correlation ID

### Documentación canónica
- Inventario endpoint por endpoint: `../routes/pronto-employees-endpoints.md`
- Contrato web/proxy: `../contracts/pronto-employees/openapi.yaml`
- Matriz/índice global: `../SYSTEM_ROUTES_MATRIX.md`, `../API_DOMAINS_INDEX.md`

## Scoped API Endpoints

Cada consola usa el mismo patrón:

- `/{scope}/api/*` reenvía hacia `pronto-api`
- el proxy valida que el `jwt_role` coincida con el scope URL
- las cookies de auth son namespaced por consola (`access_token_{scope}`, `refresh_token_{scope}`)
- el proxy propaga `X-Correlation-ID`, `X-CSRFToken`, `Content-Type` y `Content-Length`

## Security Features

### Authentication
- **JWT-based authentication** with role-based access control (RBAC)
- **Cookies namespaced por scope** para aislar `waiter`, `chef`, `cashier`, `admin` y `system`
- **Web auth por consola** vía `/{scope}/login` y `/{scope}/logout`

### Authorization
- **Permission system** with granular permissions
- **Role-based access control** (waiter, chef, cashier, admin, system)
- **Decorator-based permission checks** (`@web_login_required`, `@web_role_required`)
- **Scope validation** for scoped API endpoints

### Security Headers
- **Security headers** configured globally
- **Selective headers** for sensitive routes
- **Referrer-Policy** and cache control for authentication pages
- **CORS** restricted to allowed origins

### CSRF Protection
- **CSRF protection** enabled en la capa web/proxy
- **Mutaciones a `/{scope}/api/*`** deben enviar `X-CSRFToken`
- **Login por scope** es excepción controlada documentada en guardrails
- **El proxy** reenvía `X-CSRFToken` hacia `pronto-api` cuando corresponde

### Audit Middleware
- **Audit logging** for all actions
- **User, action, and type tracking**
- **Standardized logging format** (PIPE format)
- **Security event logging**

## Configuration

### Environment Variables
- `APP_NAME` - Application name
- `PRONTO_STATIC_CONTAINER_HOST` - Static assets host URL
- `TAX_RATE` - Tax rate for orders
- `RESTAURANT_NAME` - Restaurant name
- `RESTAURANT_SLUG` - Restaurant slug for assets
- `STRIPE_API_KEY` - Stripe API key for payments
- `CORS_ALLOWED_ORIGINS` - Allowed CORS origins
- `NUM_PROXIES` - Number of reverse proxies
- `CURRENCY` - Currency code
- `CURRENCY_SYMBOL` - Currency symbol
- `STATIC_ASSETS_ROOT` - Static assets root path

### Debug Mode Settings
- `DEBUG_MODE` - Enable debug mode
- `DEBUG` - Flask debug mode
- `AUTO_READY_QUICK_SERVE` - Auto-ready quick serve items

### App Settings (from database)
- `currency_code` - Currency code (e.g., MXN)
- `currency_symbol` - Currency symbol (e.g., $)
- `currency_locale` - Currency locale (e.g., es-MX)
- `checkout_default_method` - Default checkout method
- `client.checkout.redirect_seconds` - Checkout prompt duration
- `orders.paid_window_minutes` - Paid orders retention window
- `realtime_poll_interval_ms` - Realtime poll interval
- `waiter_notification_timeout` - Waiter notification timeout
- `table_base_prefix` - Table name prefix (e.g., M)
- `system.api.items_per_page` - Items per page for pagination

## Database Integration

### Models Used
- `Employee` - Employee information and credentials
- `Customer` - Customer information
- `DiningSession` - Dining session management
- `Order` - Order data
- `OrderItem` - Order items
- `OrderItemModifier` - Order item modifiers
- `MenuItem` - Menu item data
- `MenuCategory` - Menu categories
- `Table` - Table information
- `TableAssignment` - Table assignments
- `Area` - Area/zone management
- `DayPeriod` - Day period configuration
- `Promotion` - Promotions
- `DiscountCode` - Discount codes
- `Modifier` - Item modifiers
- `Feedback` - Customer feedback
- `BusinessInfo` - Business information
- `Settings` - Application settings
- `Role` - Role definitions
- `Permission` - Permission definitions

## Frontend Architecture

### TypeScript/Vite Setup
- **Build tool:** Vite (en `pronto-static`)
- **Entry points:** viven en `pronto-static/src/vue/employees/entrypoints`

### Template Structure
- `templates/console_selector.html` - Console selection page
- `templates/base.html` - Base template with layout
- `templates/dashboard_waiter.html` - Waiter dashboard (legacy)
- `templates/dashboard_chef.html` - Chef dashboard (legacy)
- `templates/dashboard_cashier.html` - Cashier dashboard (legacy)

- `templates/dashboard_admin.html` - Admin dashboard (legacy)
- `templates/login_waiter.html` - Waiter login
- `templates/login_chef.html` - Chef login
- `templates/login_admin.html` - Admin login
- `templates/cashier/dashboard.html` - Cashier dashboard
- `templates/waiter/dashboard.html` - Main waiter dashboard
- `templates/includes/` - Shared template includes
  - `_dashboard_scripts.html` - Dashboard JavaScript
  - `_admin_sections.html` - Admin sections
  - `_cashier_section.html` - Cashier sections
  - `_waiter_section.html` - Waiter sections
  - `_menu_waiter.html` - Menu section for waiters
  - `_menu_chef.html` - Menu section for chefs
  - `_table_assignment_modal.html` - Table assignment modal
  - `_aditamentos.html` - Modifiers/aditamentos
  - `_payment_modals.html` - Payment modals
  - `_notifications_panel.html` - Notifications panel
- `templates/roles_management.html` - Roles management
- `templates/feedback_dashboard.html` - Feedback dashboard

### Static Assets
- **CSS/JS/Images:** servidos desde `pronto-static`
- **Assets paths:** configurados vía `PRONTO_STATIC_CONTAINER_HOST`

## Permissions System

### Permission Enum
- `LOGIN_SYSTEM` - Login to system
- `MANAGE_EMPLOYEES` - Manage employees
- `MANAGE_MENU` - Manage menu items
- `PROCESS_ORDERS` - Process orders
- `VIEW_ANALYTICS` - View analytics
- `MANAGE_SETTINGS` - Manage system settings
- `PAYMENTS_PROCESS` - Process payments
- `VIEW_REPORTS` - View reports
- `MANAGE_ROLES` - Manage roles and permissions

### Role Definitions
- **waiter** - Table service, order taking, customer interaction
- **chef** - Kitchen operations, order preparation
- **cashier** - Payment processing, billing
- **admin** - Full administrative access
- **system** - System administration and maintenance

## Error Handling

### Error Types
- `AuthenticationError` - Authentication failures
- `AuthorizationError` - Permission denied
- `ValidationError` - Input validation failures
- `NotFoundError` - Resource not found
- `BusinessError` - Business rule violations

### Error Responses
Standard error format:
```json
{
  "error": "Error Type",
  "message": "Detailed error message",
  "details": {}
}
```

## Utility Scripts

Use el tooling vigente del servicio bajo `tools/` y los scripts operativos compartidos documentados en `../contracts/pronto-scripts/files.md`.

## Development

### Local Development
```bash
# Install dependencies
pip install -r requirements.txt

# Start development server
python -m pronto_employees

# Frontend/static build lives in pronto-static
cd ../pronto-static && npm install && npm run build
```

### Docker Development
```bash
# Build container
docker build -t pronto-employees .

# Run container
docker run -p 6081:6081 pronto-employees
```

### Testing
```bash
# Run tests
pytest

# Run tests with coverage
pytest --cov=pronto_employees
```

## Deployment

### Production Deployment
1. **Build Docker image** with production optimizations
2. **Configure environment variables** for production
3. **Deploy to container orchestration** (Docker Compose, Kubernetes)
4. **Configure reverse proxy** (nginx) for SSL/TLS
5. **Monitor logs** and metrics

### Environment Checklist
- [ ] All required environment variables set
- [ ] Database connectivity verified
- [ ] Static assets container accessible
- [ ] Role-based permissions configured
- [ ] CSRF protection enabled
- [ ] Rate limiting enabled
- [ ] Debug mode disabled
- [ ] Audit logging enabled

## Monitoring and Logging

### Logging
- **Standard:** Unified PIPE format (see `LOGGING_STANDARD.md`)
- **Levels:** DEBUG, INFO, WARNING, ERROR
- **Destination:** Container stdout/stderr
- **Audit:** Separate audit log for security events

### Health Checks
- `GET /health` - Application health
- `GET /health/db` - Database connectivity
- `GET /health/cache` - Cache connectivity

### Metrics
- Order metrics
- Session metrics
- Employee performance metrics
- Sales metrics
- Customer metrics

## Dependencies

### Python Dependencies
- Flask - Web framework
- Flask-CORS - CORS support
- SQLAlchemy - ORM
- pronto-shared - Shared library (models, services, auth)

### Node.js Dependencies
- Vite - Build tool
- TypeScript - Type safety
- (Additional frontend libraries)

## Integration Points

### External Services
- **PostgreSQL** - Database
- **Redis** - Caching (via pronto-redis)
- **pronto-static** - Static assets hosting
- **pronto-client** - Customer app integration

### Internal Services
- **pronto-shared** - Shared models and services
- **pronto-api** - Unified API gateway
- **pronto-client** - Customer app integration

## Troubleshooting

### Common Issues

#### Authentication Failures
- Verify JWT configuration
- Check employee credentials
- Validate role permissions
- Review audit logs

#### Permission Denied
- Check role permissions
- Verify JWT scope matches requested scope
- Review permission decorator usage
- Check role assignments

#### Order Processing Errors
- Validate order data
- Check menu item availability
- Verify session status
- Review business rules

#### Real-time Updates Not Working
- Check Supabase configuration
- Verify WebSocket connections
- Check event subscription
- Review network connectivity

#### Static Assets Not Loading
- Verify pronto-static container is running
- Check `PRONTO_STATIC_CONTAINER_HOST` setting
- Verify asset paths in templates
- Check network connectivity to static container

## Best Practices

### Development
- Always validate inputs on both client and server
- Use permission decorators for access control
- Log all administrative actions
- Handle errors gracefully with clear messages
- Test with different roles and permissions

### Security
- Never expose sensitive data in API responses
- Use HTTPS in production
- Implement proper CSRF protection
- Validate and sanitize all inputs
- Use prepared statements for database queries
- Implement proper session management
- Audit all security-related actions

### Performance
- Cache frequently accessed data
- Use database connection pooling
- Optimize database queries with proper indexing
- Use pagination for large datasets
- Implement lazy loading for relationships

## Related Documentation

- [Architecture Overview](../ARCHITECTURE_OVERVIEW.md)
- [System Modules Index](../modules.yml)
- [System Routes Catalog](../SYSTEM_ROUTES_CATALOG.md)
- [Environment Variables](../ENVIRONMENT_VARIABLES.md)
- [Logging Standard](../LOGGING_STANDARD.md)
- [Admin / RBAC Domain](../domains/admin-rbac.md)
- [Pronto-Client](../pronto-clients/)
- [Pronto-API](../pronto-api/)
- [Pronto-Shared](../pronto-libs/)

## Contact

For questions or issues related to pronto-employees, please refer to the main project documentation or contact the development team.
