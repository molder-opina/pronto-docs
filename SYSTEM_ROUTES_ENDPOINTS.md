## Índice endpoint por endpoint de rutas PRONTO

### Objetivo
Este índice enlaza anexos exhaustivos con las rutas observadas en el `url_map` real de cada servicio.

### Contenido
- `routes/pronto-client-endpoints.md`
- `routes/pronto-employees-endpoints.md`
- `routes/pronto-api-endpoints-01.md`
- `routes/pronto-api-endpoints-02.md`
- `routes/pronto-api-endpoints-03.md`
- `routes/pronto-api-endpoints-04.md`
- `routes/pronto-api-endpoints-05.md`
- `routes/pronto-api-endpoints-06.md`

### Notas
- Cada fila representa una regla registrada por Flask.
- Si una ruta aparece repetida, refleja aliases, compatibilidad o registros superpuestos presentes hoy en el sistema.
- Para lectura funcional usar también:
  - `SYSTEM_ROUTES_SPEC.md`
  - `SYSTEM_ROUTES_MATRIX.md`
  - `SYSTEM_ROUTES_CATALOG.md`

### Servicios cubiertos
- `pronto-client`: SSR y BFF del cliente
- `pronto-employees`: SSR por consola y proxy scope-aware
- `pronto-api`: API canónica y aliases/compat actuales

