
# Authentication & Security Prompts (Chunk 6)

This file contains prompts for implementing and verifying authentication and security rules based on recent findings.

## Customer Authentication

**Prompt:**
"Implement a session-based authentication system for customers in `pronto-client`. When a customer logs in, create a `customer_ref` session identifier, store customer data in Redis keyed by this identifier, and set the `customer_ref` in the user's secure session cookie. Ensure that the old JWT-based authentication for customers is completely removed from `pronto-api`."

**Acceptance Criteria:**
- `pronto-api` no longer has a `client_auth.py` and does not handle customer logins.
- `pronto-client` has a login endpoint that creates a Redis session and returns a session cookie.
- The `@require_customer_session` decorator is used in `pronto-api` to protect customer-only endpoints, validating the `customer_ref` against Redis.
- Logout properly revokes the session in Redis.

## Password Hashing

**Prompt:**
"Refactor the customer password hashing mechanism in `pronto-libs`. Replace the insecure `SHA256` implementation with `werkzeug.security.generate_password_hash` (PBKDF2). Implement a migration strategy where, upon login, you check the old hash, and if it matches, re-hash the password with the new method and update the database."

**Acceptance Criteria:**
- The `hash_credentials` function in `customer_service.py` uses `generate_password_hash`.
- The `verify_credentials` function handles both old and new hash formats to support gradual migration.
- New user registrations use the new hashing method exclusively.

## Service-to-Service Security (HMAC)

**Prompt:**
"Implement HMAC-SHA256 authentication for server-to-server calls between `pronto-client` (BFF) and `pronto-api`. The BFF must sign all outgoing requests to the API with a timestamp, nonce, and a signature derived from a shared secret. The API must validate this signature, timestamp, and nonce to ensure the request is legitimate and not a replay attack."

**Acceptance Criteria:**
- A new module `internal_auth.py` exists in `pronto-libs` with functions to create and verify HMAC headers.
- `pronto-client` uses this module to sign requests to `pronto-api`.
- `pronto-api` uses this module to protect its endpoints, rejecting any request without a valid signature.
- The system is configurable via `PRONTO_INTERNAL_HMAC_KEY` and is backward compatible if the key is not set.

## Security Vulnerabilities

**Prompt:**
"Address the following security vulnerabilities identified in the system:
1.  **PII in JWT:** Remove `employee_name` and `employee_email` from JWT claims for employees. These should be fetched from the database when needed.
2.  **Public API Exposure:** Configure `docker-compose.yml` to not expose `pronto-api` (port 6082) publicly by default. Use Docker profiles to only expose it for development environments.
3.  **Redis Security:** Enforce a password on the Redis instance and ensure it is not publicly accessible.
4.  **Rate Limiting:** Apply rate limiting to all authentication endpoints (`/login`, `/register`, `/refresh`) for both customers and employees.
5.  **PII in Logs:** Audit all logging statements and mask any PII, such as emails or phone numbers, before they are written to logs."

**Acceptance Criteria:**
- JWTs for employees no longer contain PII.
- `docker-compose up` without a profile does not expose port 6082. `docker-compose --profile dev up` does.
- Redis requires a password for connection.
- Authentication endpoints return a `429 Too Many Requests` error after 5 failed attempts in a minute.
- Logs show masked PII (e.g., `us***@example.com`).
