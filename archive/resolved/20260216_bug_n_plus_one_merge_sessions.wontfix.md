ID: BUG-2026-0216-004
FECHA: 2026-02-16
PROYECTO: pronto-libs
SEVERIDAD: media
TITULO: Potencial N+1 query en merge_sessions
DESCRIPCION: |
  En la función merge_sessions(), al iterar sobre secondary_session.orders se puede generar
  una query N+1 debido a lazy loading de la relación orders.
  SQLAlchemy cargará las órdenes de cada sesión secundariamente de forma individual.
PASOS_REPRODUCIR: |
  1. Llamar al endpoint POST /api/sessions/merge con múltiples sesiones
  2. Monitorear queries a la base de datos
  
RESULTADO_ACTUAL: Una query por cada sesión secundaria para obtener sus órdenes
RESULTADO_ESPERADO: Carga eager de todas las órdenes en una sola query
UBICACION: pronto-libs/src/pronto_shared/services/dining_session_service.py:282-310
EVIDENCIA: |
  ```python
  for secondary_session in sessions[1:]:
      merged_order_ids.extend([str(o.id) for o in secondary_session.orders])
  ```
  El acceso a secondary_session.orders puede disparar lazy loading.
HIPOTESIS_CAUSA: Código nuevo sin optimización de queries
ESTADO: RESUELTO
