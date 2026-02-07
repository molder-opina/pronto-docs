# JWT Dual Mode Authentication - Plan

## Objective
Implement dual-mode JWT authentication for PRONTO client:
- **Anonymous mode**: 8h TTL, no PII in JWT, uses `anon_id`
- **Client mode**: 4h TTL, links to `customer_id`, merges anonymous session on register/login

## Components

### 1. JWT Service (`pronto-libs/src/pronto_shared/jwt_service.py`)
- `create_client_token()`: Supports both modes
  - `mode`: "anonymous" | "client"
  - `anon_id`: UUID for anonymous users
  - `customer_id`: DB ID for authenticated users
  - `session_id`: Dining session ID
  - `table_id`: Current table (if applicable)
  - `expires_seconds`: Custom TTL (default: 28800/14400 based on mode)

### 2. Customer Model (`pronto-libs/src/pronto_shared/models.py`)
- `Customer.anon_id`: String(36), nullable, unique
- `Customer.password_hash`: String(255), nullable
- `DiningSession.anon_id`: String(36), nullable, indexed

### 3. Customer Service (`pronto-libs/src/pronto_shared/services/customer_service.py`)
- `create_customer()`: Create registered customer with email/password
- `authenticate_customer()`: Validate credentials, return Customer
- `get_customer_by_anon_id()`: Find by anon_id
- `get_customer_by_email()`: Find by email hash

### 4. Dining Session Service (`pronto-libs/src/pronto_shared/services/dining_session_service.py`)
- `create_client_session()`: Create session for anon or client
- `merge_anonymous_session()`: Migrate anon session data to customer

### 5. API Endpoints (`pronto-api/src/api_app/routes/`)
- `client_auth.py`:
  - `POST /auth/register`: Create customer, merge anon session, set client cookie
  - `POST /auth/login`: Authenticate, merge anon session, set client cookie
  - `POST /auth/logout`: Clear cookie
- `client_sessions.py`:
  - `GET /sessions/me`: Frontend source of truth, no PII
  - `POST /sessions/open`: Create dining session, set appropriate cookie
  - `POST /sessions/validate`: Check session validity
  - `POST /sessions/close`: Close session, remove session_id from token

### 6. Cookie Configuration
- **Domain**: `.pronto.com` (cross-subdomain)
- **Options**: `httponly=True, secure=True, samesite=None, path=/`
- **TTL**: 8h anonymous, 4h client

## JWT Claims (No PII)
```json
{
  "mode": "anonymous" | "client",
  "anon_id": "uuid...",
  "customer_id": 123,
  "session_id": 456,
  "table_id": 789,
  "exp": 1234567890,
  "iat": 1234567890
}
```

## Security Rules
1. No PII in JWT (email, name, phone never in token)
2. Password hashing via `pronto_shared.security.hash_credentials()`
3. Email hashed via `hash_identifier()` before lookup
4. Cookies: HTTP-only, Secure, SameSite=None, cross-subdomain

## Migration Required
```sql
-- Add anon_id to Customer (nullable, unique)
ALTER TABLE pronto_customers ADD COLUMN anon_id VARCHAR(36) UNIQUE;

-- Add anon_id to DiningSession (nullable, indexed)
ALTER TABLE pronto_dining_sessions ADD COLUMN anon_id VARCHAR(36);

-- Create indexes
CREATE INDEX ix_customer_anon_id ON pronto_customers(anon_id);
CREATE INDEX ix_dining_session_anon_id ON pronto_dining_sessions(anon_id);
```

## TODO Status
- [x] JWT Service dual-mode support
- [x] Customer model fields (anon_id, password_hash)
- [x] Customer service functions
- [x] Dining session service for client
- [x] API endpoints wired to services
- [ ] Database migration script
- [ ] Integration testing
