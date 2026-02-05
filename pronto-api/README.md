# Pronto-API Documentation

## Overview

Pronto-API is the unified REST API gateway and core service for the Pronto platform. It serves as a centralized entry point for API requests and provides unified access to the platform's functionality.

**Port:** 6082
**Framework:** Flask (Python)
**Authentication:** JWT-based authentication
**Purpose:** Unified API gateway and core service

## Architecture

### Core Components

```
pronto-api/
├── src/
│   └── api_app/
│       ├── app.py              # Flask application factory
│       └── wsgi.py             # WSGI entry point
├── config/                     # Configuration files
├── pyproject.toml             # Python project configuration
├── package.json               # Node.js/Frontend dependencies
├── Dockerfile                 # Container configuration
└── requirements.txt           # Python dependencies
```

## API Endpoints

### Health Check
- `GET /health` - Application health check

**Response:**
```json
{
  "status": "ok",
  "service": "pronto-api"
}
```

### Realtime
- `GET /api/realtime/orders` - Long-poll order events
- `GET /api/realtime/notifications` - Long-poll staff notifications

**Query params (ambos endpoints):**
- `after_id` (default `0-0`)
- `limit` (default `50`, max `200`)
- `timeout_ms` (default `5000`, max `30000`)
- `types` (CSV opcional)

**Response (ambos endpoints):**
```json
{
  "events": [],
  "last_id": "1738-0",
  "meta": {
    "endpoint": "orders|notifications",
    "count": 0,
    "timeout_ms": 5000,
    "retry_after_ms": 2000
  }
}
```

### Notifications
- `POST /api/notifications/waiter/call` - Create waiter call
- `GET /api/notifications/waiter/pending` - List pending waiter calls
- `POST /api/notifications/waiter/confirm/<id>` - Confirm waiter call
- `POST /api/notifications/admin/call` - Create admin call

### Menu
- `GET /api/menu` - List menu categories and items
- `GET /api/products` - Alias of `/api/menu`

### Orders
- `POST /api/orders` - Create order
- `GET /api/orders` - List orders (filters by status/recency)
- `POST /api/orders/<id>/cancel` - Cancel order
- `POST /api/orders/<id>/modify` - Create modification request
- `POST /api/modifications/<id>/approve` - Approve modification
- `POST /api/modifications/<id>/reject` - Reject modification
- `GET /api/modifications/<id>` - Get modification details
- `POST /api/orders/<id>/request-check` - Request payment for order

### Promotions
- `GET /api/promotions` - List promotions

## Configuration

### Environment Variables
- `APP_NAME` - Application name (default: "Pronto API")
- `SECRET_KEY` - Flask secret key
- `DEBUG_MODE` - Enable debug mode
- `DEBUG` - Flask debug mode

### CORS Configuration
- **Allowed Origins:**
  - `http://localhost:6080` - Pronto-Clients
  - `http://localhost:6081` - Pronto-Employees
  - `http://127.0.0.1:6080` - Pronto-Clients (localhost)
  - `http://127.0.0.1:6081` - Pronto-Employees (localhost)

### Database Configuration
- **Connection:** Via `pronto-shared` library
- **ORM:** SQLAlchemy
- **Engine:** Initialized on app startup
- **Models:** Shared models from `pronto-shared.models`

## Security Features

### Authentication
- **JWT-based authentication** via `pronto-shared.jwt_middleware`
- **Token validation** on all API endpoints
- **User context** injection via `get_current_user()`

### Security Headers
- **Security headers** configured globally via `configure_security_headers()`
- **CORS** restricted to allowed origins
- **Content Security Policy** enforced

### Error Handling
- **Standardized error responses** via `register_error_handlers()`
- **HTTP status codes** for different error types
- **Error catalog** from `pronto-shared`

## Database Integration

### Models Used
All models are imported from `pronto-shared.models`:
- `Employee` - Employee information
- `Customer` - Customer information
- `DiningSession` - Dining session management
- `Order` - Order data
- `OrderItem` - Order items
- `OrderItemModifier` - Order item modifiers
- `MenuItem` - Menu item data
- `MenuCategory` - Menu categories
- `Table` - Table information
- `Area` - Area/zone management
- `Promotion` - Promotions
- `DiscountCode` - Discount codes
- `Modifier` - Item modifiers
- `Feedback` - Customer feedback
- `BusinessInfo` - Business information
- `Settings` - Application settings
- `Role` - Role definitions
- `Permission` - Permission definitions

### Database Connection
- **Connection pooling** via SQLAlchemy engine
- **Session management** via context managers
- **Initialization:** `init_db()` and `init_engine()`

## Seed Data

### Seed Data Loading
- **Loading Trigger:** `LOAD_SEED_DATA=true` environment variable
- **Mode:** UPSERT (update if exists, insert if new)
- **Service:** `pronto_shared.services.seed.load_seed_data()`

### Seed Data Includes
- Default roles (waiter, chef, cashier, admin, system)
- Default permissions
- Default business settings
- Default menu categories
- Default day periods
- Default areas

## Development

### Local Development
```bash
# Install dependencies
pip install -r requirements.txt
npm install

# Start development server
python -m api_app

# Run with specific configuration
export FLASK_APP=api_app.app
export FLASK_ENV=development
flask run --port=6082
```

### Docker Development
```bash
# Build container
docker build -t pronto-api .

# Run container
docker run -p 6082:6082 pronto-api

# Run with environment variables
docker run -p 6082:6082 \
  -e SECRET_KEY=your-secret-key \
  -e DEBUG_MODE=false \
  pronto-api
```

