
# Business Rules

- **Kiosk Auto-Login:** Kiosks should auto-login using a predefined secret in production environments.
- **Customer Authentication:** Customer authentication should be managed through a session-based system, not JWTs.
- **Password Security:** Customer passwords must be hashed using a strong, slow algorithm like PBKDF2 or bcrypt with a per-user salt.
- **Rate Limiting:** Authentication endpoints must be rate-limited to prevent brute-force attacks.

# Technical Rules

- **Authentication Decorator:** API endpoints requiring customer authentication must use the `@require_customer_session` decorator.
- **HMAC for Service-to-Service Communication:** Communication between the BFF (`pronto-client`) and the core API (`pronto-api`) must be secured with HMAC signatures.
- **CSRF Protection:** All state-changing web endpoints must be protected against Cross-Site Request Forgery (CSRF).
- **UUIDs for Primary Keys:** All primary keys for major entities should be UUIDs, and API routes must accept UUIDs.
- **Structured Logging:** All logging must be structured (JSON) and include correlation IDs, user information, and other relevant context. It should not contain PII.
- **Configuration Management:** Application configuration should follow a clear precedence order, with environment variables overriding database values, and runtime modifications to `.env` files are forbidden.

# Security Rules

- **No PII in JWTs:** Personally Identifiable Information (PII) such as names and emails must not be stored in JWT claims.
- **Principle of Least Privilege:** API endpoints should be exposed internally within the Docker network by default, and only publicly exposed when absolutely necessary.
- **Redis Security:** Redis instances must be password-protected and not exposed to the public internet.
- **Token Revocation:** Refresh tokens must be rotated after each use, and a revocation list must be maintained to prevent replay attacks.
- **PII Encryption:** All PII stored in the database must use encrypted columns.

# Workflows

- **Customer Authentication Flow:**
    1. The user logs in via the `pronto-client` BFF.
    2. The BFF creates a secure session reference (`customer_ref`) and stores it in Redis along with customer data.
    3. The `customer_ref` is stored in the user's browser session.
    4. For subsequent requests to the BFF, the `customer_ref` is retrieved from the session.
    5. When the BFF communicates with `pronto-api`, it passes the `customer_ref` in a secure header, protected by an HMAC signature.
- **Kiosk Auto-Login Flow:**
    1. A GET request to `/kiosk/<location>` displays the kiosk welcome screen.
    2. A POST request to `/kiosk/<location>/start`, validated with a shared secret, automatically logs in a dedicated kiosk user account.
- **API Request Authorization Flow:**
    1. A request hits an API endpoint.
    2. The `@require_customer_session` decorator intercepts the request.
    3. It extracts the `customer_ref` from the request headers.
    4. It verifies that the session is not expired or revoked by checking against Redis.
    5. If valid, it retrieves the customer ID and proceeds with the request.
    6. If invalid, it returns a 401 Unauthorized error.
