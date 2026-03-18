ID: PRONTO-PAY-023
FECHA: 2026-03-15
PROYECTO: pronto-libs, pronto-api
SEVERIDAD: media
TITULO: Jerarquía de roles incompleta en autorización de pagos
DESCRIPCION: El sistema no implementa completamente la jerarquía de roles para la autorización de pagos. Según AGENTS.md, admin debe seguir las mismas reglas que cashier, pero actualmente admin tiene override implícito que le permite procesar pagos independientemente de la configuración del sistema.
PASOS_REPRODUCIR:
1. Configurar enable_cashier_role=false y allow_waiter_cashier_operations=false
2. Intentar procesar un pago como admin
3. Observar que admin aún puede procesar pagos (override implícito)
4. Verificar que esto viola la regla de que admin debe seguir las mismas reglas que cashier
RESULTADO_ACTUAL: Admin tiene override implícito que le permite procesar pagos sin respetar la configuración del sistema, lo que viola la jerarquía de roles definida en AGENTS.md.
RESULTADO_ESPERADO: Admin debe seguir las mismas reglas que cashier según la configuración del sistema, sin override implícito.
UBICACION:
- pronto-api/src/api_app/routes/employees/sessions.py
- pronto-libs/src/pronto_shared/services/payment_permission_service.py
EVIDENCIA: La lógica actual en los endpoints permite que admin procese pagos independientemente de la configuración, mientras que la regla en AGENTS.md establece que admin debe seguir las mismas reglas que cashier.
HIPOTESIS_CAUSA: La implementación de autorización se hizo antes de establecer claramente la jerarquía de roles en AGENTS.md, o no se actualizó para cumplir con esta regla.
ESTADO: ABIERTO