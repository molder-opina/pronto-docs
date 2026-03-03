ID: FEATURE-005
FECHA: 2026-02-16
PROYECTO: pronto-api, pronto-static
SEVERIDAD: alta
TITULO: Permiso para quitar cobro a mesero no implementado
DESCRIPCION: |
  No existe la configuración global para quitar la opción de cobro a los meseros.
  Según la especificación de negocio:
  - Por defecto el mesero puede hacer el cobro
  - Debe haber una opción para quitar esta opción al mesero
  - Solo el cashier y admin podrían cobrar
  
  Actualmente todos los meseros pueden cobrar por defecto.
PASOS_REPRODUCIR: |
  1. Login como admin
  2. Buscar en configuración opciones de permisos
  3. No hay opción para quitar cobro a meseros
  
RESULTADO_ACTUAL: No existe la configuración
RESULTADO_ESPERADO: |
  - Configuración global en business_config
  - Opción "waiter_can_collect" (default: true)
  - Si es false, meseros no ven opción de cobrar
UBICACION: |
  - Config: pronto-libs/src/pronto_shared/services/business_config_service.py
  - UI: pronto-static/src/vue/employees/components/BusinessConfig.vue
  - API: pronto-api/src/api_app/routes/employees/config.py
EVIDENCIA: No existe business_config para waiter_can_collect
HIPOTESIS_CAUSA: Funcionalidad nunca implementada
ESTADO: RESUELTO
SOLUCION: |
  Se agregó lógica de verificación en los endpoints de pago:
  - pronto-api/src/api_app/routes/employees/sessions.py
  
  Se creó la función helper `can_collect_payment()` que lee la configuración
  `waiter_can_collect` desde business_config (default: true).
  
  Los endpoints modificados verifican si el mesero tiene permiso para cobrar:
  - /sessions/<id>/checkout
  - /sessions/<id>/pay
  - /sessions/<id>/confirm-payment
  
  Para deshabilitar el cobro por meseros, configurar waiter_can_collect = false en business_config.
COMMIT: Implementado en pronto-api
FECHA_RESOLUCION: 2026-02-16
