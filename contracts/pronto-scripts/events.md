| Event / Artifact | Producer | Consumers | Notes |
|---|---|---|---|
| `migration:apply` | `pronto-migrate` | bootstrap / dev / CI | Aplica evolución de schema fuera de runtime app |
| `init:check` | `pronto-init --check` | bootstrap / CI | Valida integridad inicial del sistema |
| `audit:parity-report` | `pronto-api-parity-check` | developers / CI | Señal de coherencia entre frontend y API |
| `audit:inconsistency-report` | `pronto-inconsistency-check` | developers / CI | Hallazgos rápidos de invariantes |
| `backup:change-snapshot` | `pronto-backup-change` | developers | Snapshot reversible por cambio |
| `version:change-log` | `pronto-change-log` | pronto-docs / developers | Evidencia auxiliar de trazabilidad |

### Notas
- `pronto-scripts` orquesta tooling y validaciones; no debe introducir lógica de negocio paralela.
- Los artefactos que genera sirven como evidencia operativa, no como contrato de negocio canónico alterno.
