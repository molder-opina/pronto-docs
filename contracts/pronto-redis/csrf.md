## CSRF en `pronto-redis`

- Redis no participa directamente en CSRF de navegador.
- Las capas web/API que usan Redis siguen siendo responsables de `X-CSRFToken` y del token fuente canónico.
