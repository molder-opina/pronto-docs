# Pronto-PostgreSQL Documentation

## Overview

`pronto-postgresql` documenta la superficie local del datastore PostgreSQL del workspace.

### Runtime canónico
- imagen: `postgres:16-alpine`
- puerto: `5432`
- compose: `docker-compose.yml`, `docker-compose.infra.yml`

## Alcance local visible

La superficie presente en repo/documentación incluye principalmente:

- `../../pronto-postgresql/README.md`
- `../../pronto-postgresql/postgres_data/PG_VERSION`
- `../../pronto-postgresql/postgres_data/pg_hba.conf`
- `../../pronto-postgresql/postgres_data/pg_ident.conf`
- `../../pronto-postgresql/postgres_data/postgresql.conf`
- `../../pronto-postgresql/postgres_data/postgresql.auto.conf`

## Autoridades canónicas relacionadas

- Evolución DDL/init: árbol `pronto-scripts/init/sql/`
- Contrato de esta superficie: `../contracts/pronto-postgresql/README.md`
- Snapshot documental del schema: `../contracts/pronto-postgresql/db_schema.sql`

## Reglas importantes

- No tocar pods, config runtime ni datos reales sin orden explícita.
- No hacer DDL desde `pronto-api`, `pronto-client`, `pronto-employees` ni `pronto-libs/src/`.
- La separación canónica es:
  - **Init:** `pronto-scripts/init/sql/00_bootstrap..40_seeds`
  - **Migrations:** `pronto-scripts/init/sql/migrations/`

## Gates y checks relevantes

Los checks documentados por guardrails para esta superficie son:

- `pronto-scripts/bin/pronto-migrate --apply`
- `pronto-scripts/bin/pronto-init --check`
- `pg_isready -U pronto -h localhost -p 5432`

## Uso documental recomendado

- Para conocer la estructura persistente actual: revisar `db_schema.sql` contractual.
- Para revisar archivos del cluster local: usar `files.md` contractual.
- Para revisar reglas de negocio y tablas consumidas por apps: navegar desde `pronto-api`, `pronto-libs` y `pronto-docs/domains/`.

## Anti-reglas

- No documentar restores manuales ni mantenimiento destructivo como flujo rutinario.
- No presentar consultas de terminación de sesiones, `VACUUM FULL` o reindexado ad-hoc como pasos estándar.
- No tratar este README como sustituto de las migraciones canónicas.

## Referencias

- `../../pronto-postgresql/README.md`
- `../pronto-postgresql.md`
- `../contracts/pronto-postgresql/README.md`
- `../contracts/pronto-postgresql/files.md`

