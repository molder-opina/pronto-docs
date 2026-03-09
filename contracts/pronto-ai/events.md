| Event / Artifact | Producer | Consumers | Notes |
|---|---|---|---|
| `audit:ai-run` | runners AI | developers / docs | Ejecución de auditorías o revisiones con agentes |
| `audit:summary.md` | `pronto-ai-audit*` tooling | `pronto-docs/audits/ai/*` | Resumen legible del lote auditado |
| `audit:report.json` | `pronto-ai-audit*` tooling | `pronto-docs/audits/ai/*` | Salida estructurada de auditoría |
| `router:update` | mantenimiento AI | prompts / routing | Cambio controlado del router semántico |
| `parity-check:update` | mantenimiento AI | parity tooling / reviewers | Ajuste de allowlists/denylists para verificación de superficies |

### Notas
- La autoridad de prompts declarativos canónicos vive en `pronto-prompts/` según guardrails.
- `pronto-ai` concentra artefactos de soporte y conocimiento para agentes, no negocio runtime del sistema.
