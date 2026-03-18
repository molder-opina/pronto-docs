# CHG-20260318-164500

- FECHA: 2026-03-18
- AGENTE: Codex (GPT-5)
- MODULOS: pronto-scripts, pronto-client
- VERSION_ANTERIOR: 1.0713
- VERSION_NUEVA: 1.0713
- RESUMEN: Correccion del gate de pre-commit/push para eliminar falla por argumento no soportado (`--files-file`) en `pronto-check-business-invariants`, habilitando validaciones en modo enforce sin recurrir a `--no-verify`.
- COMMIT_HASHES: [a6935ec]
- RUTAS_AFECTADAS:
  - /Users/molder/projects/github-molder/pronto/pronto-scripts/bin/pre-commit-ai
  - /Users/molder/projects/github-molder/pronto/pronto-scripts/bin/pronto-check-business-invariants
