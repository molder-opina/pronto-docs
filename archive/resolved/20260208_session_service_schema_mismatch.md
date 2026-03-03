---
ID: ERR-20260208-003
FECHA: 2026-02-08
PROYECTO: pronto-shared
SEVERIDAD: critica
TITULO: Desfase de esquema en dining_session_service (SQL Directo)
DESCRIPCION: El servicio usa SQL crudo con nombres de columnas obsoletos o incorrectos (total, start_time, payment_status) que no existen en la tabla pronto_dining_sessions definida en el modelo ORM (total_amount, opened_at, status).
PASOS_REPRODUCIR:
1) Llamar a create_client_session().
2) Observar error UndefinedColumn de PostgreSQL.
RESULTADO_ACTUAL: Crash en runtime al intentar insertar sesiones.
RESULTADO_ESPERADO: Uso de nombres de columnas canónicos definidos en pronto_shared.models.DiningSession.
UBICACION: pronto-libs/src/pronto_shared/services/dining_session_service.py
EVIDENCIA: Sentencia INSERT INTO pronto_dining_sessions en líneas 45-50.
HIPOTESIS_CAUSA: El servicio se escribió antes de una migración de esquema y no se actualizó.
ESTADO: RESUELTO
SOLUCION: El archivo `dining_session_service.py` ya está usando los nombres de columnas correctos del esquema actual:
- Línea 41: `status, opened_at, expires_at, subtotal, tax_amount, tip_amount, total_amount, total_paid`
- Todos los nombres coinciden con el modelo ORM `DiningSession`
- No hay referencias a columnas obsoletas como `total`, `start_time`, o `payment_status`

El error estaba desactualizado. El servicio está sincronizado con el esquema actual.
FECHA_RESOLUCION: 2026-02-09
---
