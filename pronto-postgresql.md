# pronto-postgresql
Version-Reglas: 1.0
Ultima-Revision: 2026-02-03
Owner: equipo-infra
SLO-Docs: actualizar en el mismo PR

## Resumen Operativo
Servicio PostgreSQL 16. Persistencia para el sistema.

## Reglas Clave
### Reglas
- Prohibido DROP/TRUNCATE/borrar volúmenes.
- Produces: `db_runtime`.

### Hechos verificados
- [✅] docker-compose.yml:4 → cd "/Users/molder/projects/github - molder/pronto" && sed -n '1,80p' docker-compose.yml
- [⚠️] rg -n "postgres" pronto-postgresql

### Pendiente de verificación
- [❓] Generar snapshot `db_schema.sql` con pg_dump.

## Contratos Públicos
- DB Schema: `pronto-docs/contracts/pronto-postgresql/db_schema.sql`.

## Matriz de Dependencias
```yaml
deps:
  depende_de: []
  consume: []
  produce: [db_runtime]
  produce_para: [pronto-api, pronto-libs]
  consumido_por: [pronto-api, pronto-libs]
```

## Operación / Ejecución
- Compose canónico: `docker-compose.yml`.
- Infra compose: `docker-compose.infra.yml`.

## Validaciones / Tests
- Healthcheck: `pg_isready -U pronto -h localhost -p 5432`.

## Anti-reglas
- NO: resetear base
  PORQUE: pérdida de datos

## Referencias
- `pronto-postgresql/README.md`
