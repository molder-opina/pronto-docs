ID: PRONTO-PAY-002
FECHA: 2026-03-15
PROYECTO: pronto-libs, pronto-api, pronto-static
SEVERIDAD: alta
TITULO: Sistema de permisos de pago con configuración dual sin sincronización
DESCRIPCION: El sistema tiene dos mecanismos separados para controlar permisos de cobro: 1) waiter_can_collect (legacy) y 2) payments.enable_cashier_role + payments.allow_waiter_cashier_operations (nuevo). Estas configuraciones coexisten sin sincronización automática, lo que puede causar comportamientos inconsistentes dependiendo de qué parte del sistema se utilice.
PASOS_REPRODUCIR:
1. Desactivar waiter_can_collect en la configuración
2. Mantener payments.allow_waiter_cashier_operations = true
3. Observar que algunos componentes permiten cobro a meseros (usando nueva configuración) mientras que otros no (usando legacy)
4. Alternativamente, desactivar payments.allow_waiter_cashier_operations pero mantener waiter_can_collect = true
5. Ver comportamiento inconsistente
RESULTADO_ACTUAL: Dos sistemas de permisos paralelos sin coordinación, causando comportamiento impredecible.
RESULTADO_ESPERADO: Un único sistema de permisos de pago que sea consistente en todo el sistema.
UBICACION:
- pronto-libs/src/pronto_shared/config_contract.py:176,251,258
- pronto-static/src/vue/employees/cashier/components/PaymentFlow.vue:165
- pronto-static/src/vue/employees/cashier/views/sessions/SessionsBoard.vue:357
- pronto-libs/src/pronto_shared/permissions.py:233
- pronto-api/src/api_app/routes/employees/sessions.py:182,254,297
EVIDENCIA: Análisis del código muestra que waiter_can_collect se usa en frontend y backend legacy, mientras que payments.* se usa en el nuevo servicio de permisos que no está integrado.
HIPOTESIS_CAUSA: La migración de waiter_can_collect a la nueva configuración matricial nunca se completó. Ambos sistemas se mantuvieron para compatibilidad pero sin mecanismo de sincronización.
ESTADO: ABIERTO