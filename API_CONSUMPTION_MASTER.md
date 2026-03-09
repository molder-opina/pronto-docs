## README maestro de consumo de APIs de PRONTO

### Objetivo
Este documento centraliza cómo consumir las superficies HTTP actuales del sistema PRONTO y conecta toda la documentación ya generada en `pronto-docs`.

### Superficies del sistema
- `pronto-api` → autoridad canónica de negocio en `http://localhost:6082/api/*`
- `pronto-client` → SSR + BFF cliente en `http://localhost:6080`
- `pronto-employees` → SSR employees + proxy scope-aware en `http://localhost:6081`

### URLs base de referencia
- API canónica: `http://localhost:6082`
- Cliente SSR/BFF: `http://localhost:6080`
- Employees SSR/proxy: `http://localhost:6081`

### Reglas de consumo importantes
- `GET /health` es público.
- `POST /api/sessions/open` es la excepción pública controlada para apertura de mesa.
- Las mutaciones suelen requerir `X-CSRFToken`.
- Para flujos cliente directos contra `pronto-api`, usar `X-PRONTO-CUSTOMER-REF` cuando aplique.
- Para trazabilidad, propagar `X-Correlation-ID`.
- El proxy `/<scope>/api/*` de employees requiere sesión válida del scope correspondiente.

### Headers frecuentes
- `Content-Type: application/json`
- `X-CSRFToken: <token>`
- `X-Correlation-ID: <uuid-o-id-operativo>`
- `X-PRONTO-CUSTOMER-REF: <uuid>`

### Mapa de documentación disponible

| Documento | Propósito |
|---|---|
| `pronto-api/API_CONSUMPTION_EXAMPLES.md` | Ejemplos `curl` y reglas base de consumo |
| `SYSTEM_ROUTES_SPEC.md` | Explicación funcional de rutas y familias |
| `SYSTEM_ROUTES_MATRIX.md` | Matriz operativa con auth, CSRF, actor y uso |
| `SYSTEM_ROUTES_CATALOG.md` | Catálogo por familias, módulos origen y propósito |
| `SYSTEM_ROUTES_ENDPOINTS.md` | Índice de anexos endpoint por endpoint |
| `API_DOMAINS_INDEX.md` | Índice documental por dominio funcional |
| `contracts/README.md` | Índice general de contratos públicos por superficie |
| `contracts/CONVENTIONS.md` | Convenciones y semántica de archivos estándar del árbol contractual |
| `contracts/pronto-api/README.md` | Contratos públicos de `pronto-api` |
| `pronto-api/POSTMAN_USAGE.md` | Uso de colección Postman |
| `pronto-api/INSOMNIA_USAGE.md` | Uso de export de Insomnia |

### Cuándo usar cada superficie

| Caso | Superficie recomendada |
|---|---|
| Integración canónica de negocio | `pronto-api` |
| Flujo browser real de cliente | `pronto-client` |
| Flujo browser real de empleados por consola | `pronto-employees` |
| Automatización manual en herramientas API | `pronto-api` primero; BFF/proxy solo si quieres reproducir el flujo web real |

### Flujos típicos recomendados

#### Cliente
1. Abrir sesión de mesa con `POST /api/sessions/open`
2. Obtener/establecer contexto de mesa
3. Login o registro de cliente
4. Consultar menú
5. Crear orden
6. Pedir cuenta / checkout
7. Pagar
8. Solicitar factura si aplica

#### Employees
1. Login por scope (`waiter`, `chef`, `cashier`, `admin`, `system`)
2. Consumir `/<scope>/api/*` si quieres reproducir el flujo SSR real
3. O consumir `pronto-api:/api/*` directamente si estás probando negocio/API

### Herramientas listas para usar

#### curl
Usa `pronto-docs/pronto-api/API_CONSUMPTION_EXAMPLES.md`.

#### Postman
Usa:
- `pronto-docs/pronto-api/POSTMAN_COLLECTION.json`
- `pronto-docs/pronto-api/POSTMAN_ENVIRONMENT.json`
- `pronto-docs/pronto-api/POSTMAN_USAGE.md`

#### Insomnia
Usa:
- `pronto-docs/pronto-api/INSOMNIA_EXPORT.json`
- `pronto-docs/pronto-api/INSOMNIA_USAGE.md`

### Referencias rápidas por necesidad

| Si necesitas... | Ve aquí |
|---|---|
| ejemplo rápido de request | `API_CONSUMPTION_EXAMPLES.md` |
| navegar por dominio funcional | `API_DOMAINS_INDEX.md` |
| saber qué ruta existe | `SYSTEM_ROUTES_ENDPOINTS.md` |
| entender para qué sirve una familia de rutas | `SYSTEM_ROUTES_SPEC.md` |
| ubicar módulos origen de rutas | `SYSTEM_ROUTES_CATALOG.md` |
| importar requests en Postman | `POSTMAN_USAGE.md` |
| importar requests en Insomnia | `INSOMNIA_USAGE.md` |

### Recomendación operativa
- Para integración nueva: empieza por `pronto-api`.
- Para reproducir comportamiento real del navegador: usa `pronto-client` o `pronto-employees`.
- Para documentación detallada de una ruta concreta: combina `SYSTEM_ROUTES_ENDPOINTS.md` + `SYSTEM_ROUTES_SPEC.md`.

### Estado actual
Este README refleja la documentación generada a partir del `url_map` real de los servicios y de los contratos presentes hoy en `pronto-docs/contracts/`.