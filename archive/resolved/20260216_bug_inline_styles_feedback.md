ID: BUG-2026-0216-002
FECHA: 2026-02-16
PROYECTO: pronto-client
SEVERIDAD: media
TITULO: Estilos inline en template feedback.html
DESCRIPCION: |
  Los estilos CSS del componente de temporizador de feedback están incrustados directamente
  en el template HTML en lugar de estar en una hoja de estilos externa.
  Esto dificulta el mantenimiento y va en contra de las mejores prácticas de desarrollo.
PASOS_REPRODUCIR: |
  1. Abrir el archivo feedback.html
  2. Buscar la sección de estilos inline
  
RESULTADO_ACTUAL: 27 líneas de CSS inline en el template
RESULTADO_ESPERADO: Los estilos deben estar en archivo CSS externo (menu.css o feedback.css)
UBICACION: pronto-client/src/pronto_clients/templates/feedback.html:4-31
EVIDENCIA: |
  <style>
  .feedback-timer { ... }
  .feedback-timer__label { ... }
  ...
  </style>
HIPOTESIS_CAUSA: Implementación rápida sin seguir convenciones de estilos
ESTADO: RESUELTO
