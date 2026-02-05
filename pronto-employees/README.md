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
│       ├── routes/             # HTTP route handlers
│       │   ├── dashboard.py    # Dashboard views
│       │   ├── auth.py         # Authentication routes
│       │   ├── roles.py        # Role management
│       │   ├── api_legacy.py   # Legacy API endpoints
│       │   ├── api_scoped.py   # Scoped API endpoints
│       │   ├── api/            # REST API endpoints (25+ modules)
│       │   ├── waiter/         # Waiter-specific routes
│       │   ├── chef/           # Chef-specific routes
│       │   ├── cashier/        # Cashier-specific routes
│       │   ├── admin/          # Admin-specific routes
│       │   └── system/         # System admin routes
│       ├── decorators/         # Authentication decorators
│       └── utils/              # Utility functions
├── templates/                  # Jinja2 HTML templates
├── static/                     # DEPRECATED: assets viven en pronto-static
├── check_db.py                 # Database checker
├── reset_passwords.py         # Password reset utility
├── list_employees.py          # Employee lister
├── verify_hash_check.py        # Hash verification
├── inspect_security.py         # Security inspector
├── pyproject.toml             # Python project configuration
└── Dockerfile                 # Container configuration
```

## Role-Based Interfaces

### Console Selector
- `GET /` - Console selection page for role selection
- `GET /console` - Console selector endpoint

### Waiter Console (`/waiter`)
- `GET /waiter` - Waiter dashboard
- `GET /waiter/dashboard` - Main waiter dashboard
- `GET /waiter/orders` - Active orders management
- `GET /waiter/sessions` - Table session management
- `GET /waiter/menu` - Menu viewing
- `POST /waiter/auth/login` - Waiter login
- `POST /waiter/auth/logout` - Waiter logout

### Chef Console (`/chef`)
- `GET /chef` - Chef dashboard
- `GET /chef/dashboard` - Kitchen orders display
- `GET /chef/orders` - Order queue management
- `GET /chef/orders/<order_id>` - Order details
- `PUT /chef/orders/<order_id>/status` - Update order status
- `POST /chef/auth/login` - Chef login
- `POST /chef/auth/logout` - Chef logout

### Cashier Console (`/cashier`)
- `GET /cashier` - Cashier dashboard
- `GET /cashier/dashboard` - Payment management
- `GET /cashier/orders` - Orders requiring payment
- `POST /cashier/orders/<order_id>/pay` - Process payment
- `POST /cashier/auth/login` - Cashier login
- `POST /cashier/auth/logout` - Cashier logout

### Admin Console (`/admin`)
- `GET /admin` - Admin dashboard
- `GET /admin/dashboard` - Administrative overview
- `GET /admin/employees` - Employee management
- `GET /admin/menu` - Menu management
- `GET /admin/settings` - System settings
- `GET /admin/reports` - Business reports
- `POST /admin/auth/login` - Admin login
- `POST /admin/auth/logout` - Admin logout

### System Console (`/system`)
- `GET /system` - System admin dashboard
- `GET /system/login` - System login
- `POST /system/login` - System login
- `GET /system/health` - System health check
- `POST /system/auth/login` - System admin login

## API Endpoints

### Authentication (`/api/auth`)
- `POST /api/auth/login` - Employee login
- `POST /api/auth/logout` - Employee logout
- `POST /api/auth/reauth` - Re-authenticate session
- `POST /api/auth/verify` - Verify authentication status

### Orders (`/api/orders`)
- `GET /api/orders` - List orders (with filters)
- `GET /api/orders/<order_id>` - Get order details
- `PUT /api/orders/<order_id>` - Update order
- `DELETE /api/orders/<order_id>` - Delete order
- `POST /api/orders/<order_id>/status` - Update order status
- `POST /api/orders/<order_id>/assign` - Assign order to employee
- `GET /api/orders/metrics` - Get order metrics

### Sessions (`/api/sessions`)
- `GET /api/sessions` - List active sessions
- `GET /api/sessions/<session_id>` - Get session details
- `POST /api/sessions` - Create new session
- `PUT /api/sessions/<session_id>` - Update session
- `DELETE /api/sessions/<session_id>` - Close session
- `POST /api/sessions/<session_id>/merge` - Merge sessions
- `POST /api/sessions/<session_id>/split` - Split session
- `GET /api/sessions/<session_id>/orders` - Get session orders

### Menu (`/api/menu`)
- `GET /api/menu` - Get full menu
- `GET /api/menu/categories` - Get menu categories
- `GET /api/menu/items` - Get menu items
- `POST /api/menu/categories` - Create category
- `PUT /api/menu/categories/<id>` - Update category
- `DELETE /api/menu/categories/<id>` - Delete category
- `POST /api/menu/items` - Create menu item
- `PUT /api/menu/items/<id>` - Update menu item
- `DELETE /api/menu/items/<id>` - Delete menu item
- `POST /api/menu/items/<id>/image` - Upload item image

### Employees (`/api/employees`)
- `GET /api/employees` - List employees
- `GET /api/employees/<employee_id>` - Get employee details
- `POST /api/employees` - Create employee
- `PUT /api/employees/<employee_id>` - Update employee
- `DELETE /api/employees/<employee_id>` - Delete employee
- `POST /api/employees/<employee_id>/reset-password` - Reset password
- `GET /api/employees/<employee_id>/permissions` - Get employee permissions

### Tables (`/api/tables`)
- `GET /api/tables` - List all tables
- `GET /api/tables/<table_id>` - Get table details
- `POST /api/tables` - Create table
- `PUT /api/tables/<table_id>` - Update table
- `DELETE /api/tables/<table_id>` - Delete table
- `POST /api/tables/<table_id>/assign` - Assign to employee
- `POST /api/tables/<table_id>/release` - Release from employee

### Customers (`/api/customers`)
- `GET /api/customers` - List customers
- `GET /api/customers/<customer_id>` - Get customer details
- `PUT /api/customers/<customer_id>` - Update customer
- `GET /api/customers/<customer_id>/orders` - Get customer orders

### Roles (`/api/roles`)
- `GET /api/roles` - List all roles
- `GET /api/roles/<role_name>` - Get role details
- `GET /api/roles/<role_name>/permissions` - Get role permissions
- `PUT /api/roles/<role_name>/permissions` - Update role permissions

### Promotions (`/api/promotions`)
- `GET /api/promotions` - List promotions
- `GET /api/promotions/<promotion_id>` - Get promotion details
- `POST /api/promotions` - Create promotion
- `PUT /api/promotions/<promotion_id>` - Update promotion
- `DELETE /api/promotions/<promotion_id>` - Delete promotion
- `POST /api/promotions/<promotion_id>/activate` - Activate promotion
- `POST /api/promotions/<promotion_id>/deactivate` - Deactivate promotion

### Discount Codes (`/api/discount_codes`)
- `GET /api/discount_codes` - List discount codes
- `GET /api/discount_codes/<code>` - Get code details
- `POST /api/discount_codes` - Create discount code
- `PUT /api/discount_codes/<code>` - Update discount code
- `DELETE /api/discount_codes/<code>` - Delete discount code

### Modifiers (`/api/modifiers`)
- `GET /api/modifiers` - List modifiers
- `GET /api/modifiers/<modifier_id>` - Get modifier details
- `POST /api/modifiers` - Create modifier
- `PUT /api/modifiers/<modifier_id>` - Update modifier
- `DELETE /api/modifiers/<modifier_id>` - Delete modifier

### Waiter Calls (`/api/waiter_calls`)
- `GET /api/waiter_calls` - List active waiter calls
- `GET /api/waiter_calls/<call_id>` - Get call details
- `DELETE /api/waiter_calls/<call_id>` - Dismiss call
- `POST /api/waiter_calls/<call_id>/respond` - Respond to call

### Reports (`/api/reports`)
- `GET /api/reports/sales` - Sales report
- `GET /api/reports/orders` - Orders report
- `GET /api/reports/employees` - Employee performance report
- `GET /api/reports/customers` - Customer report
- `GET /api/reports/items` - Item performance report
- `GET /api/reports/tips` - Tips report

### Analytics (`/api/analytics`)
- `GET /api/analytics/dashboard` - Dashboard analytics
- `GET /api/analytics/sales` - Sales analytics
- `GET /api/analytics/traffic` - Traffic analytics
- `GET /api/analytics/performance` - Performance analytics

### Feedback (`/api/feedback`)
- `GET /api/feedback` - List feedback
- `GET /api/feedback/<feedback_id>` - Get feedback details
- `POST /api/feedback/<feedback_id>/respond` - Respond to feedback
- `DELETE /api/feedback/<feedback_id>` - Delete feedback

### Settings (`/api/settings`)
- `GET /api/settings` - Get all settings
- `GET /api/settings/<key>` - Get setting value
- `PUT /api/settings/<key>` - Update setting value
- `POST /api/settings/reset` - Reset settings to defaults

### Business Info (`/api/business_info`)
- `GET /api/business_info` - Get business information
- `PUT /api/business_info` - Update business information
- `GET /api/business_info/hours` - Get business hours
- `PUT /api/business_info/hours` - Update business hours

### Branding (`/api/branding`)
- `GET /api/branding` - Get branding settings
- `PUT /api/branding` - Update branding settings
- `POST /api/branding/logo` - Upload logo
- `POST /api/branding/colors` - Update color scheme

### Images (`/api/images`)
- `POST /api/images/upload` - Upload image
- `GET /api/images/<image_id>` - Get image
- `DELETE /api/images/<image_id>` - Delete image
- `POST /api/images/<image_id>/optimize` - Optimize image

### Admin Config (`/api/admin_config`)
- `GET /api/admin_config` - Get admin configuration
- `PUT /api/admin_config` - Update admin configuration
- `POST /api/admin_config/backup` - Backup configuration
- `POST /api/admin_config/restore` - Restore configuration

### Realtime (`/api/realtime`)
- `GET /api/realtime/orders` - Long-poll order events
- `GET /api/realtime/notifications` - Long-poll staff notifications

### Areas (`/api/areas`)
- `GET /api/areas` - List areas
- `GET /api/areas/<area_id>` - Get area details
- `POST /api/areas` - Create area
- `PUT /api/areas/<area_id>` - Update area
- `DELETE /api/areas/<area_id>` - Delete area

### Day Periods (`/api/day_periods`)
- `GET /api/day_periods` - List day periods
- `GET /api/day_periods/<period_id>` - Get period details
- `POST /api/day_periods` - Create day period
- `PUT /api/day_periods/<period_id>` - Update day period
- `DELETE /api/day_periods/<period_id>` - Delete day period

### Table Assignments (`/api/table_assignments`)
- `GET /api/table_assignments` - List table assignments
- `POST /api/table_assignments` - Create assignment
- `PUT /api/table_assignments/<id>` - Update assignment
- `DELETE /api/table_assignments/<id>` - Delete assignment

### Notifications (`/api/notifications`)
- `POST /api/notifications/waiter/call` - Create waiter call
- `GET /api/notifications/waiter/pending` - List pending waiter calls
- `POST /api/notifications/waiter/confirm/<id>` - Confirm waiter call
- `POST /api/notifications/admin/call` - Create admin call

### Config (`/api/config`)
- `GET /api/config` - Get application config
- `GET /api/config/features` - Get feature flags
- `PUT /api/config/features` - Update feature flags

### Debug (`/api/debug`)
- `GET /api/debug/info` - Debug information
- `GET /api/debug/session` - Debug session data
- `GET /api/debug/permissions` - Debug permissions
- `GET /api/debug/database` - Debug database queries
- `POST /api/debug/fix` - Fix common issues

## Scoped API Endpoints

Each role has scoped API endpoints that are validated against the JWT scope:

### Waiter Scoped API (`/waiter/api`)
- Inherits all `/api/*` endpoints
- Only accessible with `waiter` scope in JWT
- Waiter-specific permission checks applied

### Chef Scoped API (`/chef/api`)
- Inherits all `/api/*` endpoints
- Only accessible with `chef` scope in JWT
- Chef-specific permission checks applied

### Cashier Scoped API (`/cashier/api`)
- Inherits all `/api/*` endpoints
- Only accessible with `cashier` scope in JWT
- Cashier-specific permission checks applied

### Admin Scoped API (`/admin/api`)
- Inherits all `/api/*` endpoints
- Only accessible with `admin` scope in JWT
- Admin-specific permission checks applied

### System Scoped API (`/system/api`)
- Inherits all `/api/*` endpoints
- Only accessible with `system` scope in JWT
- System admin-specific permission checks applied

## Security Features

### Authentication
- **JWT-based authentication** with role-based access control (RBAC)
- **Multi-scope sessions** for different employee roles
- **Session management** with automatic token refresh
- **Logout and re-authentication** support

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
- **CSRF protection** enabled for all non-API routes
- **API routes exempt** from CSRF (JWT used instead)
- **CSRF token validity** set to 1 hour

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
- `checkout_prompt_duration_seconds` - Checkout prompt duration
- `paid_orders_window_minutes` - Paid orders retention window
- `realtime_poll_interval_ms` - Realtime poll interval
- `waiter_notification_timeout` - Waiter notification timeout
- `table_base_prefix` - Table name prefix (e.g., M)
- `items_per_page` - Items per page for pagination

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

### check_db.py
- **Purpose:** Check database connectivity and schema
- **Usage:** `python check_db.py`

### reset_passwords.py
- **Purpose:** Reset employee passwords
- **Usage:** `python reset_passwords.py --email <email> --password <password>`

### list_employees.py
- **Purpose:** List all employees in the system
- **Usage:** `python list_employees.py`

### verify_hash_check.py
- **Purpose:** Verify password hash checks
- **Usage:** `python verify_hash_check.py`

### inspect_security.py
- **Purpose:** Inspect security configuration
- **Usage:** `python inspect_security.py`

## Development

### Local Development
```bash
# Install dependencies
pip install -r requirements.txt
npm install

# Start development server
python -m pronto_employees

# Build frontend
npm run build
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
- **pronto-clients** - Customer app integration

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
- [Directory Structure](../estructura-directorios.md)
- [API Routes Documentation](../estructura-routes-api.md)
- [Environment Variables](../ENVIRONMENT_VARIABLES.md)
- [Logging Standard](../LOGGING_STANDARD.md)
- [Permissions System](../PERMISSIONS_SYSTEM.md)
- [Pronto-Clients](../pronto-clients/)
- [Pronto-API](../pronto-api/)
- [Pronto-Shared](../pronto-libs/)

## Contact

For questions or issues related to pronto-employees, please refer to the main project documentation or contact the development team.
