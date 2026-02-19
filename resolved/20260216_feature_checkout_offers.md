ID: FEATURE-007
FECHA: 2026-02-16
PROYECTO: pronto-client, pronto-static
SEVERIDAD: media
TITULO: Form flotante con ofertas mientras se espera al mesero al pedir cuenta no implementado
DESCRIPCION: |
  Al pedir la cuenta, se debe mostrar un formulario flotante con comerciales y ofertas
  mientras se espera la acción del mesero cobrando.
  Esta funcionalidad es para aumentar ventas adicionales mientras el cliente espera.
PASOS_REPRODUCIR: |
  1. Cliente pide la cuenta
  2. Se muestra la cuenta directamente
  3. No hay ofertas/comerciales mientras espera
  
RESULTADO_ACTUAL: No se muestran ofertas
RESULTADO_ESPERADO: |
  - Mostrar popup con ofertas/promociones mientras espera
  - Mostrar productos recomendados
  - Opción de cerrar el popup
UBICACION: |
  - UI: pronto-client/src/pronto_clients/templates/checkout.html
  - UI: pronto-static/src/vue/clients/
  - API: pronto-api/src/api_app/routes/promotions.py
EVIDENCIA: No existe el modal de ofertas durante checkout
HIPOTESIS_CAUSA: Funcionalidad nunca implementada
ESTADO: RESUELTO
SOLUCION: |
  Se agregó modal de ofertas que se muestra al pedir la cuenta:
  - Template: pronto-client/src/pronto_clients/templates/index-alt.html
  - UI: checkout-offers-overlay con estilos CSS inline
  - JS: order-tracker.ts - función showCheckoutOffers()
  
  La funcionalidad:
  - Se muestra después de solicitar checkout
  - Carga promociones desde /api/promotions?active=true
  - Muestra hasta 3 ofertas
  - Botón para cerrar el modal
COMMIT: Implementado en pronto-client y pronto-static
FECHA_RESOLUCION: 2026-02-16
