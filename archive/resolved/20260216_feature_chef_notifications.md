ID: FEATURE-006
FECHA: 2026-02-16
PROYECTO: pronto-api
SEVERIDAD: alta
TITULO: Notificaciones al chef cuando se crea orden no implementado
DESCRIPCION: |
  Cuando se crea una orden, solo se notifica al mesero pero no al chef.
  Según la especificación de negocio:
  - Cuando se crea la orden se debe notificar al chef
  - El chef tiene una lista de órdenes y selecciona la que le toca
  
  Actualmente solo hay notify_waiters pero no notify_chefs.
PASOS_REPRODUCIR: |
  1. Cliente crea una orden
  2. Ver notificaciones del chef
  3. No recibe notificación
  
RESULTADO_ACTUAL: Solo se notifica al mesero
RESULTADO_ESPERADO: |
  - Notificar al chef cuando se crea una orden
  - Notificación en tiempo real
  - Sonido de notificación
UBICACION: |
  - API: pronto-api/src/api_app/routes/customers/orders.py
  - API: pronto-api/src/api_app/routes/employees/orders.py
  - Servicio: pronto-libs/src/pronto_shared/notification_stream_service.py
EVIDENCIA: Solo existe notify_waiters, no notify_chefs
HIPOTESIS_CAUSA: Funcionalidad parcialmente implementada
ESTADO: RESUELTO
SOLUCION: |
  Se agregaron llamadas a notify_chefs en los endpoints de creación de órdenes:
  - pronto-api/src/api_app/routes/customers/orders.py (línea 79-88)
  - pronto-api/src/api_app/routes/employees/orders.py (línea 162-171)
  
  Ahora cuando se crea una orden, tanto los meseros como los cocineros reciben notificación.
COMMIT: Implementado en pronto-api
FECHA_RESOLUCION: 2026-02-16
