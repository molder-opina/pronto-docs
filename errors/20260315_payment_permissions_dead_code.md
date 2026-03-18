ID: PRONTO-PAY-003
FECHA: 2026-03-15
PROYECTO: pronto-static, pronto-libs
SEVERIDAD: media
TITULO: Composable y servicio de permisos de pago son código muerto
DESCRIPCION: El composable use-payment-permissions.ts y el servicio payment_permission_service.py existen pero no se utilizan en la implementación real del sistema. El composable no se importa ni se usa en ningún componente Vue, y el servicio de permisos no se integra con los endpoints principales de pago.
PASOS_REPRODUCIR:
1. Buscar usos de use-payment-permissions.ts en todo el código base
2. Verificar que no se importa en ningún componente real
3. Buscar usos de payment_permission_service.can_process_payment() en endpoints de pago
4. Verificar que los endpoints usan waiter_can_collect directamente en lugar del servicio
RESULTADO_ACTUAL: Código muerto que crea confusión y no aporta funcionalidad al sistema.
RESULTADO_ESPERADO: O bien eliminar el código muerto o integrarlo completamente en todos los componentes y endpoints relevantes.
UBICACION:
- pronto-static/src/vue/employees/shared/composables/use-payment-permissions.ts
- pronto-libs/src/pronto_shared/services/payment_permission_service.py
- pronto-static/src/vue/employees/cashier/components/PaymentFlow.vue
- pronto-static/src/vue/employees/cashier/components/CashierBoard.vue
EVIDENCIA: Análisis de dependencias muestra que el composable no tiene imports en ningún componente productivo, y los endpoints de pago no llaman a las funciones del servicio de permisos.
HIPOTESIS_CAUSA: La implementación del sistema de permisos matricial se inició pero nunca se completó la integración con el resto del sistema.
ESTADO: ABIERTO