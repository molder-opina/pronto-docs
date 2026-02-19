ID: FEATURE-002
FECHA: 2026-02-16
PROYECTO: pronto-api, pronto-client, pronto-static
SEVERIDAD: media
TITULO: Mover de mesa (transferir orden a otra mesa) no implementado
DESCRIPCION: |
  No existe funcionalidad para mover una orden de una mesa a otra.
  Esta herramienta de negocio es necesaria cuando:
  - Un cliente cambia de mesa durante su visita
  - Se necesita reorganizar las mesas del restaurante
  - Error en la asignación inicial de mesa
  
  Solo existe TableTransferRequest para transferir meseros entre mesas, no para transferir órdenes.
PASOS_REPRODUCIR: |
  1. Tener una orden activa en una mesa
  2. Necesitar mover la orden a otra mesa
  3. No hay opción para hacer esto
  
RESULTADO_ACTUAL: No existe la funcionalidad
RESULTADO_ESPERADO: |
  - Poder mover una orden de una mesa a otra
  - La sesión del cliente se asocia a la nueva mesa
  - Historial de la transferencia
UBICACION: |
  - Modelos: pronto-libs/src/pronto_shared/models.py
  - UI: pronto-static/src/vue/employees/components/SessionsManager.vue
  - API: pronto-api/src/api_app/routes/employees/sessions.py
EVIDENCIA: No existe endpoint ni UI para move table
HIPOTESIS_CAUSA: Funcionalidad nunca implementada
ESTADO: RESUELTO
SOLUCION: |
  Se agregó endpoint API para mover sesión a otra mesa:
  - Endpoint: POST /api/sessions/<session_id>/move-to-table
  - Parámetros: table_id o table_number
  - Ubicación: pronto-api/src/api_app/routes/employees/sessions.py
  
  Servicio: pronto-libs/src/pronto_shared/services/dining_session_service.py
  Función: move_session_to_table()
COMMIT: Implementado en pronto-api y pronto-libs
FECHA_RESOLUCION: 2026-02-16
