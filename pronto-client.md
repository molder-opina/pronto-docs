# pronto-client
Version-Reglas: 1.0
Ultima-Revision: 2026-02-03
Owner: equipo-client
SLO-Docs: actualizar en el mismo PR

## Resumen Operativo
Cliente web SSR. Flask + JWT + CSRF para rutas web, API interna para clientes.

## Reglas Clave
### Reglas
- API usa JWT; web usa cookies firmadas/headers + CSRF.
- `flask.session` permitido solo con allowlist: `dining_session_id`, `customer_ref`.
- PII fuera de session: Redis TTL 60m en `pronto:client:customer_ref:<uuid>`.

### Hechos verificados
- [✅] pronto-client/src/pronto_clients/app.py:1 → cd "/Users/molder/projects/github - molder/pronto" && sed -n '1,140p' pronto-client/src/pronto_clients/app.py
- [✅] pronto-client/src/pronto_clients/routes/api/orders.py:1 → cd "/Users/molder/projects/github - molder/pronto" && sed -n '1,140p' pronto-client/src/pronto_clients/routes/api/orders.py
- [✅] pronto-client/src/pronto_clients/utils/customer_session.py:1 → cd "/Users/molder/projects/github - molder/pronto" && sed -n '1,120p' pronto-client/src/pronto_clients/utils/customer_session.py
- [⚠️] rg -n "session\[" pronto-client/src/pronto_clients

### Pendiente de verificación
N/A

## Contratos Públicos
- Cookies: `pronto-docs/contracts/pronto-client/cookies.md`.
- CSRF: `pronto-docs/contracts/pronto-client/csrf.md`.
- Redis Keys: `pronto-docs/contracts/pronto-client/redis_keys.md`.
- Events: `pronto-docs/contracts/pronto-client/events.md`.

## Matriz de Dependencias
```yaml
deps:
  depende_de: [pronto-libs, pronto-api, pronto-redis, pronto-static]
  consume: [http_api, cookies, csrf, redis_keys, events]
  produce: [http_web]
  produce_para: [pronto-tests]
  consumido_por: [pronto-tests]
```

## Operación / Ejecución
- Compose canónico: `docker-compose.yml`.
- Override dev: `docker-compose.client.yml`.

## Validaciones / Tests
- Tests: `pronto-tests/scripts/run-tests.sh functionality` (e2e clientes).

## Anti-reglas
- NO: guardar PII/tokens en session
  PORQUE: riesgo de fuga y violación de policy
- NO: usar session para authz
  PORQUE: rompe JWT/CSRF

## Referencias
- `pronto-client/src/pronto_clients/app.py`
- `pronto-client/src/pronto_clients/routes/api/orders.py`
