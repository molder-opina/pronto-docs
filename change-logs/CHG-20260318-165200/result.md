# CHG-20260318-165200

- FECHA: 2026-03-18
- AGENTE: Codex (GPT-5)
- MODULOS: pronto-static
- VERSION_ANTERIOR: 1.0714
- VERSION_NUEVA: 1.0714
- RESUMEN: Se elimina la rehidratacion automatica de sesion desde la capa de transporte (`requestJSON`) en errores 401 para mantener autoridad de bootstrap centralizada; la capa HTTP ahora solo emite `HTTPError` y delega manejo a consumidores de flujo.
- COMMIT_HASHES: [65ba8cc]
- RUTAS_AFECTADAS:
  - /Users/molder/projects/github-molder/pronto/pronto-static/src/vue/clients/core/http.ts
