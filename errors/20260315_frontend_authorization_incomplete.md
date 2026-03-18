ID: PRONTO-PAY-030
FECHA: 2026-03-15
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: Autorización incompleta en frontend para permisos de pago
DESCRIPCION: El frontend no implementa completamente la autorización basada en la configuración matricial de permisos de pago. Aunque existe el composable use-payment-permissions.ts, no se utiliza en los componentes reales, y los componentes usan directamente waiter_can_collect sin considerar la configuración completa del sistema.
PASOS_REPRODUCIR:
1. Analizar el uso del composable use-payment-permissions.ts
2. Observar que no se utiliza en componentes reales como PaymentFlow.vue y CashierBoard.vue
3. Verificar que estos componentes usan waiter_can_collect directamente
4. Configurar diferentes valores en las configuraciones payments.* y observar que el frontend no responde adecuadamente
RESULTADO_ACTUAL: Frontend con autorización incompleta que no respeta la configuración matricial completa de permisos de pago, causando comportamientos inconsistentes entre lo que muestra la UI y lo que permite el backend.
RESULTADO_ESPERADO: Todos los componentes del frontend deben utilizar el composable use-payment-permissions.ts para respetar la configuración matricial completa de permisos de pago.
UBICACION:
- pronto-static/src/vue/employees/shared/composables/use-payment-permissions.ts (código muerto)
- pronto-static/src/vue/employees/cashier/components/PaymentFlow.vue (usa waiter_can_collect)
- pronto-static/src/vue/employees/cashier/components/CashierBoard.vue (sin validación de permisos)
EVIDENCIA: El análisis del código muestra que el composable existe pero no se utiliza, y los componentes reales usan la configuración legacy waiter_can_collect o no tienen validación de permisos.
HIPOTESIS_CAUSA: La migración del sistema de permisos legacy al nuevo sistema matricial no se completó en el frontend, dejando componentes que no utilizan la nueva funcionalidad.
ESTADO: ABIERTO