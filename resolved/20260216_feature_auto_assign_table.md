ID: FEATURE-004
FECHA: 2026-02-16
PROYECTO: pronto-api, pronto-client, pronto-static
SEVERIDAD: alta
TITULO: Auto-asignación de mesa al mesero no implementado
DESCRIPCION: |
  No existe la opción de auto-asignación de mesa para meseros.
  Según la especificación de negocio:
  - Debe haber un checkbox en las opciones de mesero para autoasignar mesas
  - Si está activado, cuando llegue una orden de una mesa sin mesero asignado,
    automáticamente se asigna esa mesa al mesero
  
  Actualmente la preferencia EmployeePreference existe pero no tiene esta clave configurada.
PASOS_REPRODUCIR: |
  1. Login como mesero
  2. Buscar en preferencias opciones de auto-asignación
  3. No existe la opción
  
RESULTADO_ACTUAL: No existe la preferencia de auto-asignación
RESULTADO_ESPERADO: |
  - Checkbox en preferencias del mesero para "auto-asignar mesas"
  - Cuando hay orden de mesa sin mesero, se asigna automáticamente
  - Configuración por empleado
UBICACION: |
  - Modelos: pronto-libs/src/pronto_shared/models.py (EmployeePreference)
  - UI: pronto-static/src/vue/employees/components/EmployeesManager.vue
  - API: pronto-api/src/api_app/routes/employees/employees.py
EVIDENCIA: La preferencia EmployeePreference existe pero no hay lógica para auto_assign
HIPOTESIS_CAUSA: Funcionalidad nunca implementada
ESTADO: RESUELTO
SOLUCION: |
  La funcionalidad de auto-asignación de mesa ya estaba implementada en el backend.
  La función `_auto_assign_table_on_order_accept` en order_service.py verifica la preferencia
  `auto_assign_table_on_order_accept` del mesero.
  
  Cuando el mesero acepta una orden, si la preferencia está habilitada (por defecto true),
  se asigna automáticamente la mesa al mesero.
COMMIT: Implementado en pronto-api y pronto-libs
FECHA_RESOLUCION: 2026-02-16
