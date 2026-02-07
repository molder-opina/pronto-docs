# JWT Dual Mode Authentication

## Overview

Implementation of dual-mode JWT authentication for PRONTO client application supporting both anonymous and authenticated users.

## Architecture

### Dual Mode Support

| Mode | TTL | Use Case | JWT Claims |
|------|-----|----------|------------|
| anonymous | 8h | Guest users browsing/ordering | `anon_id`, `session_id`, `table_id` |
| client | 4h | Authenticated customers | `customer_id`, `session_id`, `table_id` |

### JWT Claims (No PII)

```json
{
  "mode": "anonymous" | "client",
  "anon_id": "uuid-string",
  "customer_id": 123,
  "session_id": 456,
  "table_id": 789,
  "exp": 1234567890,
  "iat": 1234567890
}
```

**Security**: No PII (email, name, phone) in JWT tokens.

## Components

### Services (`pronto-libs`)

- `jwt_service.py` - Token creation with dual mode support
- `customer_service.py` - Customer creation and authentication
- `dining_session_service.py` - Session management for clients

### API Endpoints (`pronto-api`)

- `POST /auth/register` - Register new customer, merge anon session
- `POST /auth/login` - Authenticate customer, merge anon session
- `POST /auth/logout` - Clear authentication cookie
- `GET /sessions/me` - Frontend session info (source of truth)
- `POST /sessions/open` - Create dining session
- `POST /sessions/validate` - Validate session
- `POST /sessions/close` - Close session

### Cookie Configuration

```python
ACCESS_COOKIE_OPTS = {
    "httponly": True,
    "secure": True,
    "samesite": "None",
    "path": "/",
    "domain": ".pronto.com",
}
```

## Files Modified

| File | Change |
|------|--------|
| `pronto-libs/src/pronto_shared/jwt_service.py` | Added `create_client_token()` with mode support |
| `pronto-libs/src/pronto_shared/models.py` | Added `anon_id` to Customer and DiningSession |
| `pronto-libs/src/pronto_shared/services/customer_service.py` | Added `create_customer()`, `authenticate_customer()` |
| `pronto-libs/src/pronto_shared/services/dining_session_service.py` | New file with session services |
| `pronto-api/src/api_app/routes/client_auth.py` | Wired to customer service |
| `pronto-api/src/api_app/routes/client_sessions.py` | Wired to dining session service |

## Database Migration

See: `pronto-scripts/init/sql/migrations/20260206_03__jwt_anon_id_columns.sql`

```sql
-- Adds anon_id columns:
-- - pronto_customers.anon_id (VARCHAR(36), UNIQUE)
-- - pronto_dining_sessions.anon_id (VARCHAR(36))
-- With corresponding indexes
```

## User Flow

### Anonymous User
1. Visits site → auto-receives anonymous JWT (8h TTL)
2. Scans QR → opens dining session with `anon_id`
3. Places orders → linked to `anon_id`

### Registration
1. Clicks "Register" → provides name, email, password
2. System creates Customer, generates `customer_id`
3. Anonymous session merged to customer account
4. Returns client JWT (4h TTL)

### Login
1. Enters email/password
2. System validates credentials
3. Returns client JWT
4. Anonymous session merged

## Configuration

Environment variables for CORS:
- `PRONTO_CLIENT_CORS_ORIGINS` - Comma-separated allowed origins
- `PRONTO_API_CORS_ORIGINS` - Comma-separated allowed origins

## Testing

Run integration tests:
```bash
cd pronto-tests
npm test
```

## Related Documentation

- [PLAN.md](PLAN.md) - Implementation plan
- [AGENTS.md](../../AGENTS.md) - Development guidelines
