ID: BUG-20260309-E2E-TABLE-NUMBER-DESYNC
FECHA: 2026-03-09
PROYECTO: pronto-api
SEVERIDAD: alta
TITULO: El flujo cliente/sesión puede desincronizar `table_id` y `table_number` y mostrar una mesa incorrecta en órdenes y notificaciones
DESCRIPCION: En la ejecución real del flujo E2E se observó una discrepancia de mesa (`V1` visible para el cliente frente a `M1` en payloads de waiter/chef). La investigación confirmó que existen varios puntos donde el flujo trabaja con `table_id` pero deja `table_number` sin sincronizar o usa un UUID de mesa donde se esperaba el código visible. Esto contamina serialización de órdenes, tableros de empleados y notificaciones.
PASOS_REPRODUCIR:
1. Abrir una sesión cliente mediante `/api/sessions/open` o el flujo normal del cliente.
2. Crear una orden desde `POST /api/customer/orders`.
3. Consultar la orden en consola de mesero/chef o revisar notificaciones emitidas.
4. Comparar la mesa visible esperada con `order.session.table_number` y los mensajes emitidos.
RESULTADO_ACTUAL:
- `create_client_session()` insertaba `table_id` pero no persistía `table_number` al abrir sesión.
- `serialize_order()` y `serialize_dining_session()` dependían directamente de `dining_session.table_number`.
- `POST /api/customer/orders` propagaba `table_number=str(table_uuid)` a `create_order_service(...)`.
- Había más ocurrencias análogas en servicios/notificaciones/tickets.
RESULTADO_ESPERADO: Toda sesión de comedor debe mantener `table_id` y `table_number` sincronizados desde su creación/reutilización. Las rutas y notificaciones deben usar el código visible canónico de mesa (`Table.table_number`), nunca el UUID técnico.
UBICACION:
- pronto-libs/src/pronto_shared/services/dining_session_service_impl.py
- pronto-libs/src/pronto_shared/services/orders/session_manager.py
- pronto-libs/src/pronto_shared/serializers.py
- pronto-api/src/api_app/routes/customers/orders.py
EVIDENCIA:
- Se introdujo `pronto_shared.session_utils` para resolver `table_number`/label de forma canónica y se sustituyeron las lecturas directas críticas en serializers, tickets, order services y rutas cliente/split-bills.
- Validación browser real: el flujo completo volvió a mostrar/propagar la mesa visible correcta y no el UUID técnico.
HIPOTESIS_CAUSA: El flujo histórico fue endurecido alrededor de `table_id`, pero no se completó la sincronización de `table_number` en todos los caminos de creación/reutilización de sesiones. Además, algunos callers conservaron un uso semánticamente incorrecto del parámetro `table_number`, propagando confusión entre UUID técnico y etiqueta visible.
ESTADO: RESUELTO
SOLUCION: Se sincronizó `table_number` al abrir/reusar sesión, se normalizó la serialización visible de mesa con helper compartido, y se corrigieron rutas/servicios/notificaciones relacionados. También se añadió barrido transversal con `rg` para cerrar ocurrencias del mismo patrón en superficies críticas.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-09

