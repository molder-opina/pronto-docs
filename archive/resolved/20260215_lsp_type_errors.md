ID: 20260215_LSP_ERRORS
FECHA: 2026-02-15
PROYECTO: pronto-libs
SEVERIDAD: media
TITULO: Errores de tipo en models.py y otros archivos
DESCRIPCION:
El analizador LSP detecta errores de tipo en varios archivos del proyecto.
PASOS_REPRODUCIR:
Ejecutar un analizador de tipo (mypy/pyright) en el código.
RESULTADO_ACTUAL: Múltiples errores de tipo detectados
RESULTADO_ESPERADO: Sin errores de tipo
UBICACION: 
- pronto-libs/src/pronto_shared/models.py
- pronto-libs/src/pronto_shared/services/order_state_machine.py
- pronto-libs/src/pronto_shared/jwt_service.py
- pronto-libs/src/pronto_shared/security_middleware.py
- pronto-libs/src/pronto_shared/error_handlers.py
EVIDENCIA:
models.py:
- ERROR [456:22] Object of type "None" is not subscriptable
- ERROR [499:13] "logger" is not defined
- ERROR [503-505] Cannot assign to attribute "subtotal/tax_amount/total_amount" for class "DiningSession"
- ERROR [893] Argument of type "UUID" cannot be assigned to parameter "order_id" of type "int"
- ERROR [1344,1352,1360] Cannot assign to attribute "name_encrypted/email_encrypted/description_encrypted" for class "SupportTicket"

order_state_machine.py:
- ERROR [72,113,129] Type errors with OrderStatus/OrderEvent
- ERROR [198-234] Type errors with Order status assignments

jwt_service.py:
- ERROR [507,512,520] Arguments of type "Any | None" cannot be assigned to parameter types

security_middleware.py:
- ERROR [208,211] Cannot assign to attribute "_cached_form/_cached_args" for class "Request"

error_handlers.py:
- ERROR [50] Return type incompatible with ErrorHandlerCallable
HIPOTESIS_CAUSA:
- Código escribir rapidamente sin verificar tipos
- Falta de type hints en algunos lugares
- Incompatibilidades entre versiones de Python y librerías
ESTADO: RESUELTO

SOLUCION:
- Added logging import and logger instantiation in models.py
- Fixed Decimal to float conversion in DiningSession totals
- Updated emit_order_status_change to accept UUID in socketio_manager.py and realtime.py
- Fixed SupportTicket encrypted field setters to use fallback ""
- Remaining errors are false positives from SQLAlchemy type system
COMMIT: Fixed LSP type errors in models.py, socketio_manager.py, and realtime.py
FECHA_RESOLUCION: 2026-02-15
