| Path | Purpose |
|---|---|
| `README.md` | Contexto operativo del datastore PostgreSQL |
| `db_schema.sql` | Artefacto contractual local con dump schema-only documentado |
| `postgres_data/PG_VERSION` | Versión del cluster local |
| `postgres_data/pg_hba.conf` | Reglas de acceso del cluster |
| `postgres_data/pg_ident.conf` | Mapeos de identidad del cluster |
| `postgres_data/postgresql.conf` | Configuración principal PostgreSQL |
| `postgres_data/postgresql.auto.conf` | Overrides persistidos del cluster |
| `postgres_data/pg_wal/` | WAL del cluster |

### Notas
- Esta superficie documenta el datastore; no debe tocarse sin orden explícita cuando implique runtime/pods/config real.
