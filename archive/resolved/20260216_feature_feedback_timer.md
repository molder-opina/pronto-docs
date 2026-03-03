ID: FEATURE-008
FECHA: 2026-02-16
PROYECTO: pronto-client, pronto-static
SEVERIDAD: media
TITULO: Contador de 10 segundos para feedback post-pago no implementado
DESCRIPCION: |
  Cuando el mesero termina de cobrar, se debe mostrar un contador de 10 segundos
  con preguntas para dar feedback y estrellas de calificación de servicio.
  Actualmente el feedback se muestra pero sin contador.
PASOS_REPRODUCIR: |
  1. Mesero completa el cobro
  2. Se muestra feedback inmediatamente
  3. No hay contador de 10 segundos
  
RESULTADO_ACTUAL: No hay contador
RESULTADO_ESPERADO: |
  - Mostrar contador de 10 segundos
  - Mostrar preguntas de feedback
  - Mostrar estrellas de calificación
  - Guardar al completar o al terminar el tiempo
UBICACION: |
  - UI: pronto-client/src/pronto_clients/templates/feedback.html
  - UI: pronto-static/src/vue/clients/
  - API: pronto-api/src/api_app/routes/feedback.py
EVIDENCIA: No existe lógica de contador en el frontend
HIPOTESIS_CAUSA: Funcionalidad nunca implementada
ESTADO: RESUELTO
SOLUCION: |
  Se agregó contador de 10 segundos en la página de feedback:
  - Template: pronto-client/src/pronto_clients/templates/feedback.html
  - HTML: feedback-timer con estilos CSS inline
  - JS: funciones startFeedbackTimer(), stopFeedbackTimer(), skipFeedback()
  
  La funcionalidad:
  - Muestra contador decreciente de 10 segundos
  - Al llegar a 0, hace skip y redirige al inicio
  - Se puede detener si el usuario envía el feedback
  - Botón "Omitir" también está disponible
COMMIT: Implementado en pronto-client
FECHA_RESOLUCION: 2026-02-16
