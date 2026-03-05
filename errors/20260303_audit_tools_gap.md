ID: OPS-20260303-AUDIT-TOOLS
FECHA: 2026-03-03
PROYECTO: pronto-audit, pronto-prompts
SEVERIDAD: baja
TITULO: Desactualización y falta de integración de herramientas de auditoría

DESCRIPCION: |
  Se han identificado dos componentes (`pronto-audit` y `pronto-prompts`) que parecen estar desvinculados del flujo de desarrollo actual. 
  - `pronto-audit`: Contiene agentes de auditoría automatizados que no parecen estarse ejecutando en el entorno local (los reportes están vacíos) y cuya lógica podría estar desactualizada respecto a la migración a `pronto-api`.
  - `pronto-prompts`: Contiene instrucciones para agentes de IA que referencian estructuras de archivos y flujos de negocio que han cambiado en las últimas versiones del monorepo.

RESULTADO_ACTUAL: |
  Herramientas de soporte al desarrollo que dan una falsa sensación de validación o que proveen contexto erróneo a las IAs que consumen estos archivos.

RESULTADO_ESPERADO: |
  1. Integrar `pronto-audit` en el ciclo de vida principal (vía `pronto-scripts`).
  2. Actualizar los prompts en `pronto-prompts` para reflejar la autoridad única de `pronto-api` y la estructura SPA de `employees`.

UBICACION: |
  - `pronto-audit/`
  - `pronto-prompts/`

ESTADO: ABIERTO

ACCIONES_PENDIENTES:
  - [ ] Revisar la lógica de los agentes en `pronto-audit/src/pronto_audit/agents/`.
  - [ ] Actualizar `pronto-prompts/project-overview.md` con la arquitectura v6.
  - [ ] Vincular la ejecución de auditoría en `up.sh` o `rebuild.sh`.
