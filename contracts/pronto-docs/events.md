| Event / Artifact | Producer | Consumers | Notes |
|---|---|---|---|
| `error:opened` | proceso de bug tracking | developers | Entrada nueva en `errors/` |
| `error:resolved` | proceso de cierre | developers | Movimiento a `resolved/` y evidencia asociada |
| `version:ai-log-entry` | agentes AI | reviewers / developers | Registro obligatorio en `AI_VERSION_LOG.md` |
| `audit:report-published` | tooling / agentes | developers | Publicación de hallazgos en `audits/` |
| `routes:inventory-refresh` | auditorías/docs tooling | developers | Actualización de inventarios `SYSTEM_ROUTES_*` y `routes/` |

### Notas
- `pronto-docs` es fuente de trazabilidad y contratos, no superficie de negocio runtime.
- La jerarquía documental del proyecto sigue dominada por `AGENTS.md`, `.env.example` y `pronto-docs/contracts/`.
