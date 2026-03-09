## CSRF en `pronto-tests`

- Las suites que mutan `/api/*` deben usar CSRF real, no exenciones artificiales.
- El token debe obtenerse por el flujo canónico de cada superficie bajo prueba.
- Las pruebas browser deben validar integración real de `X-CSRFToken` cuando el flujo lo requiera.

### Regla de proyecto
- Tests deben usar autenticación real y respetar las mismas barreras CSRF que producción/dev.
