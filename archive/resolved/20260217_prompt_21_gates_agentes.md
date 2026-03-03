ID: PROMPT-21
FECHA: 2026-02-17
PROYECTO: PRONTO-System
SEVERIDAD: alta
TITULO: PROMPT 21 - Sistema de Gates y Agentes

DESCRIPCION:
Falta crear prompt para implementar el sistema completo de gates y agentes de PRONTO.

CONTENIDO PROMPT:

```
Implementa el sistema completo de Gates y Agentes para PRONTO:

GATES (Orden Canonico - Ejecucion Obligatoria):

Gate A: Arquitectura (P0)
- docker-compose* tocado sin orden explicita ⇒ REJECTED

Gate B: Seguridad (P0)
- flask.session en api/employees ⇒ REJECTED
- JWT empleados modificado sin orden explicita ⇒ REJECTED

Gate C: Estaticos (P0)
- Estaticos fuera de pronto-static ⇒ REJECTED

Gate D: Roles (P0)
- rol nuevo/typo ⇒ REJECTED

Gate E: Tests (P1)
- api cambiado ⇒ API tests
- vue cambiado ⇒ Playwright
- libs cambiado ⇒ unit tests

Gate F: Docs (P1)
- cambio funcional sin doc ⇒ REJECTED

Gate G: API Parity (P1)
- Ejecutar: ./pronto-scripts/bin/pronto-api-parity-check employees
- Ejecutar: ./pronto-scripts/bin/pronto-api-parity-check clients

Gate H: Order State Authority (P0)
- Ejecutar validacion de estados de orden

AGENTES:

1. Pronto-Guardrails-Agent (P0)
Escanea:
- flask.session
- JWT empleados
- docker-compose*
- Postgres/Redis touch
- Estaticos fuera de pronto-static
- Roles invalidos
- Cross-scope imports
- DDL runtime / SQL destructivo
- Scripts fuera de pronto-scripts/bin

2. Pronto-Audit-Agent (P1)
Sistema autonomo de auditoria integral (CrewAI).
Escanea: AGENTS.md compliance, API parity, Seguridad, TypeScript/Vue quality, Deduplicacion.
Ubicacion: pronto-audit/
Entorno: Virtualenv propio (pronto-audit/.venv), gestionado por Poetry (Python 3.12 obligatorio).

3. Pronto-Precommit-Agent (P0)
Analiza archivos cambiados
Hook: .git/hooks/pre-commit -> pronto-scripts/bin/pre-commit-ai
Exit 1 si BLOCKER

4. Pronto-Static-Vue-Agent (P1)
Solo pronto-static
Reglas Vue build-only

5. Pronto-API-Agent (P1)
Solo pronto-api
No sesiones
No DDL runtime
Contrato API coherente

6. Pronto-Shared-Agent (P1)
Solo pronto-libs
No duplicados
Tests unitarios

7. Pronto-Tests-Agent (P1)
Playwright (UI)
API tests
Perf (si aplica)

8. Pronto-Docs-Agent (P1)
Verifica docs requeridas (incluye features y contracts)

9. Pronto-Scripts-Agent (P1)
Ubicacion correcta
Parametrizable
Idempotente
No side-effects peligrosos

10. Pronto-Seed-Agent (P1)
Solo en PRONTO_ENV in {dev,test}
Requiere DB de dev/test
Prohibido en prod

11. Pronto-Logging-Agent (P2)
current_app.logger o get_logger
No swallow exceptions

12. Pronto-Business-Order-Auditor-Agent (P0)
Valida negocio + enforcement:
- Grafo (ORDER_TRANSITIONS) y reglas (validate_transition)
- Uso obligatorio de OrderStateMachine
- Quick-serve / parciales / pagos (cash/card)
- Inventario de flujo en pronto-prompts/business/order_request_flow_files.md
- Tests del flujo

13. Pronto-Guardrails-Order-State-Authority (P0)
Enforcement estructural:
- Bloquea escrituras directas de estados
- Bloquea strings magicos fuera de archivos permitidos

Entrega:
- Scripts de cada agente
- YAML de configuracion
- README con ejecucion
- Tests de validacion
```

PASOS_REPRODUCIR:
1. Verificar scripts de gates/agentes en `pronto-scripts/bin/` y `pronto-scripts/bin/agents/`.
2. Ejecutar:
   - `./pronto-scripts/bin/pronto-api-parity-check employees`
   - `./pronto-scripts/bin/pronto-api-parity-check clients`
3. Ejecutar gate de autoridad de estados:
   - `rg -n --hidden "workflow_status\\s*=" pronto-api/src | rg -v "order_state_machine\\.py"`
   - `rg -n --hidden "payment_status\\s*=" pronto-api/src | rg -v "order_state_machine\\.py"`

RESULTADO_ACTUAL:
- Scripts canónicos de mantenimiento/gates disponibles en `pronto-scripts/bin/`.
- `pronto-api-parity-check employees` y `clients` retornan `ok: true`.
- Gate de authority de estado de orden/pago sin coincidencias fuera de archivos permitidos.

RESULTADO_ESPERADO:
Sistema operativo de gates y agentes con verificaciones críticas ejecutables y en verde.

UBICACION:
- pronto-scripts/bin/
- pronto-scripts/bin/agents/
- pronto-audit/
- pronto-api/src/

EVIDENCIA:
Validaciones ejecutadas el 2026-02-18 sobre scripts canónicos, parity y enforce de estados de orden/pago.

HIPOTESIS_CAUSA:
Pendiente documental de cierre del prompt aunque los componentes principales ya estaban implementados y operativos.

ESTADO: RESUELTO
SOLUCION:
Se confirmó operatividad de los gates críticos (parity + authority de estados) y del inventario de scripts/agentes en rutas canónicas, cerrando el incidente documental asociado al prompt 21.

COMMIT: pendiente
FECHA_RESOLUCION: 2026-02-18
