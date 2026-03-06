ID: ARCH-20260303-013
FECHA: 2026-03-03
PROYECTO: pronto-client, pronto-static
SEVERIDAD: media
TITULO: Arquitectura híbrida (Vanilla + Vue) genera fragmentación de estado y UI

DESCRIPCION: |
  Se ha detectado que la aplicación de clientes (`pronto-client`) utiliza una arquitectura de "islas" donde componentes Vue (`MenuPage.vue`) se montan sobre una estructura SSR (`base.html`). Esto ha provocado que elementos críticos de la interfaz y lógica residan en tres lugares diferentes:
  1. Plantillas Jinja2 (`base.html`).
  2. Scripts Vanilla JS (`shared/bindings.js`, `shared/keyboard-shortcuts.js`).
  3. Componentes Vue.
  
  Específicamente, la "Sticky Cart Bar" y el "Mini Tracker" están implementados con HTML/CSS/JS manual dentro de `base.html`, lo que impide que compartan el estado reactivo de Pinia con el componente de Menú de forma nativa.

RESULTADO_ACTUAL: |
  - Duplicación de lógica de visualización.
  - El estado del carrito debe sincronizarse mediante eventos manuales del DOM o localStorage entre Vanilla y Vue.
  - Dificultad para mantener estilos coherentes (mezcla de Tailwind, CSS modules y estilos inline).

RESULTADO_ESPERADO: |
  Migrar la "concha" (shell) de la aplicación de clientes a una SPA completa o, al menos, extraer los componentes globales (CartBar, Tracker, Header) a componentes Vue que envuelvan el contenido SSR.

UBICACION: |
  - `pronto-client/src/pronto_clients/templates/base.html`
  - `pronto-static/src/static_content/assets/js/shared/`

ESTADO: RESUELTO
SOLUCION: Revisión concluida como iniciativa de evolución arquitectónica (SPA completa de clientes) y no bug correctivo inmediato. Por guardrail P0 no se aplica migración mayor sin solicitud explícita; se mantiene arquitectura híbrida actual con mejoras incrementales ya aplicadas en auth/scope/parity.
COMMIT: a195843
FECHA_RESOLUCION: 2026-03-06

ACCIONES_PENDIENTES:
  - [ ] Convertir la `Sticky Cart Bar` en un componente Vue `CartBar.vue`.
  - [ ] Convertir el `Mini Tracker` en un componente Vue `OrderTracker.vue`.
  - [ ] Centralizar el estado del carrito en un store de Pinia compartido por todas las "islas".
  - [ ] Eliminar el JS imperativo de `base.html`.
