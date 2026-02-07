# JWT Dual Mode - Applied Changes

## Feature Branch
`feat/fase2-jwt-dual-mode`

## Files Modified

### 1. pronto-libs/src/pronto_shared/jwt_service.py

**Changes:**
- Updated `create_client_token()` signature to support dual mode
- Removed PII claims (`customer_name`, `customer_phone`)
- Added `mode` parameter (`"anonymous"` or `"client"`)
- Added `anon_id` parameter for anonymous sessions
- Changed `expires_hours` to `expires_seconds` with auto-TTL
- Added `iat` timestamp
- TTL rules: 8h for anonymous, 4h for client

**Diff:**
```diff
-def create_client_token(
-    customer_id: int | None = None,
-    customer_name: str | None = None,
-    customer_phone: str | None = None,
-    table_id: int | None = None,
-    session_id: int | None = None,
-    expires_hours: int = 4,
-) -> str:
+def create_client_token(
+    mode: str = "client",
+    customer_id: int | None = None,
+    anon_id: str | None = None,
+    session_id: int | None = None,
+    table_id: int | None = None,
+    expires_seconds: int | None = None,
+) -> str:
```

### 2. pronto-api/src/api_app/routes/client_sessions.py

**Changes:**
- Added `/me` endpoint (GET) for frontend source of truth
- Added `@jwt_optional()` decorator to all endpoints
- Added `uuid` import for anon_id generation
- Updated cookie options with `domain=".pronto.com"`
- TTL based on mode: 8h anonymous, 4h client

**New Endpoints:**
- `GET /api/sessions/me` - Returns session info (mode, customer_id, anon_id, session_id, table_id, exp)
- `POST /api/sessions/open` - Creates session with mode detection
- `POST /api/sessions/validate` - Validates session exists
- `POST /api/sessions/close` - Closes session

### 3. pronto-api/src/api_app/routes/client_auth.py

**Changes:**
- Added `@jwt_optional()` for merge anonymous → client
- Updated cookie options with `domain=".pronto.com"`
- Removed PII from responses (only customer id, name, email)
- Logout clears cookie with domain

**Endpoints:**
- `POST /api/auth/register` - Registers new customer, merges anonymous session
- `POST /api/auth/login` - Logs in customer, merges anonymous session
- `POST /api/auth/logout` - Clears cookie

### 4. pronto-api/src/api_app/app.py

**Changes:**
- Updated CORS configuration with origins validation
- Added `allow_headers` and `methods` explicit configuration
- Added production safety check for empty origins
- Changed resource regex from `/api/*` to `/api/.*`

## Smoke Tests

```bash
# 1. Cookie domain + samesite
curl -v -c cookies.txt -X POST "https://api.pronto.com/api/sessions/open" \
  -H "Content-Type: application/json" \
  -d '{"table_id":1}' 2>&1 | rg -i "set-cookie"
# Expected: Domain=.pronto.com; Secure; HttpOnly; SameSite=None

# 2. /me endpoint
curl -s -b cookies.txt "https://api.pronto.com/api/sessions/me" | jq .

# 3. Login migrates anon→client
curl -s -b cookies.txt -c cookies2.txt -X POST "https://api.pronto.com/api/auth/login" \
  -H "Content-Type: application/json" \
  -d '{"email":"test@test.com","password":"test"}' | jq .

curl -s -b cookies2.txt "https://api.pronto.com/api/sessions/me" | jq .
```

## Environment Variables

```bash
# Production
export CORS_ALLOWED_ORIGINS="https://clients.pronto.com"
export SECRET_KEY="<your-secret-key>"

# Development
export CORS_ALLOWED_ORIGINS="http://localhost:6080"
```

## TODO Items Pending Wiring

1. `DiningSessionService.create()` - Create dining sessions in DB
2. `DiningSessionService.get()` - Validate sessions
3. `DiningSessionService.close()` - Close sessions
4. `DiningSessionService.merge_to_customer()` - Migrate anon sessions
5. `CustomerService.create()` - Create customers
6. `CustomerService.authenticate()` - Authenticate customers
7. Database migration for `anon_id` column in `dining_sessions`
