ID: ERR-20260226-ALERT-BLOCKING
FECHA: 2026-02-26
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: 47 usos de alert() bloqueante en employees Vue
DESCRIPCION: |
  La aplicación de empleados usa `alert()` nativo del navegador en ~47 lugares,
  bloqueando la interacción del usuario y degradando la experiencia en entornos
  críticos de operación (cocina, caja, meseros).
PASOS_REPRODUCIR:
  1. Provocar un error en cualquier acción CRUD en employees dashboard
  2. Se muestra alert() nativo bloqueando toda la interfaz
RESULTADO_ACTUAL: alert() bloqueante que congela la UI
RESULTADO_ESPERADO: Notificación toast no-bloqueante usando window.showToast()
UBICACION: pronto-static/src/vue/employees/ (24 archivos)
HIPOTESIS_CAUSA: Código escrito antes de que existiera el sistema de toasts
ESTADO: RESUELTO
SOLUCION: |
  Reemplazados 47 alert() por window.showToast?.() con tipo apropiado
  (error/success/warning/info) en 24 archivos de employees Vue.
COMMIT: (incluido en versión 1.0216→1.0217)
FECHA_RESOLUCION: 2026-02-26
