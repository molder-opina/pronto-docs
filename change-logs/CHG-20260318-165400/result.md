# CHG-20260318-165400

- FECHA: 2026-03-18
- AGENTE: Codex (GPT-5)
- MODULOS: pronto-static
- VERSION_ANTERIOR: 1.0714
- VERSION_NUEVA: 1.0714
- RESUMEN: Se agrega cobertura automatica para blindar el gate de polling unico en cliente: `startPolling()` idempotente para misma sesion, reemplazo limpio al cambiar sesion y reset de `polling_interval_count` al detener polling.
- COMMIT_HASHES: [34ff1cc]
- RUTAS_AFECTADAS:
  - /Users/molder/projects/github-molder/pronto/pronto-static/src/vue/clients/stores/orders-store.spec.ts
