# pronto-tests
Version-Reglas: 1.0
Ultima-Revision: 2026-02-03
Owner: equipo-qa
SLO-Docs: actualizar en el mismo PR

## Resumen Operativo
Suite de pruebas centralizada (Playwright, pytest) con scripts ejecutables.

## Reglas Clave
### Reglas
- Cambios requieren pruebas ejecutables.
- `run-tests.sh` es entrypoint principal.

### Hechos verificados
- [✅] pronto-tests/README.md:1 → cd "/Users/molder/projects/github - molder/pronto" && sed -n '1,80p' pronto-tests/README.md
- [⚠️] rg -n "run-tests.sh" pronto-tests

### Pendiente de verificación
- [❓] Mapear suites por módulo en `modules.yml`.

## Contratos Públicos
- Tests contracts: `pronto-docs/contracts/pronto-tests/files.md`.

## Matriz de Dependencias
```yaml
deps:
  depende_de: [pronto-api, pronto-client, pronto-employees]
  consume: [http_api]
  produce: [test_contracts]
  produce_para: [pronto-docs]
  consumido_por: [pronto-docs]
```

## Operación / Ejecución
- `pronto-tests/scripts/run-tests.sh <suite>`.

## Validaciones / Tests
- E2E: Playwright.
- API: pytest.

## Anti-reglas
- NO: tests sin script ejecutable
  PORQUE: rompe regla de pruebas obligatorias

## Referencias
- `pronto-tests/README.md`
