# Pronto Documentation Index

> Última actualización: 2026-03-09

## Estructura de Documentación

```
pronto-docs/
├── architecture/       # Arquitectura técnica y decisiones de diseño
├── contracts/          # OpenAPI, schemas SQL, contratos públicos
├── errors/             # Errores activos
├── resolved/           # Errores resueltos vigentes
├── archive/            # Históricos (audits, findings, sesiones)
├── features/           # Documentación por feature
├── plans/              # Planes de migración/refactor
├── change-logs/        # Cambios y notas evolutivas
├── versioning/         # Bitácora de versionado AI
└── tmp/                # Archivos temporales
```

---

## Documentación Principal

### Infraestructura

| Archivo | Descripción |
|---------|-------------|
| [archive/sessions/DEPLOYMENT_STEPS.md](archive/sessions/DEPLOYMENT_STEPS.md) | Pasos históricos de despliegue |
| [ENVIRONMENT_VARIABLES.md](ENVIRONMENT_VARIABLES.md) | Variables de entorno |
| [PROXY_CONFIGURATION.md](PROXY_CONFIGURATION.md) | Configuración de proxy |
| [SRE_RECOMMENDATIONS.md](SRE_RECOMMENDATIONS.md) | Recomendaciones SRE |

### Estructura

| Archivo | Descripción |
|---------|-------------|
| [ARCHITECTURE_OVERVIEW.md](ARCHITECTURE_OVERVIEW.md) | Arquitectura del sistema |
| [MONOREPO.md](MONOREPO.md) | Estructura del monorepo |
| [CSS_MODULAR_ARCHITECTURE.md](CSS_MODULAR_ARCHITECTURE.md) | Arquitectura CSS |
| [TYPESCRIPT_MODULAR_ARCHITECTURE.md](TYPESCRIPT_MODULAR_ARCHITECTURE.md) | Arquitectura TypeScript |
| [archive/sessions/MODULARIZATION_SUMMARY.md](archive/sessions/MODULARIZATION_SUMMARY.md) | Resumen histórico de modularización |

### Seguridad

| Archivo | Descripción |
|---------|-------------|
| [IDENTITY.md](IDENTITY.md) | Identidad y autenticación |
| [architecture/AUTH_ARCHITECTURE.md](architecture/AUTH_ARCHITECTURE.md) | Arquitectura de auth |

### Flujos de Negocio

| Archivo | Descripción |
|---------|-------------|
| [BUSINESS_FLOWS.md](BUSINESS_FLOWS.md) | Flujos principales |
| [ORDER_VS_SESSION_IDS.md](ORDER_VS_SESSION_IDS.md) | Órdenes vs sesiones |

### Funcionalidad

| Archivo | Descripción |
|---------|-------------|
| [LOGGING_STANDARD.md](LOGGING_STANDARD.md) | Estándar de logging |
| [FLOW_DIAGRAMS.md](FLOW_DIAGRAMS.md) | Diagramas de flujo |
| [SYSTEM_ROUTES_SPEC.md](SYSTEM_ROUTES_SPEC.md) | Especificación consolidada de rutas web, API y proxy del sistema |
| [SYSTEM_ROUTES_MATRIX.md](SYSTEM_ROUTES_MATRIX.md) | Matriz operativa de rutas con auth, CSRF, actor y uso |
| [SYSTEM_ROUTES_CATALOG.md](SYSTEM_ROUTES_CATALOG.md) | Catálogo por familias de rutas con módulos origen y propósito |
| [SYSTEM_ROUTES_ENDPOINTS.md](SYSTEM_ROUTES_ENDPOINTS.md) | Índice de anexos endpoint por endpoint del `url_map` actual |
| [API_CONSUMPTION_MASTER.md](API_CONSUMPTION_MASTER.md) | README maestro que conecta curl, Postman, Insomnia y rutas del sistema |
| [API_DOMAINS_INDEX.md](API_DOMAINS_INDEX.md) | Índice documental por dominios funcionales de API |
| [domains/README.md](domains/README.md) | Fichas cortas por dominio funcional de API |
| [domains/admin-rbac.md](domains/admin-rbac.md) | Ficha operativa del dominio Admin / RBAC |
| [contracts/README.md](contracts/README.md) | Índice general de contratos públicos por superficie |
| [contracts/CONVENTIONS.md](contracts/CONVENTIONS.md) | Convenciones y semántica de los archivos estándar de contracts |
| [contracts/pronto-api/README.md](contracts/pronto-api/README.md) | Índice de contratos públicos y operativos de pronto-api |
| [pronto-api/POSTMAN_USAGE.md](pronto-api/POSTMAN_USAGE.md) | Guía de colección Postman y environment para consumir PRONTO |
| [pronto-api/INSOMNIA_USAGE.md](pronto-api/INSOMNIA_USAGE.md) | Guía de colección Insomnia para consumir PRONTO |
| [features/](features/) | Documentación de features |

