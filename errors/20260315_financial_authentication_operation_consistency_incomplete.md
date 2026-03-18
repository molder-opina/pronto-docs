ID: PRONTO-PAY-080
FECHA: 2026-03-15
PROYECTO: pronto-libs, pronto-api
SEVERIDAD: crítica
TITULO: Consistencia de operaciones financieras con autenticación incompleta sin verificación adecuada
DESCRIPCION: El sistema no implementa una verificación adecuada de autenticación para las operaciones financieras críticas. Cuando se procesan pagos o se realizan operaciones financieras, no se garantiza que el usuario esté adecuadamente autenticado y autorizado según la configuración de permisos, lo que puede permitir accesos no autorizados a funciones financieras críticas.
PASOS_REPRODUCIR:
1. Intentar procesar un pago sin estar autenticado
2. Intentar procesar un pago con un rol no autorizado según la configuración
3. Observar si se aplican las verificaciones adecuadas de autenticación y autorización
4. Verificar si se respetan los permisos configurados (enable_cashier_role, allow_waiter_cashier_operations)
5. Comprobar si existe verificación adecuada en todos los endpoints financieros
RESULTADO_ACTUAL: Sin verificación adecuada de autenticación y autorización para las operaciones financieras críticas, lo que puede permitir accesos no autorizados a funciones financieras y violar la configuración de permisos establecida por el restaurante.
RESULTADO_ESPERADO: Debe existir una verificación adecuada de autenticación y autorización que garantice que solo usuarios autenticados y autorizados según la configuración de permisos puedan realizar operaciones financieras críticas.
UBICACION:
- pronto-api/src/api_app/routes/payments.py (endpoints de pagos)
- pronto-api/src/api_app/routes/employees/sessions.py (endpoints de sesiones)
- pronto-libs/src/pronto_shared/services/payment_permission_service.py (servicio de permisos)
- pronto-static/src/vue/employees/shared/composables/use-payment-permissions.ts (composable frontend - código muerto)
EVIDENCIA: El análisis del código muestra que aunque existe un servicio de permisos y un composable frontend, estos no se utilizan adecuadamente en los endpoints principales, y la autorización se basa principalmente en la configuración legacy waiter_can_collect sin considerar la configuración matricial completa.
HIPOTESIS_CAUSA: La implementación inicial se enfocó en la funcionalidad básica sin considerar adecuadamente los requisitos de seguridad y autorización para operaciones financieras críticas en entornos de producción donde el control de acceso es esencial para prevenir fraudes y errores operativos.
ESTADO: ABIERTO