ID: ERR-20260218-CLIENT-UUID-ROUTES-SYNTAX
FECHA: 2026-02-18
PROYECTO: pronto-client
SEVERIDAD: alta
TITULO: Rutas API cliente con converters int en entidades UUID y error de sintaxis en shortcuts.py
DESCRIPCION: Se detectaron endpoints de pronto-client definidos con `<int:...>` para entidades cuyo modelo canónico en pronto_shared usa UUID (Order, DiningSession, SplitBill, SplitBillPerson). Adicionalmente, se identificó fallo de compilación en shortcuts.py que bloquea carga del módulo API.
PASOS_REPRODUCIR: 1) Ejecutar `rg -n --hidden "/<int:[a-z_]+_id>" pronto-client/src/pronto_clients/routes/api/`. 2) Revisar modelos UUID en `pronto-libs/src/pronto_shared/models.py` para Order/DiningSession/SplitBill/SplitBillPerson. 3) Compilar `shortcuts.py` y observar error de sintaxis.
RESULTADO_ACTUAL: Los endpoints mezclan converters int/uuid y shortcuts.py no compila correctamente.
RESULTADO_ESPERADO: Endpoints de entidades UUID usando `<uuid:...>` y módulo shortcuts.py compilando sin errores.
UBICACION: pronto-client/src/pronto_clients/routes/api/orders.py, pronto-client/src/pronto_clients/routes/api/stripe_payments.py, pronto-client/src/pronto_clients/routes/api/split_bills.py, pronto-client/src/pronto_clients/routes/api/feedback_email.py, pronto-client/src/pronto_clients/routes/api/shortcuts.py
EVIDENCIA: Búsquedas `rg` con rutas `<int:...>` en pronto-client y validación de modelos en pronto-libs; compilación previa reportando error en shortcuts.py.
HIPOTESIS_CAUSA: Desalineación progresiva entre contratos de rutas API y tipado de IDs en modelos compartidos, combinada con edición incompleta en shortcuts.py.
ESTADO: RESUELTO
SOLUCION: Se migraron endpoints de `int` a `uuid` en rutas de entidades UUID (`orders`, `sessions/pay`, `split-bills`, `feedback email trigger`), se reemplazó logger no estructurado por `get_logger` en `orders.py`, se corrigió import redundante en `shortcuts.py` y se normalizó `Notification.data` a objeto JSON serializable en `stripe_payments.py`.
COMMIT: pendiente
FECHA_RESOLUCION: 2026-02-18
