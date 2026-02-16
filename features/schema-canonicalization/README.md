# Schema Canonicalization

Objetivo: completar el esquema canónico para que `pronto-init --check` y `pronto-migrate --check` pasen sin bypass en runtime.

Alcance:
- `pronto-scripts/init/sql/00_bootstrap`
- `pronto-scripts/init/sql/10_schema`
- `pronto-scripts/init/sql/40_seeds`
- `pronto-scripts/init/sql/migrations`
- Variables de entorno de control (`PRONTO_SKIP_SCHEMA_CHECK`, `PRONTO_SYSTEM_VERSION`)
