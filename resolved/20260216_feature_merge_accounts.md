ID: FEATURE-003
FECHA: 2026-02-16
PROYECTO: pronto-api, pronto-client, pronto-static
SEVERIDAD: media
TITULO: Unir cuentas (órdenes de diferentes mesas) no implementado
DESCRIPCION: |
  No existe funcionalidad para unir cuentas de diferentes mesas/órdenes.
  Esta herramienta de negocio es necesaria cuando:
  - Dos mesas deciden pagar juntos
  - Un grupo se move a otra mesa y quiere consolidar la cuenta
  - Error en la separación inicial de cuentas
  
  Actualmente cada DiningSession es independiente y no hay forma de consolidarlas.
PASOS_REPRODUCIR: |
  1. Tener dos sesiones/órdenes diferentes
  2. Necesitar unificarlas
  3. No hay opción para hacer esto
  
RESULTADO_ACTUAL: No existe la funcionalidad
RESULTADO_ESPERADO: |
  - Poder seleccionar múltiples sesiones
  - Unificarlas en una sola cuenta
  - Mantener historial de qué se unió
UBICACION: |
  - Modelos: pronto-libs/src/pronto_shared/models.py (DiningSession)
  - UI: pronto-static/src/vue/employees/components/SessionsManager.vue
  - API: pronto-api/src/api_app/routes/employees/sessions.py
EVIDENCIA: No existe endpoint ni UI para merge sessions
HIPOTESIS_CAUSA: Funcionalidad nunca implementada
ESTADO: RESUELTO
SOLUCION: |
  Se agregó endpoint API para fusionar sesiones:
  - Endpoint: POST /api/sessions/merge
  - Parámetros: session_ids (array de UUIDs)
  - Ubicación: pronto-api/src/api_app/routes/employees/sessions.py
  
  Servicio: pronto-libs/src/pronto_shared/services/dining_session_service.py
  Función: merge_sessions()
  
  La función:
  - Valida que las sesiones estén activas
  - Mueve todas las órdenes a la sesión principal
  - Actualiza los totales (subtotal, tax, tip, total_paid)
  - Marca las sesiones secundarias como "merged"
COMMIT: Implementado en pronto-api y pronto-libs
FECHA_RESOLUCION: 2026-02-16
