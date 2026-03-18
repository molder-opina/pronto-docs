ID: ERR-20260317-003
FECHA: 2026-03-17
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: Tecla ESC no cierra el carrito debido a conflictos de event listeners
DESCRIPCION:
El carrito tiene dos sistemas que intentan manejar el ESC:
1. CartPanel.vue: Agrega event listener de keydown que nunca se ejecuta
2. keyboard-shortcuts.ts: Intercepta ESC, hace preventDefault/stopPropagation y manipulación DOM directa

El problema es que keyboard-shortcuts.ts intercepta el ESC antes de llegar al CartPanel, y usa manipulación DOM directa (líneas 45-46) lo cual viola las reglas de pureza Vue.
PASOS_REPRODUCIR:
1. Abrir el carrito de compras
2. Presionar la tecla ESC
RESULTADO_ACTUAL:
El carrito no se cierra porque keyboard-shortcuts.ts hace preventDefault antes de que llegue al CartPanel, y su manipulación DOM no funciona correctamente.
RESULTADO_ESPERADO:
El carrito debería cerrarse al presionar ESC sin usar manipulación DOM directa.
UBICACION:
- pronto-static/src/vue/clients/components/CartPanel.vue (líneas 204-222)
- pronto-static/src/vue/shared/lib/keyboard-shortcuts.ts (líneas 41-48, 108-114)
EVIDENCIA:
keyboard-shortcuts.ts hace document.getElementById('cart-panel').classList.remove('open') que es manipulación DOM directa prohibida.
HIPOTESIS_CAUSA:
Conflicto de prioridad de event listeners. keyboard-shortcuts.ts está registrado primero y hace preventDefault, el CartPanel nunca recibe el evento.
ESTADO: RESUELTO
SOLUCION:
1. Eliminada manipulación DOM directa en keyboard-shortcuts.ts (líneas 45-46)
2. CartPanel ahora escucha el evento 'pronto:cart-close' en lugar de keydown
3. ProfileModal ahora escucha el evento 'pronto:profile-close' para cerrarse con ESC
4. keyboard-shortcuts.ts dispatcha eventos personalizados en lugar de manipular DOM directamente

Cambios realizados:
- pronto-static/src/vue/shared/lib/keyboard-shortcuts.ts:
  - Eliminada manipulación DOM directa del cart panel
  - Ahora solo dispatcha evento 'pronto:cart-close' para el carrito
  - Ahora solo dispatcha evento 'pronto:profile-close' para el perfil
  - Ahora solo dispatcha evento 'pronto:modal-close' para modales genéricos

- pronto-static/src/vue/clients/components/CartPanel.vue:
  - Eliminado event listener de keydown
  - Agregado listener para evento 'pronto:cart-close'
  - El handler cierra el carrito si está abierto

- pronto-static/src/vue/clients/components/profile/ProfileModal.vue:
  - Agregados onMounted/onBeforeUnmount para manejar eventos
  - Agregado listener para evento 'pronto:profile-close'
  - El handler cierra el modal si está abierto

COMMIT: pendiente
FECHA_RESOLUCION: 2026-03-17
NOTAS:
- Los modales que usan ModalDialog y ConfirmDialog ya manejan ESC correctamente
- ProductDetailModal usa ModalDialog que maneja ESC
- PaymentOptionsModal (employees) ya maneja ESC correctamente
