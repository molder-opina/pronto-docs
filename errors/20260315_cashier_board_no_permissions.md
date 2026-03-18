ID: PRONTO-PAY-010
FECHA: 2026-03-15
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: CashierBoard.vue no implementa validación de permisos de pago
DESCRIPCION: El componente CashierBoard.vue muestra botones de "Cobrar" y "Dividir" sin ninguna verificación de permisos de pago. Los botones siempre están visibles sin importar la configuración del sistema, lo que puede causar comportamientos inconsistentes o errores si el usuario no tiene permisos para realizar esas acciones.
PASOS_REPRODUCIR:
1. Configurar el sistema con enable_cashier_role=false y allow_waiter_cashier_operations=false
2. Acceder al módulo de caja como cajero
3. Observar que los botones "Cobrar" y "Dividir" siguen visibles
4. Intentar usar los botones y observar errores o comportamiento inconsistente
RESULTADO_ACTUAL: Los componentes de UI no respetan la configuración de permisos de pago, mostrando funcionalidades que el usuario no puede utilizar.
RESULTADO_ESPERADO: Los botones y funcionalidades deben ocultarse o deshabilitarse según la configuración de permisos del sistema.
UBICACION:
- pronto-static/src/vue/employees/cashier/components/CashierBoard.vue
- pronto-static/src/vue/employees/shared/composables/use-payment-permissions.ts (no utilizado)
EVIDENCIA: Análisis del código muestra que CashierBoard.vue no importa ni utiliza el composable use-payment-permissions.ts, y muestra los botones sin ninguna validación de permisos.
HIPOTESIS_CAUSA: La implementación del componente se realizó antes de completar el sistema de permisos matricial, o no se actualizó para integrar la nueva funcionalidad de permisos.
ACTUALIZACION_2026-03-18:
- Resuelto: Se integró el composable `usePaymentPermissions` en `CashierBoard.vue`.
- Resuelto: Los botones de "Cobrar" y "Dividir" ahora se muestran condicionalmente basándose en el permiso `canProcessPayment`.
- Resuelto: Se garantiza consistencia visual entre la vista de tabla y la vista de tarjetas respecto a los permisos de operación financiera.
ESTADO: RESUELTO