# CHG-20260318-162900

- FECHA: 2026-03-18
- AGENTE: Codex (GPT-5)
- MODULOS: pronto-static, pronto-libs, pronto-client, pronto-tests
- VERSION_ANTERIOR: 1.0713
- VERSION_NUEVA: 1.0713
- RESUMEN: Continuacion de estabilizacion Big Bang del frontend cliente: fix del contrato `request-check` en fachada canónica de servicios, consolidacion del bootstrap Vue-first sin rehydrate paralelo en componentes, estabilizacion del suite Vitest de clientes y recuperacion del rebuild Docker de `pronto-client` mediante restauracion del Dockerfile faltante.
- COMMIT_HASHES: [c5ea39c, ef8e822, 3f915a0, 60772e0]
- RUTAS_AFECTADAS:
  - /Users/molder/projects/github-molder/pronto/pronto-static/src/vue/clients/views/MenuPage.vue
  - /Users/molder/projects/github-molder/pronto/pronto-static/src/vue/clients/vitest.config.ts
  - /Users/molder/projects/github-molder/pronto/pronto-static/src/vue/clients/components/cart/cart-panel.spec.ts
  - /Users/molder/projects/github-molder/pronto/pronto-static/src/vue/clients/components/profile/profile-modal.spec.ts
  - /Users/molder/projects/github-molder/pronto/pronto-static/src/vue/clients/components/navigation/tab-navigation.spec.ts
  - /Users/molder/projects/github-molder/pronto/pronto-static/src/vue/clients/components/orders/order-tracker.spec.ts
  - /Users/molder/projects/github-molder/pronto/pronto-static/src/vue/clients/components/menu/product-detail-modal.spec.ts
  - /Users/molder/projects/github-molder/pronto/pronto-libs/src/pronto_shared/services/order_service.py
  - /Users/molder/projects/github-molder/pronto/pronto-client/src/pronto_clients/Dockerfile
