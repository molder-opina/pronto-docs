# Pronto Documentation Index

> Última actualización: 2026-03-03

## Estructura de Documentación

```
pronto-docs/
├── infraestructura/    # Despliegue, variables de entorno, configuración
├── proyecto/           # Estado, planes, change-logs
├── funcionalidad/      # Features, implementaciones
├── flujos-negocio/     # Reglas de negocio, procesos
├── estructura/         # Arquitectura, modularización
├── seguridad/          # Autenticación, CSRF, cookies
├── testing/            # QA, checklists, tests
├── modulos/            # Documentación por módulo
├── planes/             # Planes de migración, refactor
├── contratos/          # OpenAPI, schemas SQL
├── errors/             # Errores activos
├── archive/            # Bugs resueltos históricos
└── tmp/                # Archivos temporales
```

---

## Documentación Principal

### Infraestructura

| Archivo | Descripción |
|---------|-------------|
| [DEPLOYMENT_STEPS.md](DEPLOYMENT_STEPS.md) | Pasos para despliegue |
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
| [MODULARIZATION_SUMMARY.md](MODULARIZATION_SUMMARY.md) | Resumen de modularización |

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
2. **Para desplegar:** Leer [DEPLOYMENT_STEPS.md](DEPLOYMENT_STEPS.md)
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

- [Documento relacionado](path/to/doc.md)
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

- `archive/resolved/` - 342 documentos de bugs resueltos
- `archive/audits/` - Reportes de auditoría
- `archive/findings-autonomas/` - Hallazgos autónomos

---

## Contacto

Para dudas sobre la documentación, revisar [pronto-prompts/project-overview.md](../pronto-prompts/project-overview.md)
