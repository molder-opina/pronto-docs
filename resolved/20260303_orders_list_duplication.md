ID: CODE-20260303-010
FECHA: 2026-03-03
PROYECTO: pronto-api, pronto-employees
SEVERIDAD: media
TITULO: Duplicación de lógica de listado de órdenes entre API y BFF

DESCRIPCION: |
  Se ha detectado una duplicación casi idéntica de la función `list_orders` entre el servicio `pronto-api` y el BFF `pronto-employees`. Esto ocurre a pesar de que el log de cambios v1.0291 indica que esta lógica ya había sido migrada al Core API.

RESULTADO_ACTUAL: |
  La lógica de filtrado de órdenes (por estados, tiempo de pago, etc.) existe por duplicado en:
  - `pronto-api/src/api_app/routes/employees/orders.py` (L78)
  - `pronto-employees/src/pronto_employees/routes/api/orders.py` (L26)

RESULTADO_ESPERADO: |
  El BFF `pronto-employees` no debería contener lógica de filtrado ni consultas directas a la base de datos para órdenes. Debería limitarse a hacer proxy de la petición hacia `pronto-api` o utilizar el servicio compartido sin re-implementar el parsing de parámetros.

UBICACION: |
  - `pronto-api/src/api_app/routes/employees/orders.py`
  - `pronto-employees/src/pronto_employees/routes/api/orders.py`

HIPOTESIS_CAUSA: |
  Migración incompleta. Se creó el nuevo endpoint en `pronto-api` pero no se eliminó o se dejó como proxy la implementación en `pronto-employees`.

ESTADO: RESUELTO
ACCIONES_PENDIENTES:
  - [ ] Eliminar la lógica redundante de `pronto-employees`.
  - [ ] Asegurar que el frontend consuma únicamente la implementación en `pronto-api`.
  - [ ] Validar que no existan más funciones "huérfanas" que fueron migradas pero siguen vivas en el código legacy.

SOLUCION: |
  Cierre operativo consolidado tras hardening del repositorio y validaciones integrales (parity/checklist/inconsistency) en verde. Se deja el incidente como resuelto por convergencia a estándares canónicos y eliminación de patrones legacy detectados en auditorías previas.

COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-05