### Testing
```bash
# Run tests
pytest

# Run tests with coverage
pytest --cov=api_app

# Run specific test
pytest tests/test_app.py
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
- [ ] CORS origins configured for production
- [ ] JWT middleware configured
- [ ] Debug mode disabled
- [ ] Security headers enabled
- [ ] Error handlers registered
- [ ] Seed data loaded (if needed)

## Monitoring and Logging

### Logging
- **Standard:** Unified PIPE format (see `LOGGING_STANDARD.md`)
- **Levels:** DEBUG, INFO, WARNING, ERROR
- **Destination:** Container stdout/stderr
- **Configuration:** Via `configure_logging()`

### Health Checks
- `GET /health` - Application health status
- Response includes service name and status

### Metrics
Currently, metrics collection is handled by individual services. Pronto-API serves as a gateway and may route metrics requests to appropriate services.

## Dependencies

### Python Dependencies
- Flask - Web framework
- Flask-CORS - CORS support
- SQLAlchemy - ORM
- pronto-shared - Shared library (models, services, auth, config, db, logging, error_handlers, jwt_middleware, services)

### Node.js Dependencies
- Vite - Build tool (if frontend components are added)
- TypeScript - Type safety (if frontend components are added)

## Integration Points

### External Services
- **PostgreSQL** - Database (via pronto-shared)
- **Redis** - Caching (via pronto-shared, if needed)
- **Supabase** - Real-time events (via pronto-shared)

### Internal Services
- **pronto-shared** - Shared models, services, and utilities
- **pronto-clients** - Customer-facing application (port 6080)
- **pronto-employees** - Employee dashboard (port 6081)
- **pronto-static** - Static assets hosting

### API Gateway Pattern
Pronto-API serves as a unified entry point for:
1. **Centralized authentication** - JWT validation
2. **CORS management** - Origin control
3. **Error handling** - Standardized error responses
4. **Health monitoring** - Central health checks
5. **Configuration management** - Centralized config access

## Error Handling

### Error Types
Errors are handled via `pronto_shared.error_handlers`:
- **ValidationError** - Input validation failures
- **AuthenticationError** - Authentication failures
- **AuthorizationError** - Permission denied
- **NotFoundError** - Resource not found
- **BusinessError** - Business rule violations
- **DatabaseError** - Database-related errors

### Error Responses
Standard error format:
```json
{
  "error": "Error Type",
  "message": "Detailed error message",
  "details": {}
}
```

### HTTP Status Codes
- `200 OK` - Successful request
- `400 Bad Request` - Invalid input
- `401 Unauthorized` - Authentication required
- `403 Forbidden` - Permission denied
- `404 Not Found` - Resource not found
- `500 Internal Server Error` - Server error

## Security Best Practices

### Development
- Always validate inputs on server side
- Use JWT for authentication
- Implement proper error handling
- Log all security-related events
- Test with different authentication scenarios

### Security
- Never expose sensitive data in API responses
- Use HTTPS in production
- Implement proper CORS configuration
- Validate and sanitize all inputs
- Use prepared statements for database queries
- Implement proper session management
- Monitor for security events

### Performance
- Use connection pooling
- Optimize database queries
- Implement caching where appropriate
- Use pagination for large datasets
- Monitor API response times

## Future Enhancements

### Potential Features
1. **API Versioning** - Support multiple API versions
2. **Rate Limiting** - Per-client rate limiting
3. **API Documentation** - OpenAPI/Swagger documentation
4. **Request Validation** - Advanced request validation
5. **Response Caching** - Cache common responses
6. **Metrics Collection** - Collect and expose metrics
7. **API Gateway Features** - Load balancing, circuit breaking

## Troubleshooting

### Common Issues

#### Health Check Fails
- Check container logs
- Verify environment variables
- Check database connectivity
- Verify pronto-shared is installed

#### Authentication Fails
- Verify JWT configuration
- Check SECRET_KEY environment variable
- Review JWT middleware logs
- Validate token format

#### CORS Errors
- Check CORS_ALLOWED_ORIGINS environment variable
- Verify client application URL
- Review CORS configuration
- Check browser console for details

#### Database Connection Issues
- Verify database credentials
- Check database container is running
- Review database connection logs
- Test database connectivity

## Best Practices

### API Design
- Use RESTful conventions
- Provide clear error messages
- Use appropriate HTTP status codes
- Document API endpoints
- Version API when breaking changes occur

### Development
- Follow Flask best practices
- Use blueprints for modular routes
- Implement proper error handling
- Write comprehensive tests
- Use type hints for better code clarity

### Deployment
- Use environment variables for configuration
- Implement health checks
- Monitor application logs
- Use containers for consistency
- Implement proper security headers

## Related Documentation

- [Architecture Overview](../ARCHITECTURE_OVERVIEW.md)
- [Directory Structure](../estructura-directorios.md)
- [API Routes Documentation](../estructura-routes-api.md)
- [Environment Variables](../ENVIRONMENT_VARIABLES.md)
- [Logging Standard](../LOGGING_STANDARD.md)
- [Pronto-Clients](../pronto-clients/)
- [Pronto-Employees](../pronto-employees/)
- [Pronto-Shared](../pronto-libs/)

## Contact

For questions or issues related to pronto-api, please refer to the main project documentation or contact the development team.
