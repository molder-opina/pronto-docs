# pronto-employees
Version-Reglas: 1.0
Ultima-Revision: 2026-02-03
Owner: equipo-employees
SLO-Docs: actualizar en el mismo PR

## Resumen Operativo
Portal de empleados SSR. Flask + JWT + CSRF. Sin assets locales; usa pronto-static.

## Reglas Clave
### Reglas
- API usa JWT; web usa cookies firmadas/headers + CSRF.
- Prohibido `flask.session`.
- `static_folder=None`; assets solo desde pronto-static.

### Hechos verificados
- [✅] pronto-employees/src/pronto_employees/app.py:1 → cd "/Users/molder/projects/github - molder/pronto" && sed -n '1,120p' pronto-employees/src/pronto_employees/app.py
- [⚠️] rg -n "static_folder=None" pronto-employees/src

### Pendiente de verificación
- [❓] Actualizar docs legacy que mencionan static local.

## Contratos Públicos
- Cookies: `pronto-docs/contracts/pronto-employees/cookies.md`.
- CSRF: `pronto-docs/contracts/pronto-employees/csrf.md`.

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
- Override dev: `docker-compose.employees.yml`.

## Validaciones / Tests
- Tests: `pronto-tests/scripts/run-tests.sh functionality`.

## Anti-reglas
- NO: assets locales
  PORQUE: fuente única en pronto-static
- NO: flask.session
  PORQUE: rompe modelo JWT/CSRF

## Referencias
- `pronto-employees/src/pronto_employees/app.py`
