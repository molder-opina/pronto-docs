ID: BUG-2026-0216-003
FECHA: 2026-02-16
PROYECTO: pronto-client
SEVERIDAD: media
TITULO: Bloque grande de estilos inline en index-alt.html
DESCRIPCION: |
  El modal de ofertas (checkout-offers) tiene 85 líneas de CSS inline incrustado en el template.
  Esto dificulta el mantenimiento y va en contra de las convenciones del proyecto.
PASOS_REPRODUCIR: |
  1. Abrir el archivo index-alt.html
  2. Buscar la sección de estilos inline para checkout-offers
  
RESULTADO_ACTUAL: 85 líneas de CSS inline en el template
RESULTADO_ESPERADO: Los estilos deben estar en archivo CSS externo (menu.css)
UBICACION: pronto-client/src/pronto_clients/templates/index-alt.html:4-89
EVIDENCIA: |
  <style>
  .checkout-offers { ... }
  .checkout-offers__card { ... }
  ...
  </style>
HIPOTESIS_CAUSA: Implementación rápida sin seguir convenciones de estilos.
ESTADO: RESUELTO
SOLUCION: Se verificó que `index-alt.html` ya no contiene el bloque CSS inline extenso; la sección fue migrada a estilos canónicos en `pronto-static/src/static_content/assets/css/clients/menu-modals.css` (`.checkout-offers*`). En el template quedó solo un comentario de referencia.
COMMIT: pendiente
FECHA_RESOLUCION: 2026-02-18
