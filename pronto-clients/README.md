# Pronto-Client Documentation

## Overview

Pronto-Client is the customer-facing application that enables diners to browse menus, place orders, and manage their dining experience through QR codes. It provides a streamlined, self-service interface for restaurant customers.

**Port:** 6080
**Framework:** Flask (Python), TypeScript (Frontend)
**Authentication:** Customer session/BFF auth via `client-auth`, CSRF and `X-PRONTO-CUSTOMER-REF`

## Architecture

### Core Components

```
pronto-client/
├── src/
│   └── pronto_clients/
│       ├── app.py              # Flask application factory
│       ├── routes/
│       │   ├── web.py          # HTML/SSR routes
│       │   └── api/            # BFF/proxy endpoints for cliente
│       ├── services/           # Business logic layer
│       └── utils/              # Utility functions
├── tests/                      # Regression/API tests del servicio
├── requirements.txt            # Python dependencies
├── Dockerfile                  # Container configuration
└── README.md                   # Service README
```

Static assets no viven aquí: la fuente única de estáticos es `pronto-static`.

## API Endpoints

Este servicio expone un **BFF/SSR cliente**; la lógica de negocio canónica vive en `pronto-api`.

### Superficies BFF principales
- **Auth cliente:** `/api/client-auth/csrf`, `/api/client-auth/login`, `/api/client-auth/register`, `/api/client-auth/logout`, `/api/client-auth/me`
- **Menu/config:** `/api/menu`, `/api/menu/categories`, `/api/menu/items`, `/api/config/public`
- **Sesiones cliente:** `/api/sessions/open`, `/api/sessions/me`, `/api/sessions/table-context`, `/api/sessions/<uuid:session_id>/timeout`
- **Órdenes cliente:** `/api/customer/orders`, `/api/customer/orders/session/<session_id>/request-check`, `/api/orders/<uuid:order_id>`, `/api/orders/<uuid:order_id>/items`, `/api/orders/send-confirmation`
- **Pagos cliente:** `/api/sessions/<uuid:session_id>/pay`, `/api/sessions/<uuid:session_id>/pay/cash`, `/api/sessions/<uuid:session_id>/pay/clip`, `/api/sessions/<uuid:session_id>/pay/stripe`, `/api/methods`
- **Split bills / waiter calls:** `/api/sessions/<uuid:session_id>/split-bill`, `/api/split-bills/*`, `/api/call-waiter`, `/api/cancel`, `/api/status/<int:call>`
- **Soporte y feedback:** `/api`, `/api/feedback/*`, `/api/shortcuts`

### Web routes principales
- `GET /` - Menu/landing SSR
- `GET /checkout` - Checkout SSR
- `GET /thank-you` - Confirmación SSR

### Documentación canónica
- Inventario endpoint por endpoint: `../routes/pronto-client-endpoints.md`
- Contrato BFF: `../contracts/pronto-client/openapi.yaml`
- Superficies por dominio: `../domains/README.md`

## Services

### OrderService (`services/order_service.py`)
- **Purpose:** Handles order creation, validation, and management
- **Key Functions:**
  - `create_order()` - Create new order with validation
  - `validate_order_items()` - Validate order items and modifiers
  - `calculate_order_total()` - Calculate order totals with taxes
  - `update_order_status()` - Update order status
  - `cancel_order()` - Cancel order with business rules

### MenuService (`services/menu_service.py`)
- **Purpose:** Manages menu data fetching and caching
- **Key Functions:**
  - `fetch_menu()` - Get full menu with categories and items
  - `fetch_categories()` - Get menu categories
  - `fetch_items()` - Get menu items with modifiers
  - `validate_menu_item()` - Validate menu item exists and is available

## Security Features

### Authentication
- **BFF de autenticación cliente** bajo `/api/client-auth/*`
- **CSRF** obligatorio en mutaciones
- **Propagación** de identidad cliente vía `X-PRONTO-CUSTOMER-REF` hacia `pronto-api`
- **CSRF Protection** enabled for all non-API routes
- **Rate Limiting** on order creation (10 requests/60 seconds)

### Input Validation
- **Email sanitization** via `input_sanitizer.py`
- **Maximum items validation** (50 items per order)
- **Order validation** with comprehensive business rules

### Security Headers
- **Security headers** configured globally
- **CORS** restricted to allowed origins
- **Content Security Policy** enforced

## Configuration

### Environment Variables
- `APP_NAME` - Application name
- `PRONTO_STATIC_CONTAINER_HOST` - Static assets host URL
- `TAX_RATE` - Tax rate for orders
- `RESTAURANT_NAME` - Restaurant name
- `RESTAURANT_SLUG` - Restaurant slug for assets
- `STRIPE_API_KEY` - Stripe API key for payments
- `CORS_ALLOWED_ORIGINS` - Allowed CORS origins
- `EMPLOYEE_API_BASE_URL` - Employee API base URL
- `LOAD_SEED_DATA` - Load seed data on startup (true/false)

### Debug Mode Settings
- `DEBUG_MODE` - Enable debug mode
- `DEBUG_AUTO_TABLE` - Auto-create table on debug
- `AUTO_READY_QUICK_SERVE` - Auto-ready quick serve items

