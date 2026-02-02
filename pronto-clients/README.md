# Pronto-Clients Documentation

## Overview

Pronto-Clients is the customer-facing application that enables diners to browse menus, place orders, and manage their dining experience through QR codes. It provides a streamlined, self-service interface for restaurant customers.

**Port:** 6080
**Framework:** Flask (Python), TypeScript (Frontend)
**Authentication:** JWT-based authentication

## Architecture

### Core Components

```
pronto-client/
├── src/
│   └── pronto_clients/
│       ├── app.py              # Flask application factory
│       ├── wsgi.py             # WSGI entry point
│       ├── routes/             # HTTP route handlers
│       │   ├── web.py          # HTML template routes
│       │   └── api/            # REST API endpoints
│       ├── services/           # Business logic layer
│       └── utils/              # Utility functions
├── static/                     # Frontend assets
├── templates/                  # Jinja2 HTML templates
├── config/                     # Configuration files
├── pyproject.toml             # Python project configuration
├── package.json               # Node.js/Frontend dependencies
└── Dockerfile                 # Container configuration
```

## API Endpoints

### Authentication (`/api/auth`)
- `POST /api/auth/login` - Customer login with email/phone
- `POST /api/auth/register` - Customer registration
- `POST /api/auth/verify` - Verify phone/email
- `POST /api/auth/logout` - Customer logout

### Orders (`/api/orders`)
- `POST /api/orders` - Create a new order (max 50 items)
- `GET /api/orders/<order_id>` - Get order details
- `GET /api/orders/session/<session_id>` - Get orders for a session
- `PUT /api/orders/<order_id>` - Update order
- `DELETE /api/orders/<order_id>` - Cancel order
- `POST /api/orders/<order_id>/feedback` - Submit feedback

### Menu (`/api/menu`)
- `GET /api/menu` - Fetch menu categories and items
- `GET /api/menu/categories` - Get menu categories
- `GET /api/menu/items` - Get menu items with modifiers

### Sessions (`/api/sessions`)
- `POST /api/sessions` - Create dining session
- `GET /api/sessions/<session_id>` - Get session details
- `PUT /api/sessions/<session_id>` - Update session
- `POST /api/sessions/<session_id>/merge` - Merge sessions
- `POST /api/sessions/<session_id>/split` - Split session into multiple bills

### Payments (`/api/payments`)
- `POST /api/payments` - Initiate payment (cash/credit)
- `GET /api/payments/<payment_id>` - Get payment status
- `POST /api/payments/stripe` - Process Stripe payment
- `POST /api/payments/cash` - Process cash payment

### Stripe Payments (`/api/stripe_payments`)
- `POST /api/stripe_payments/create-intent` - Create Stripe payment intent
- `POST /api/stripe_payments/confirm` - Confirm Stripe payment
- `POST /api/stripe_payments/cancel` - Cancel Stripe payment

### Split Bills (`/api/split_bills`)
- `POST /api/split_bills` - Split bill by items or amount
- `GET /api/split_bills/<session_id>` - Get split bill options
- `POST /api/split_bills/apply` - Apply split to session

### Feedback (`/api/feedback`)
- `POST /api/feedback` - Submit feedback form
- `GET /api/feedback/<feedback_id>` - Get feedback details
- `POST /api/feedback/email` - Submit feedback via email

### Promotions (`/api/promotions`)
- `GET /api/promotions` - Get active promotions
- `GET /api/promotions/<promotion_id>` - Get promotion details
- `POST /api/promotions/<promotion_id>/apply` - Apply promotion to order

### Support (`/api/support`)
- `POST /api/support` - Request support
- `GET /api/support/tickets` - Get support tickets

### Waiter Calls (`/api/waiter_calls`)
- `POST /api/waiter_calls` - Call waiter
- `GET /api/waiter_calls/<session_id>` - Get waiter call status
- `DELETE /api/waiter_calls/<call_id>` - Cancel waiter call

### Notifications (`/api/notifications`)
- `GET /api/notifications` - Get notifications
- `POST /api/notifications/mark-read` - Mark notifications as read

### Shortcuts (`/api/shortcuts`)
- `GET /api/shortcuts` - Get app shortcuts
- `POST /api/shortcuts/track` - Track shortcut usage

### Config (`/api/config`)
- `GET /api/config` - Get app configuration
- `GET /api/config/business` - Get business info

### Business Info (`/api/business_info`)
- `GET /api/business_info` - Get business information
- `GET /api/business_info/hours` - Get business hours

### Health (`/api/health`)
- `GET /api/health` - Health check endpoint

### Debug (`/api/debug`)
- `GET /api/debug/info` - Debug information
- `GET /api/debug/session` - Debug session data
- `POST /api/debug/fix` - Fix common issues

### Web Routes
- `GET /` - Main customer menu page
- `GET /checkout` - Checkout page
- `GET /thank-you` - Order confirmation page

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
- **JWT-based authentication** instead of server-side sessions
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
- `checkout_prompt_duration_seconds` - Checkout prompt duration
- `waiter_call_sound` - Waiter call sound effect
- `waiter_call_cooldown_seconds` - Waiter call cooldown period

## Frontend Architecture

### TypeScript/Vite Setup
- **Build tool:** Vite
- **Entry points:**
  - `static/js/src/entrypoints/base.ts` - Base client functionality
  - `static/js/src/entrypoints/menu.ts` - Menu page logic
  - `static/js/src/entrypoints/thank-you.ts` - Thank you page logic

### Static Assets
- **CSS:** Organized in `static/css/` with shared and client-specific styles
- **JavaScript:** TypeScript compiled via Vite
- **Images:** Served from `pronto-static` container
- **Assets paths:** Configured via `PRONTO_STATIC_CONTAINER_HOST`

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
npm install

# Start development server
python -m pronto_clients

# Build frontend
npm run build
```

### Docker Development
```bash
# Build container
docker build -t pronto-clients .

# Run container
docker run -p 6080:6080 pronto-clients
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
- [Directory Structure](../estructura-directorios.md)
- [API Routes Documentation](../estructura-routes-api.md)
- [Environment Variables](../ENVIRONMENT_VARIABLES.md)
- [Logging Standard](../LOGGING_STANDARD.md)
- [Pronto-Employees](../pronto-employees/)
- [Pronto-API](../pronto-api/)
- [Pronto-Shared](../pronto-libs/)

## Contact

For questions or issues related to pronto-clients, please refer to the main project documentation or contact the development team.
