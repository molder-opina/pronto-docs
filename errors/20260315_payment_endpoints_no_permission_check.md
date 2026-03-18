ID: PRONTO-PAY-014
FECHA: 2026-03-15
PROYECTO: pronto-api
SEVERIDAD: alta
TITULO: Endpoints de pago no validan configuración de permisos matricial
DESCRIPCION: Los endpoints principales de pago en pronto-api no utilizan el servicio payment_permission_service.py para validar permisos según la configuración matricial. En su lugar, usan directamente waiter_can_collect o verifican solo el rol básico sin considerar la configuración completa del sistema.
PASOS_REPRODUCIR:
1. Analizar endpoints de pago en employees/sessions.py
2. Observar que usan can_collect_payment() que verifica waiter_can_collect
3. Verificar que no se llama a can_process_payment() del nuevo servicio
4. Configurar payments.allow_waiter_cashier_operations = false pero waiter_can_collect = true
5. Observar comportamiento inconsistente
RESULTADO_ACTUAL: Los endpoints de pago no respetan la configuración matricial completa de permisos, causando comportamientos inconsistentes dependiendo de qué configuración se modifique.
RESULTADO_ESPERADO: Todos los endpoints de pago deben utilizar el servicio payment_permission_service.py para validar permisos según la configuración matricial completa.
UBICACION:
- pronto-api/src/api_app/routes/employees/sessions.py:182,254,297
- pronto-libs/src/pronto_shared/services/payment_permission_service.py (no utilizado)
EVIDENCIA: El análisis del código muestra que los endpoints usan waiter_can_collect directamente en lugar de integrar el nuevo sistema de permisos matricial.
HIPOTESIS_CAUSA: La migración del sistema de permisos legacy al nuevo sistema matricial no se completó en los endpoints de pago.
ESTADO: ABIERTO