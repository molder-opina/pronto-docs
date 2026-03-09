# Pronto-Redis Documentation

## Overview

`pronto-redis` documenta la superficie Redis del workspace PRONTO.

### Runtime canónico
- imagen: `redis:7-alpine`
- puerto: `6379`
- compose: `docker-compose.yml`, `docker-compose.infra.yml`

## Superficie local visible

- `../../pronto-redis/README.md`
- `../../pronto-redis/Makefile`

## Uso canónico en PRONTO

Redis se usa para:

- referencias cliente con TTL
- streams/eventos operativos
- notificaciones
- cache y locks ligeros

### Clave explícita documentada por guardrails
- `pronto:client:customer_ref:<uuid>` con TTL de `60m`

## Autoridades contractuales

- keys y patrones: `../contracts/pronto-redis/redis-keys.md`
- eventos: `../contracts/pronto-redis/events.md`
- archivos/superficie: `../contracts/pronto-redis/files.md`

## Reglas importantes

- No tocar pods ni config runtime sin orden explícita.
- Redis no reemplaza la persistencia canónica de negocio en PostgreSQL.
- La auth de empleados sigue siendo JWT; no usar Redis como sustituto de ese modelo.
- La única excepción explícita de session cliente está gobernada por los guardrails del proyecto.

## Checks útiles

- `redis-cli -h localhost -p 6379 ping | grep -qx PONG`
- `make help` dentro de `pronto-redis/` para utilidades locales del módulo

## Anti-reglas

- No documentar `flask_session` como patrón canónico del proyecto.
- No promover `FLUSHDB`/`FLUSHALL` ni cambios ad-hoc de configuración como operación rutinaria.
- No inventar keys fuera del inventario contractual cuando ya exista una convención.

## Referencias

- `../../pronto-redis/README.md`
- `../pronto-redis.md`
- `../contracts/pronto-redis/README.md`
- `../contracts/pronto-redis/redis-keys.md`

