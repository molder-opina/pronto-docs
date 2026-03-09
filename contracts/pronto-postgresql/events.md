| Event / Artifact | Producer | Consumers | Notes |
|---|---|---|---|
| `schema:dump` | `pg_dump --schema-only` | developers / docs | Snapshot estructural para contratos |
| `migration:apply` | `pronto-migrate` | bootstrap / dev / CI | Evolución controlada del schema |
| `init:check` | `pronto-init --check` | bootstrap / dev / CI | Verifica consistencia pre-boot |

### Notas
- Las aplicaciones no deben hacer DDL runtime; la evolución vive en `pronto-scripts/init/sql/**`.