### Testing

| Archivo | Descripción |
|---------|-------------|
| [QA_TEST_GUIDE.md](QA_TEST_GUIDE.md) | Guía de QA |
| [CHECKLIST-PRONTO-CLIENT.md](CHECKLIST-PRONTO-CLIENT.md) | Checklist cliente |
| [CHECKLIST-PRONTO-EMPLOYEES.md](CHECKLIST-PRONTO-EMPLOYEES.md) | Checklist empleados |
| [qa/](qa/) | Reportes de QA |

### Módulos

| Archivo | Descripción |
|---------|-------------|
| [pronto-ai.md](pronto-ai.md) | Resumen operativo del subsistema AI |
| [pronto-backups.md](pronto-backups.md) | Resumen operativo de backups por cambio |
| [pronto-docs.md](pronto-docs.md) | Resumen operativo de la superficie documental |
| [pronto-postgresql.md](pronto-postgresql.md) | Resumen operativo del datastore PostgreSQL |
| [pronto-redis.md](pronto-redis.md) | Resumen operativo de Redis |
| [pronto-static.md](pronto-static.md) | Documentación frontend |
| [pronto-employees.md](pronto-employees.md) | Documentación backend |
| [pronto-libs.md](pronto-libs.md) | Documentación librerías |
| [pronto-tests.md](pronto-tests.md) | Documentación tests |

### Contratos

| Carpeta | Descripción |
|---------|-------------|
| [contracts/](contracts/) | OpenAPI specs, SQL schemas |
| [contracts/*/openapi.yaml](contracts/) | Especificaciones API |
| [contracts/*/db_schema.sql](contracts/) | Schemas de BD |

### Errores

| Carpeta | Descripción |
|---------|-------------|
| [errors/](errors/) | Errores activos |
| [archive/](archive/) | Bugs resueltos históricos |

---

## Quick Start

1. **Para entender el proyecto:** Leer [project-overview.md](../pronto-prompts/project-overview.md)
2. **Para desplegar:** Leer [archive/sessions/DEPLOYMENT_STEPS.md](archive/sessions/DEPLOYMENT_STEPS.md)
3. **Para configurar:** Leer [ENVIRONMENT_VARIABLES.md](ENVIRONMENT_VARIABLES.md)
4. **Para la arquitectura:** Leer [ARCHITECTURE_OVERVIEW.md](ARCHITECTURE_OVERVIEW.md)

---

## Contribuir a la Documentación

### Convenciones de Nombres

- Usar `UPPERCASE_WITH_UNDERSCORES.md` para documentos principales
- Usar `kebab-case.md` para documentos específicos
- Crear carpetas para categorías

### Estructura de Documento

```markdown
# Título

> Breve descripción

## Secciones

### Subsecciones

## Referencias

- [Documento relacionado](ARCHITECTURE_OVERVIEW.md)
```

### Actualizar Este Índice

Cuando agregues documentación nueva:
1. Agregar entrada en la sección correspondiente
2. Actualizar fecha de última modificación
3. Commit con mensaje: `docs: add/update [documento]`

---

## Archivos Temporales

Archivos movidos a `tmp/` por considerarlos temporales o desactualizados:
- `despliegue-con-correcciones.md`
- `estructura-directorios.md`
- `estructura-routes-api.md`
- `concurrency-testing.md`
- `audit-agent-guide.md`

---

## Archivados

- `archive/resolved/` - documentos de bugs resueltos
- `archive/audits/` - Reportes de auditoría
- `archive/findings-autonomas/` - Hallazgos autónomos
- `archive/sessions/` - reportes históricos de implementación/sesión

---

## Contacto

Para dudas sobre la documentación, revisar [pronto-prompts/project-overview.md](../pronto-prompts/project-overview.md)
