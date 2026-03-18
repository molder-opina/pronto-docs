# CHG-20260318-170100

- FECHA: 2026-03-18
- AGENTE: Codex (GPT-5)
- MODULOS: pronto-libs, pronto-scripts
- VERSION_ANTERIOR: 1.0715
- VERSION_NUEVA: 1.0715
- RESUMEN: Regularizacion de trazabilidad explicita para commits ya incluidos y pushados en `codex/fix/phase-a3-state-machine-bypass`: centralizacion de escritura de estado `PAID` en dominio de pagos y sincronizacion del backup versionado de `PRONTO_SYSTEM_VERSION` en `pronto-scripts/pronto-root`.
- COMMIT_HASHES: [6bad092, 52047ec]
- RUTAS_AFECTADAS:
  - /Users/molder/projects/github-molder/pronto/pronto-libs/src/pronto_shared/services/order/payment_domain.py
  - /Users/molder/projects/github-molder/pronto/pronto-scripts/pronto-root/.env
  - /Users/molder/projects/github-molder/pronto/pronto-scripts/pronto-root/.env.example
