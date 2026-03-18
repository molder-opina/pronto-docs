ID: PRONTO-PAY-009
FECHA: 2026-03-15
PROYECTO: pronto-api, pronto-libs
SEVERIDAD: alta
TITULO: Falta de validación de configuración inválida al guardar permisos de pago
DESCRIPCION: La función validate_payment_configuration() existe en payment_permission_service.py pero nunca se llama cuando se actualizan las configuraciones de permisos de pago. Esto permite guardar configuraciones inconsistentes como enable_cashier_role=false y allow_waiter_cashier_operations=false, que dejarían el sistema sin ningún rol autorizado para procesar pagos.
PASOS_REPRODUCIR:
1. Acceder a la configuración del sistema
2. Establecer payments.enable_cashier_role = false
3. Establecer payments.allow_waiter_cashier_operations = false  
4. Guardar la configuración
5. Observar que se guarda exitosamente sin validación
RESULTADO_ACTUAL: Configuraciones inválidas se permiten guardar, dejando el sistema sin capacidad de procesar pagos.
RESULTADO_ESPERADO: La API debe validar la configuración antes de guardar y rechazar configuraciones inválidas con un error claro.
UBICACION:
- pronto-libs/src/pronto_shared/services/payment_permission_service.py:84-100
- pronto-api/src/api_app/routes/config.py
- pronto-api/src/api_app/routes/employees/config.py
EVIDENCIA: La función validate_payment_configuration() está implementada pero no se utiliza en los endpoints de configuración. El análisis del código muestra que no hay llamadas a esta función cuando se actualizan las configuraciones relacionadas con pagos.
HIPOTESIS_CAUSA: La validación fue implementada como parte del servicio de permisos pero nunca se integró con los endpoints de configuración.
ESTADO: ABIERTO