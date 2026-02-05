# pronto-libs
Version-Reglas: 1.0
Ultima-Revision: 2026-02-03
Owner: equipo-platform
SLO-Docs: actualizar en el mismo PR

## Resumen Operativo
Librería compartida con modelos, servicios, seguridad y eventos. Fuente única de roles y contratos compartidos.

## Reglas Clave
### Reglas
- Roles canónicos en `pronto_shared.constants.Roles`.
- No duplicar lógica fuera de libs.
- Produces: `shared_models`, `db_schema`, `redis_keys`, `events`.

### Hechos verificados
- [✅] pronto-libs/src/pronto_shared/constants.py:1 → cd "/Users/molder/projects/github - molder/pronto" && sed -n '1,140p' pronto-libs/src/pronto_shared/constants.py
- [✅] pronto-libs/src/pronto_shared/validation.py:1 → cd "/Users/molder/projects/github - molder/pronto" && sed -n '1,140p' pronto-libs/src/pronto_shared/validation.py
- [⚠️] rg -n "redis" pronto-libs/src/pronto_shared

### Pendiente de verificación
- [❓] Generar `db_schema.sql` via pg_dump.

## Contratos Públicos
- Redis Keys: `pronto-docs/contracts/pronto-libs/redis_keys.md`.
- Events: `pronto-docs/contracts/pronto-libs/events.md`.
- DB Schema: `pronto-docs/contracts/pronto-libs/db_schema.sql`.

## Matriz de Dependencias
```yaml
deps:
  depende_de: [pronto-postgresql, pronto-redis]
  consume: [db_runtime, redis_runtime]
  produce: [shared_models, db_schema, redis_keys, events]
  produce_para: [pronto-api, pronto-client, pronto-employees]
  consumido_por: [pronto-api, pronto-client, pronto-employees]
```

## Operación / Ejecución
- Uso vía instalación editable o wheel.

## Validaciones / Tests
- Tests unitarios: `pronto-tests/scripts/run-tests.sh unit`.

## Anti-reglas
- NO: literales de roles fuera de libs
  PORQUE: rompe source of truth

## Referencias
- `pronto-libs/src/pronto_shared/constants.py`
- `pronto-libs/src/pronto_shared/validation.py`
