# BUG-010 pronto-scripts — migrations idempotency hardening

## D0 verificación previa (EXISTE => modificar)
- Evidencia de existencia:
  - `pronto-scripts/init/sql/migrations/add_accepted_at.sql`
  - `pronto-scripts/init/sql/migrations/add_missing_timestamps.sql`
  - `pronto-scripts/init/sql/migrations/add_partial_delivery_fields.sql`
  - `pronto-scripts/init/sql/migrations/add_payment_meta.sql`
  - `pronto-scripts/init/sql/migrations/add_store_cancel_reason_config.sql`
  - `pronto-scripts/init/sql/migrations/add_waiter_config.sql`
  - `pronto-scripts/init/sql/migrations/apply_all_migrations.sql`
  - `pronto-scripts/init/sql/migrations/create_support_table.sql`
- Decisión: **modificar** migrations existentes.
- Justificación: fallaban en PostgreSQL por no-idempotencia y sintaxis MySQL legacy.

## Cambios aplicados
1. Idempotencia DDL:
- `ADD COLUMN` -> `ADD COLUMN IF NOT EXISTS` en scripts legacy.

2. Canon PostgreSQL:
- `ON DUPLICATE KEY UPDATE` -> `ON CONFLICT (key) DO UPDATE`.
- Tabla/columnas legacy ajustadas a `pronto_system_settings` y estructura PG.

3. Scripts legacy incompatibles:
- `apply_all_migrations.sql` convertido a no-op documentado para PostgreSQL.
- `create_support_table.sql` convertido a DDL PostgreSQL idempotente.
- `add_partial_delivery_fields.sql` movido a tabla canónica `pronto_order_items` + constraints/indexes idempotentes.

## Validación
- `DATABASE_URL=.../pronto_test ./pronto-scripts/bin/pronto-migrate --apply` OK
- `DATABASE_URL=.../pronto ./pronto-scripts/bin/pronto-migrate --apply` OK
- `DATABASE_URL=.../pronto_test ./pronto-scripts/bin/pronto-migrate --check` => `pending=0 drift=0`
- `DATABASE_URL=.../pronto ./pronto-scripts/bin/pronto-migrate --check` => `pending=0 drift=0`
- `DATABASE_URL=... ./pronto-scripts/bin/pronto-init --check` OK en ambas DB
