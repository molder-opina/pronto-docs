| Key Pattern | TTL | Owner | PII | Fields |
|---|---:|---|---|---|
| pronto:client:customer_ref:<uuid> | 3600 | pronto-client | yes | customer_id, email, name, phone, kind, kiosk_location, created_at, last_seen_at |
| pronto:client:revoked:<uuid> | 3600 | pronto-client | no | 1 (marker) |
