# pronto-api
Version-Reglas: 1.0
Ultima-Revision: 2026-02-03
Owner: equipo-api
SLO-Docs: actualizar en el mismo PR

## Resumen Operativo
API REST unificada. Flask app factory, JWT, CORS y healthcheck. Usa Postgres y Redis vía pronto_shared.

## Reglas Clave
### Reglas
- API usa JWT; prohibido `flask.session`.
- Configuración vía `pronto_shared.config.load_config` y `validate_required_env_vars`.
- Healthcheck expuesto en `/health`.
- Produces: `http_api`, `events`, `redis_keys`, `db_schema`.

### Hechos verificados
- [✅] pronto-api/src/api_app/app.py:1 → cd "/Users/molder/projects/github - molder/pronto" && sed -n '1,140p' pronto-api/src/api_app/app.py
- [✅] docker-compose.yml:52 → cd "/Users/molder/projects/github - molder/pronto" && sed -n '1,120p' docker-compose.yml
- [⚠️] rg -n "validate_required_env_vars" pronto-api/src

### Pendiente de verificación
- [❓] Generar `db_schema.sql` con `pg_dump --schema-only`.

## Contratos Públicos
- OpenAPI: `pronto-docs/contracts/pronto-api/openapi.yaml`.
- Redis Keys: `pronto-docs/contracts/pronto-libs/redis_keys.md`.
- Events: `pronto-docs/contracts/pronto-libs/events.md`.
- DB Schema: `pronto-docs/contracts/pronto-api/db_schema.sql`.

## Matriz de Dependencias
```yaml
deps:
  depende_de: [pronto-libs, pronto-postgresql, pronto-redis]
  consume: [db_runtime, redis_runtime]
  produce: [http_api, events, redis_keys, db_schema]
  produce_para: [pronto-client, pronto-employees]
  consumido_por: [pronto-tests]
```

## Operación / Ejecución
- Compose canónico: `docker-compose.yml`.
- Override dev: `docker-compose.api.yml`.

## Validaciones / Tests
- Pre-commit: ruff-format, ruff, mypy, bandit, pip-audit, py_compile.
- Tests: `pronto-tests/scripts/run-tests.sh functionality`.

## Anti-reglas
- NO: flask.session
  PORQUE: rompe modelo JWT/CSRF
- NO: hardcode de hosts internos
  PORQUE: rompe despliegues multi-entorno

## Referencias
- `pronto-api/src/api_app/app.py`
- `pronto-api/VALIDATORS.md`
- `pronto-docs/contracts/pronto-api/openapi.yaml`