### App Settings (from database)
- `currency_code` - Currency code (e.g., MXN)
- `currency_locale` - Currency locale (e.g., es-MX)
- `currency_symbol` - Currency symbol (e.g., $)
- `default_country_code` - Default country code (e.g., +52)
- `phone_country_options` - Available phone country options
- `checkout_default_method` - Default checkout method (cash/card)
- `client.checkout.redirect_seconds` - Checkout prompt duration
- `waiter_call_sound` - Waiter call sound effect
- `waiter_call_cooldown_seconds` - Waiter call cooldown period

## Frontend Architecture

### TypeScript/Vite Setup
- **Build tool:** Vite en `pronto-static`
- **Entry points canónicos:** `pronto-static/src/vue/clients/entrypoints/base.ts`, `menu.ts`, `thank-you.ts`

### Static Assets
- **CSS/JS/Images:** viven exclusivamente en `pronto-static`
- **El SSR cliente consume** assets vía variables de template (`assets_css_clients`, `assets_js_clients`, `assets_images`, `restaurant_assets`, `static_host_url`)
- **La home publicada** consume snapshots estáticos servidos por el static host

### Template Structure
- `templates/index.html` - Main menu page
- `templates/checkout.html` - Checkout page
- `templates/thank-you.html` - Order confirmation page

## Database Integration

### Models Used
- `Customer` - Customer information
- `DiningSession` - Dining session management
- `Order` - Order data
- `OrderItem` - Order items
- `OrderItemModifier` - Order item modifiers
- `MenuItem` - Menu item data
- `MenuCategory` - Menu categories
- `Payment` - Payment information

### Database Connection
- **Connection:** Via `pronto-shared` library
- **ORM:** SQLAlchemy
- **Session management:** Context managers for safe session handling

## Real-time Features

### WebSocket Events
- **emit_new_order()** - Notify kitchen of new order
- **emit_order_status_change()** - Notify customers of status updates
- **emit_waiter_call()** - Notify staff of waiter calls

### Notifications
- **Email notifications** via `notifications_service`
- **Real-time updates** via Supabase Realtime
- **In-app notifications** for order status

## Error Handling

### Error Types
- **OrderValidationError** - Order validation failures
- **ValidationError** - Input validation failures
- **PaymentError** - Payment processing errors
- **AuthenticationError** - Authentication failures

### Error Responses
Standard error format:
```json
{
  "error": "Error Type",
  "message": "Detailed error message",
  "details": {}
}
```

## Development

### Local Development
```bash
# Install dependencies
pip install -r requirements.txt

# Start development server
python -m pronto_clients

# Frontend/static build lives in pronto-static
cd ../pronto-static && npm install && npm run build
```

### Docker Development
```bash
# Build container
docker build -t pronto-client .

# Run container
docker run -p 6080:6080 pronto-client
```

### Testing
```bash
# Run tests
pytest

# Run tests with coverage
pytest --cov=pronto_clients
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
- [ ] Employee API URL configured
- [ ] Stripe API key configured
- [ ] CORS origins configured
- [ ] Debug mode disabled
- [ ] Rate limiting enabled

## Monitoring and Logging

### Logging
- **Standard:** Unified PIPE format (see `LOGGING_STANDARD.md`)
- **Levels:** DEBUG, INFO, WARNING, ERROR
- **Destination:** Container stdout/stderr

### Health Checks
- `GET /health` - Application health
- `GET /health/db` - Database connectivity
- `GET /health/cache` - Cache connectivity

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
- **Stripe** - Payment processing
- **Supabase** - Real-time events
- **PostgreSQL** - Database
- **Redis** - Caching (via pronto-redis)
- **pronto-static** - Static assets hosting
- **pronto-employees** - Employee API integration

### Internal Services
- **pronto-shared** - Shared models and services
- **pronto-employees** - Employee dashboard API
- **pronto-api** - Unified API gateway

## Troubleshooting

### Common Issues

#### Order Creation Fails
- Check item availability
- Validate customer data
- Check session status
- Verify modifiers are valid

#### Payment Processing Errors
- Verify Stripe API key
- Check payment method validity
- Review payment logs
- Validate session is active

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
- Use rate limiting for sensitive endpoints
- Log all order-related actions
- Handle errors gracefully with clear messages
- Test with various order scenarios

### Security
- Never expose sensitive data in API responses
- Use HTTPS in production
- Implement proper CSRF protection
- Validate and sanitize all inputs
- Use prepared statements for database queries
- Implement proper session management

### Performance
- Cache menu data
- Use database connection pooling
- Optimize database queries
- Use lazy loading for large datasets
- Implement proper indexing for frequently queried fields

## Related Documentation

- [Architecture Overview](../ARCHITECTURE_OVERVIEW.md)
- [System Modules Index](../modules.yml)
- [System Routes Catalog](../SYSTEM_ROUTES_CATALOG.md)
- [Environment Variables](../ENVIRONMENT_VARIABLES.md)
- [Logging Standard](../LOGGING_STANDARD.md)
- [Pronto-Employees](../pronto-employees/)
- [Pronto-API](../pronto-api/)
- [Pronto-Shared](../pronto-libs/)

## Contact

For questions or issues related to pronto-client, please refer to the main project documentation or contact the development team.
