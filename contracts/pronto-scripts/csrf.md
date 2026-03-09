## CSRF en `pronto-scripts`

- `pronto-scripts` no expone endpoints browser propios.
- Los scripts de verificación que prueban mutaciones deben respetar el flujo canónico de `X-CSRFToken` cuando interactúan con servicios reales.
- Las herramientas de diagnóstico no deben introducir bypasses permanentes de CSRF en el código del producto.
