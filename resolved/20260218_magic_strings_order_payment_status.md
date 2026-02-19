ID: ERR-20260218-MAGIC-STRINGS
FECHA: 2026-02-18
PROYECTO: pronto-libs, pronto-api
SEVERIDAD: alta
TITULO: Strings mágicos de estados en lugar de enums canónicos
DESCRIPCION: ~40+ instancias de strings literales ("paid", "unpaid", "cancelled", etc.) usados para comparaciones y asignaciones de workflow_status y payment_status en servicios y rutas, en lugar de usar los enums canónicos OrderStatus, PaymentStatus y SessionStatus de constants.py. Viola AGENTS.md regla de No Magic Strings (P0).
PASOS_REPRODUCIR: rg --hidden '"paid"' pronto-libs/src/pronto_shared/services/ pronto-api/src/ | rg -v constants.py|order_state_machine.py
RESULTADO_ACTUAL: Strings literales dispersos en 13+ archivos.
RESULTADO_ESPERADO: Todos los estados referenciados mediante enums canónicos.
UBICACION: order_service.py, split_bill_service.py, analytics/*.py, dining_session_service.py, menu_service.py, settings_service.py, feedback.py, customers/orders.py, employees/orders.py
EVIDENCIA: Salida del comando rg muestra ~40 hits
HIPOTESIS_CAUSA: Código escrito antes de centralizar constantes en enums; nunca se refactorizó.
ESTADO: RESUELTO
SOLUCION: Reemplazados todos los strings literales por referencias a OrderStatus.*.value, PaymentStatus.*.value y SessionStatus.*.value. Imports agregados donde faltaban.
COMMIT: pendiente
FECHA_RESOLUCION: 2026-02-18
