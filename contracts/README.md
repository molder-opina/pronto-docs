## Contratos públicos de PRONTO

### Objetivo
Este directorio agrupa los contratos públicos y operativos por superficie del sistema.

### Superficies documentadas
- [pronto-api/README.md](pronto-api/README.md)
- [pronto-client/README.md](pronto-client/README.md)
- [pronto-employees/README.md](pronto-employees/README.md)
- [pronto-static/README.md](pronto-static/README.md)
- [pronto-tests/README.md](pronto-tests/README.md)
- [pronto-libs/README.md](pronto-libs/README.md)
- [pronto-scripts/README.md](pronto-scripts/README.md)
- [pronto-ai/README.md](pronto-ai/README.md)
- [pronto-docs/README.md](pronto-docs/README.md)
- [pronto-backups/README.md](pronto-backups/README.md)
- [pronto-postgresql/README.md](pronto-postgresql/README.md)
- [pronto-redis/README.md](pronto-redis/README.md)

### Cómo navegar
1. Empieza por la superficie que vas a consumir.
2. Revisa `openapi.yaml` si existe.
3. Revisa `cookies.md`, `csrf.md`, `headers.md` y `domain_contracts.md`.
4. Usa `examples.md` para bootstrap rápido.

### Convenciones del árbol
- `CONVENTIONS.md` explica el significado estándar de `README.md`, `openapi.yaml`, `files.md`, `events.md`, `redis-keys.md`, `cookies.md`, `csrf.md` y `db_schema.sql`.
- En superficies no-HTTP, `openapi.yaml` puede existir solo para declarar explícitamente que no hay API de negocio propia.
- `db_schema.sql` no debe inventarse: si no hay dump aplicable, puede permanecer como placeholder generado.

### Referencias globales
- `CONVENTIONS.md`
- `../API_CONSUMPTION_MASTER.md`
- `../API_DOMAINS_INDEX.md`
- `../INDEX.md`