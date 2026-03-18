ID: PRONTO-PAY-016
FECHA: 2026-03-15
PROYECTO: pronto-libs, pronto-api
SEVERIDAD: media
TITULO: Implementación incompleta de autorización por roles en endpoints de pago
DESCRIPCION: Los endpoints de pago tienen verificaciones de roles incompletas. Por ejemplo, solo cashier, admin y system pueden agregar propina, pero no se valida la configuración de permisos para otras operaciones. Además, no se implementa la regla que admin debe seguir las mismas reglas que cashier según la configuración del sistema.
PASOS_REPRODUCIR:
1. Analizar endpoints de pago en employees/sessions.py
2. Observar que solo se restringe agregar propina a cashier/admin/system
3. Verificar que otras operaciones de pago no validan adecuadamente la configuración
4. Configurar enable_cashier_role=false y allow_waiter_cashier_operations=false
5. Observar que admin aún puede procesar pagos (override implícito)
RESULTADO_ACTUAL: Autorización por roles incompleta que no respeta la configuración matricial completa del sistema y permite override implícito para admin.
RESULTADO_ESPERADO: Todos los roles deben respetar la configuración matricial, incluyendo admin que debe seguir las mismas reglas que cashier.
UBICACION:
- pronto-api/src/api_app/routes/employees/sessions.py:264-284 (solo cashier/admin/system para propina)
- pronto-libs/src/pronto_shared/services/payment_permission_service.py (lógica correcta pero no utilizada)
EVIDENCIA: El análisis del código muestra que la autorización es parcial y no implementa completamente la matriz de permisos definida en AGENTS.md sección 3.3.
HIPOTESIS_CAUSA: La implementación de autorización se hizo incrementalmente sin completar la integración con el sistema de permisos matricial completo.
ESTADO: ABIERTO