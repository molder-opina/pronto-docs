## Convenciones del árbol `pronto-docs/contracts/`

### Objetivo
Describir el significado esperado de los archivos estándar presentes en cada superficie contractual.

### Artefactos estándar

| Archivo | Cuándo aparece | Propósito |
|---|---|---|
| `README.md` | siempre | Punto de entrada local del paquete contractual |
| `openapi.yaml` | casi siempre | Surface HTTP o declaración explícita de que no existe API propia |
| `headers.md` | superficies web/API | Headers canónicos de integración |
| `domain_contracts.md` | superficies con dominios funcionales | Resumen auth/cookies/csrf/headers por dominio |
| `examples.md` | superficies con requests útiles | Ejemplos mínimos de consumo |
| `files.md` | siempre | Artefactos y rutas relevantes de la superficie |
| `events.md` | siempre | Eventos, streams o artefactos operativos relevantes |
| `redis-keys.md` | siempre | Namespaces Redis o declaración explícita de no ownership |
| `cookies.md` | siempre | Cookies propias o declaración explícita de no ownership |
| `csrf.md` | siempre | Regla CSRF aplicable o declaración de no participación |
| `db_schema.sql` | si hay huella estructural útil | Dump schema-only o placeholder generado/pending |

### Regla importante sobre `db_schema.sql`
- No se debe inventar schema SQL para rellenar huecos documentales.
- Si la superficie no tiene dump aplicable todavía, el archivo puede permanecer vacío o actuar como placeholder generado.
- La autoridad DDL del proyecto sigue estando en `pronto-scripts/init/**`.

### Regla sobre superficies no-HTTP
- Para superficies como `pronto-libs`, `pronto-scripts`, `pronto-ai`, `pronto-docs`, `pronto-backups`, `pronto-postgresql` y `pronto-redis`, `openapi.yaml` puede existir solo para declarar explícitamente que no exponen una API HTTP de negocio propia.

### Referencias
- `README.md`
- `../API_CONSUMPTION_MASTER.md`
- `../INDEX.md`