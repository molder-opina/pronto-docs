ID: STA-20260307-001
FECHA: 2026-03-07
PROYECTO: pronto-static
SEVERIDAD: bloqueante
TITULO: existen scripts vanilla e inline handlers en static_content/shared
DESCRIPCION:
  En `pronto-static` persisten scripts JS vanilla bajo `src/static_content/assets/js/shared/`
  y uso de handlers inline `onclick` dentro de HTML inyectado. AGENTS P0 para static indica
  solo Vue y prohibe inline JS.
PASOS_REPRODUCIR:
  1. Revisar `bindings.js` y `keyboard-shortcuts.js` en assets shared.
  2. Verificar uso de `document.addEventListener`, `window.*` y `onclick` inline.
RESULTADO_ACTUAL:
  Se mantiene logica imperativa JS fuera del stack Vue y con inline handlers.
RESULTADO_ESPERADO:
  La interaccion UI debe implementarse en Vue/composables, sin scripts vanilla ni inline JS.
UBICACION:
  - pronto-static/src/static_content/assets/js/shared/bindings.js:1
  - pronto-static/src/static_content/assets/js/shared/keyboard-shortcuts.js:7
  - pronto-static/src/static_content/assets/js/shared/keyboard-shortcuts.js:167
EVIDENCIA:
  - `class KeyboardShortcutsManager` con listeners globales directos.
  - Template string con `onclick="window.keyboardShortcuts.hideHelp()"`.
HIPOTESIS_CAUSA:
  Residuo legacy pre-migracion de interacciones compartidas a Vue.
ESTADO: RESUELTO
SOLUCION:
  Se eliminaron `bindings.js` y `keyboard-shortcuts.js` del árbol shared legacy.
  Sus bindings compartidas se reemplazaron por `src/vue/shared/lib/dom-bindings.ts`,
  inicializado desde el entrypoint cliente, y el template SSR dejó de inyectar los scripts legacy.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07