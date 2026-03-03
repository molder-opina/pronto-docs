ID: FEATURE-20260217-001
FECHA: 2026-02-17
PROYECTO: PRONTO-System
SEVERIDAD: alta
TITULO: Completar Documentacion de Implementacion - Prompts 01-20

DESCRIPCION:
Los 20 prompts de implementacion no cubren completamente todas las features implementadas en PRONTO. Se requiere documentar las areas que existen en el sistema pero no estan cubiertas en los prompts o requieren documentacion adicional.

Falta documentar:

1. **Gates y Agentes (AGENTS.md)**
   - Pronto-Guardrails-Agent (P0)
   - Pronto-Audit-Agent (P1)
   - Pronto-Precommit-Agent (P0)
   - Pronto-Static-Vue-Agent (P1)
   - Pronto-API-Agent (P1)
   - Pronto-Shared-Agent (P1)
   - Pronto-Tests-Agent (P1)
   - Pronto-Docs-Agent (P1)
   - Pronto-Scripts-Agent (P1)
   - Pronto-Seed-Agent (P1)
   - Pronto-Logging-Agent (P2)
   - Pronto-Business-Order-Auditor-Agent (P0)
   - Pronto-Guardrails-Order-State-Authority (P0)
   - Pronto-Error-Tracker-Agent (P0)

2. **Reglas de Arquitectura**
   - PRONTO_ROUTES_ONLY=1
   - Separacion Init vs Migrations
   - Versionado del Root (pronto-scripts/pronto-root/)
   - Control de version del sistema (PRONTO_SYSTEM_VERSION)
   - Bitacora de version AI

3. **Reglas de Seguridad**
   - Correlation ID obligatorio
   - Logging estructurado JSON
   - USER_MESSAGES para errores
   - Auditoria de acciones de negocio (audit_action)
   - Prohibido flask.session para empleados (JWT inmutable)

4. **API Canonica**
   - Regla canonica por host (/api/*)
   - Wrapper obligatorio para employees (http.ts)
   - Tipos de parametros en rutas (UUID vs Integer)
   - Gate de validacion de tipos

5. **Workflow de Ordenes Canónico**
   - Estados: new, queued, preparing, ready, delivered, cancelled
   - PaymentStatus: unpaid, paid
   - DiningSession status: open, active, awaiting_tip, awaiting_payment, paid
   - Reglas: auto-accept, quick-serve, pago directo

6. **Scripts de Mantenimiento**
   - pronto-full-audit.sh
   - pronto-inconsistency-check
   - pronto-api-parity-check
   - pronto-sql-safety

7. **Contratos Publicos**
   - Estructura en pronto-docs/contracts/
   - OpenAPI, redis_keys, events, db_schema, files, cookies, csrf

8. **Estaticos y Vue**
   - Fuente unica: pronto-static/src/static_content/
   - Context vars para templates
   - Build-only Vue

PASOS_REPRODUCIR:
N/A - Es documentacion faltante

RESULTADO_ACTUAL:
Los prompts 01-20 solo cubren features principales, pero el sistema tiene muchas mas reglas, gates y patrones definidos en AGENTS.md que no estan documentados como prompts separados.

RESULTADO_ESPERADO:
Documentar los prompts adicionales necesarios para cubrir todo el sistema PRONTO.

UBICACION:
- AGENTS.md (reglas completas)
- pronto-docs/errors/ (bugs)
- pronto-scripts/bin/ (scripts)

EVIDENCIA:
AGENTS.md contiene 20+ secciones que no tienen prompt equivalente.

HIPOTESIS_CAUSA:
Los prompts fueron creados antes de completar toda la implementacion y reglas del sistema.

ESTADO: RESUELTO

SOLUCION:
Crear prompts adicionales:
- PROMPT 21: Sistema de Gates y Agentes
- PROMPT 22: Reglas de Arquitectura P0
- PROMPT 23: Workflow de Ordenes Canonico
- PROMPT 24: Contratos Publicos y API Parity
- PROMPT 25: Logging y Trazabilidad
- PROMPT 26: Scripts de Mantenimiento y Auditoria

COMMIT: pendiente
FECHA_RESOLUCION: 2026-02-18
