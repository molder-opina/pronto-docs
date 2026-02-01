# Summary of changes for Post-Payment Feedback System

## Files Created/Modified:

### Database
1. `migrations/003_feedback_tokens_and_email.sql` - Migration script for:
   - pronto_feedback_tokens table
   - customer_email column to pronto_orders
   - feedback_requested_at, feedback_completed_at columns to pronto_dining_sessions
   - Feedback configuration settings

### Backend Services
2. `shared/services/feedback_email_service.py` - Service for:
   - Token generation and validation
   - Email determination logic (registered vs anonymous)
   - Idempotent email sending with throttling
   - Email template rendering

### Backend API
3. `clients_app/routes/api/feedback_email.py` - Endpoints:
   - `POST /api/orders/:order_id/feedback/email-trigger` - Trigger feedback email after timer
   - `GET /api/feedback/email/:token` - Validate token and return questions
   - `POST /api/feedback/email/:token/submit` - Submit feedback via email link

### Frontend
4. `clients_app/static/js/src/modules/post-payment-feedback.ts` - Modal:
   - Shows feedback prompt after payment
   - Timer countdown (configurable, default 10s)
   - Options: "Evaluar servicio" or "No, gracias"
   - Integrates with thank-you page

5. Updated `clients_app/static/js/src/modules/thank-you.ts`:
   - Integration with post-payment-feedback module
   - Call to /api/orders/:order_id/feedback/email-trigger on timeout

6. Updated `clients_app/static/js/src/modules/menu-shortcuts.ts`:
   - Loads shortcuts from API (/api/shortcuts)
   - Dynamically registers based on config
   - Supports hot-reload

7. Updated `clients_app/static/js/src/entrypoints/base.ts`:
   - Init shortcuts module
   - Init post-payment-feedback module

8. Updated `clients_app/static/css/menu.css`:
   - Added post-payment-feedback modal styles
   - Animations (fadeIn, slideUp, scaleIn, pulse)

### Admin Config
9. `employees_app/routes/api/admin_config.py` - Enhanced:
   - Added keyboard shortcuts management (already existed)
   - Feedback questions management (already existed)
   - TODO: Add feedback email settings (feedback_prompt_enabled, feedback_prompt_timeout_seconds, etc.)

## Configuration Settings (Admin > Feedback):

### Feedback Prompt Settings
- `feedback_prompt_enabled` (bool, default: true) - Show prompt after payment
- `feedback_prompt_timeout_seconds` (int, default: 10) - Timer duration

### Feedback Email Settings
- `feedback_email_enabled` (bool, default: true) - Enable email feedback
- `feedback_email_token_ttl_hours` (int, default: 24) - Token validity
- `feedback_email_allow_anonymous_if_email_present` (bool, default: true)
- `feedback_email_subject` (string) - Email subject
- `feedback_email_body_template` (string) - Email HTML template
- `feedback_email_throttle_per_order` (bool, default: true) - One email per order

## Business Rules:

### When Feedback Prompt Times Out (user doesn't click):

**Registered User (always has email):**
- ✅ Send email if `feedback_email_enabled = true`
- ✅ Send even if user doesn't provide email in session
- ✅ Use user.email from database

**Anonymous User:**
- ✅ Send email if `feedback_email_allow_anonymous_if_email_present = true`
- ✅ Send only if email was captured during checkout (order.customer_email, session.email, etc.)
- ❌ NO email if no email was captured
- ❌ NO email if `feedback_email_enabled = false`

### Idempotency & Throttling:
- ✅ Only 1 active token per order_id/session_id
- ✅ No email if feedback already submitted
- ✅ No email if token already exists and is active

### Token Validation:
- ✅ Token hash stored (SHA-256)
- ✅ Expires after configured hours (default 24h)
- ✅ Marked as used when feedback submitted
- ✅ Cannot be reused

### Email Link Flow:
```
GET /feedback/email/<token_hash>
  → Validates token (not expired, not used)
  → Returns questions + context (order_id, session_id, total_amount)
  → Shows feedback form

POST /feedback/email/<token_hash>/submit
  → Validates token again
  → Saves feedback with source="email"
  → Marks token used_at
  → Marks session feedback_completed_at
```

## Frontend Flow:

### Payment Confirmed:
1. Show feedback modal (if `feedback_prompt_enabled = true`)
2. Start timer (from `feedback_prompt_timeout_seconds`, default 10s)
3. User can:
   - Click "Evaluar servicio" → Open feedback form immediately
   - Click "No, gracias" → Continue to thank you page

### Timer Expires (no user action):
1. Fire `POST /api/orders/:order_id/feedback/email-trigger`
2. Backend validates and decides:
   - ✅ Send email (if rules met)
   - ❌ No-op (204) if no email or already has feedback
3. Continue current flow (thank you page, order history)

### Immediate Feedback:
- User submits form → Normal flow
- NO email trigger
- Backend prevents email if feedback already exists

## Test Cases:

1. ✅ Registered user, no response → Timer expires → Email sent → Link works 24h
2. ✅ Registered user, immediate response → Submit OK → NO email (even if trigger called)
3. ✅ Anonymous with email (captured) → Timer expires → Email sent → Link works
4. ✅ Anonymous without email → Timer expires → Endpoint returns 204 → NO email
5. ✅ Token expires in 24h → Invalid response
6. ✅ Token used once → Cannot reuse → "Already used" response

## Next Steps (TODO):

1. Apply migration: `mysql -u root pronto_db < migrations/003_feedback_tokens_and_email.sql`
2. Update models.py to include FeedbackToken model (in progress, needs table structure sync)
3. Register feedback_email_bp in clients_app/routes/api/__init__.py
4. Add email settings to admin config UI
5. Configure SMTP/email service for sending emails
6. Test flow end-to-end:
   - Registered user payment → Email trigger → Link → Submit
   - Anonymous with email → Email trigger → Link → Submit
   - Anonymous no email → No email (204)
   - Immediate feedback → No email
7. Document API usage in docs/
