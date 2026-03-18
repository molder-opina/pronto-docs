# CHG-20260318-165800

- FECHA: 2026-03-18
- AGENTE: Codex (GPT-5)
- MODULOS: pronto-static
- VERSION_ANTERIOR: 1.0714
- VERSION_NUEVA: 1.0714
- RESUMEN: Se agrega cobertura automatica de `submitCart()` para blindar guards de concurrencia y precondiciones (`sessionReady`, carrito no vacio) y validar observabilidad de ciclo de submit (`submit_started`/`submit_resolved` con ids de idempotencia/request).
- COMMIT_HASHES: [363036d]
- RUTAS_AFECTADAS:
  - /Users/molder/projects/github-molder/pronto/pronto-static/src/vue/clients/stores/cart-store.spec.ts
