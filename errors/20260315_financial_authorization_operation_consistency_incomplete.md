ID: PRONTO-PAY-081
FECHA: 2026-03-15
PROYECTO: pronto-libs, pronto-api
SEVERIDAD: crítica
TITULO: Consistencia de operaciones financieras con autorización incompleta sin RBAC adecuado
DESCRIPCION: El sistema no implementa un sistema adecuado de Control de Acceso Basado en Roles (RBAC) para las operaciones financieras críticas. Cuando se procesan pagos o se realizan operaciones financieras, no se garantiza que el usuario tenga los permisos adecuados según su rol y la configuración del sistema, lo que puede permitir accesos no autorizados a funciones financieras críticas.
PASOS_REPRODUCIR:
1. Configurar enable_cashier_role=false y allow_waiter_cashier_operations=false
2. Intentar procesar un pago como waiter o cashier
3. Observar si se aplican las restricciones adecuadas de autorización
4. Verificar si se respetan los permisos configurados según la matriz definida
5. Comprobar si existe un sistema RBAC adecuado que evalúe roles y configuración
RESULTADO_ACTUAL: Sin sistema RBAC adecuado para las operaciones financieras críticas, lo que puede permitir accesos no autorizados a funciones financieras y violar la configuración de permisos establecida por el restaurante según la matriz definida en AGENTS.md.
RESULTADO_ESPERADO: Debe existir un sistema RBAC adecuado que evalúe tanto el rol del usuario como la configuración del sistema para determinar si puede realizar operaciones financieras críticas, respetando la matriz de permisos definida.
UBICACION:
- pronto-api/src/api_app/routes/payments.py (endpoints de pagos)
- pronto-api/src/api_app/routes/employees/sessions.py (endpoints de sesiones)
- pronto-libs/src/pronto_shared/services/payment_permission_service.py (servicio de permisos)
- pronto-libs/src/pronto_shared/services/rbac_service.py (servicio RBAC)
EVIDENCIA: El análisis del código muestra que aunque existe un servicio de permisos y una matriz definida en AGENTS.md, los endpoints principales no utilizan adecuadamente este servicio y se basan principalmente en verificaciones básicas de rol sin considerar la configuración matricial completa.
HIPOTESIS_CAUSA: La implementación inicial se enfocó en la funcionalidad básica sin considerar adecuadamente los requisitos de autorización para operaciones financieras críticas en entornos de producción donde el control de acceso basado en roles y configuración es esencial para prevenir fraudes y errores operativos.
ESTADO: ABIERTO