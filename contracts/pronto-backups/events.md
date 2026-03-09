| Event / Artifact | Producer | Consumers | Notes |
|---|---|---|---|
| `backup:create` | `pronto-backup-change` | developers | Genera snapshot con metadata y archivos |
| `backup:restore` | `pronto-restore-change` | developers | Recupera estado respaldado |
| `backup:gc` | `pronto-backups-gc` | developers | Limpieza controlada de snapshots viejos |

### Notas
- Los respaldos son evidencia operativa; no sustituyen la fuente de verdad canónica del código versionado.
