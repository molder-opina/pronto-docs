# pronto-redis
Version-Reglas: 1.0
Ultima-Revision: 2026-02-03
Owner: equipo-infra
SLO-Docs: actualizar en el mismo PR

## Resumen Operativo
Servicio Redis 7 para cache, streams y eventos.

## Reglas Clave
### Reglas
- Produces: `redis_runtime`.
- Prohibido modificar pods/config sin orden explícita.

### Hechos verificados
- [✅] docker-compose.yml:20 → cd "/Users/molder/projects/github - molder/pronto" && sed -n '20,60p' docker-compose.yml
- [⚠️] rg -n "redis" pronto-redis

### Pendiente de verificación
- [❓] Definir TTLs canónicos por key.

## Contratos Públicos
- Redis Keys: `pronto-docs/contracts/pronto-redis/redis_keys.md`.

## Matriz de Dependencias
```yaml
deps:
  depende_de: []
  consume: []
  produce: [redis_runtime]
  produce_para: [pronto-api, pronto-libs, pronto-client, pronto-employees]
  consumido_por: [pronto-api, pronto-libs, pronto-client, pronto-employees]
```

## Operación / Ejecución
- Compose canónico: `docker-compose.yml`.
- Infra compose: `docker-compose.infra.yml`.

## Validaciones / Tests
- Healthcheck: `redis-cli -h localhost -p 6379 ping | grep -qx PONG`.

## Anti-reglas
- NO: usar Flask sessions
  PORQUE: redis se usa para TTL/streams, no sesiones Flask

## Referencias
- `pronto-redis/README.md`
