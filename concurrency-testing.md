# Manual Concurrency Testing

## Objective
Verify that the get-or-create pattern correctly handles race conditions when multiple requests attempt to create sessions for the same table.

## Test A: Concurrent Order Creation

1. Trigger 10 concurrent requests to `POST /api/orders` for the same table:

```bash
for i in {1..10}; do
  curl -s -X POST http://localhost:6080/api/orders \
    -H "Content-Type: application/json" \
    -d '{"session_id":null,"table_id":1,"items":[{"menu_item_id":1,"quantity":1}],"customer":{"name":"Test","email":"audit@test.com"}}' &
done
wait
```

2. Verify no IntegrityError in logs:

```bash
docker logs pronto-client --tail 100 | grep IntegrityError
```

3. Verify only ONE 'open' session exists for table_id=1:

```bash
docker exec pronto-postgres psql -U pronto -d pronto -c \
  "SELECT COUNT(*) FROM pronto_dining_sessions WHERE table_id=1 AND status='open';"
```

**Expected:** No IntegrityError, only 1 open session per table.

## Test B: Concurrent Session Creation

1. Trigger concurrent requests to `/api/sessions/open`:

```bash
for i in {1..10}; do
  curl -s -X POST http://localhost:6080/api/sessions/open \
    -H "Content-Type: application/json" \
    -d '{"table_id":1}' &
done
wait
```

2. Then create an order for that table:

```bash
curl -s -X POST http://localhost:6080/api/orders \
  -H "Content-Type: application/json" \
  -d '{"items":[{"menu_item_id":1,"quantity":1}],"customer":{"name":"Test","email":"audit@test.com"}}'
```

**Expected:** Order created successfully, reusing the existing session.

## Notes

- The get-or-create pattern uses `expires_at = datetime.utcnow() + timedelta(hours=SESSION_TTL_HOURS)`
- If there's a race condition, `session.rollback()` is called and the existing session is re-queried
- Logs should indicate "Reusing existing session", "Race condition detected", or "Recovered session"
