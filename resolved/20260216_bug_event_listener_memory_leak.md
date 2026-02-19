ID: BUG-2026-0216-001
FECHA: 2026-02-16
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: Memory leak en event listener de checkout offers
DESCRIPCION: |
  El método showCheckoutOffers() en OrderTracker llama a addEventListener cada vez que se ejecuta
  sin remover el listener anterior. Esto causa que múltiples listeners se acumulen en el DOM.
PASOS_REPRODUCIR: |
  1. Abrir la página de cliente
  2. Solicitar checkout (pedir cuenta)
  3. Cerrar el modal de ofertas
  4. Repetir los pasos 2-3 varias veces
  5. Verificar en DevTools que los listeners se acumulan
  
RESULTADO_ACTUAL: Los event listeners se acumulan en memoria
RESULTADO_ESPERADO: Los event listeners deben limpiarse después de cada uso
UBICACION: pronto-static/src/vue/clients/modules/thank-you.ts
EVIDENCIA: |
  ```typescript
  this.elements.checkoutOffersClose?.addEventListener('click', () => {
    this.elements.checkoutOffersOverlay!.style.display = 'none';
  });
  ```
  Este código se ejecuta cada vez que se muestra el overlay sin verificar si ya existe un listener.
HIPOTESIS_CAUSA: Código legacy migrado sin protección idempotente de listeners en reinicializaciones.
ESTADO: RESUELTO
SOLUCION: Se implementó rebinding seguro con `AbortController` en `ThankYouPage.attachEventListeners()` para abortar listeners previos antes de registrar nuevos, evitando acumulación en DOM cuando el módulo se reinicializa.
COMMIT: pendiente
FECHA_RESOLUCION: 2026-02-18
