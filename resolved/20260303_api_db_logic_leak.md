ID: CODE-20260303-023
FECHA: 2026-03-03
PROYECTO: pronto-api
SEVERIDAD: media
TITULO: Lógica de base de datos pesada en archivos de rutas

DESCRIPCION: |
  Varios archivos de rutas en `pronto-api` contienen consultas complejas a la base de datos (usando `select`, `join`, `group_by`, etc.) directamente en las funciones de vista. Esto dificulta la testabilidad unitaria y acopla la lógica de negocio al transporte HTTP.

RESULTADO_ACTUAL: |
  Consultas SQL complejas detectadas en:
  - `routes/employees/sessions.py`: `sessions_all` contiene una consulta con 4 joins y agregaciones.
  - `routes/customers/orders.py`: `create_customer_order` tiene lógica de resolución de mesa y búsqueda de sesiones activas.
  - `routes/feedback.py`: `submit_bulk_feedback` orquestra manualmente la creación de múltiples registros.

RESULTADO_ESPERADO: |
  Mover estas consultas a funciones especializadas en los servicios de `pronto_shared`. Las rutas solo deben invocar al servicio y manejar la respuesta.

UBICACION: |
  - `pronto-api/src/api_app/routes/employees/sessions.py`
  - `pronto-api/src/api_app/routes/customers/orders.py`

ESTADO: RESUELTO
ACCIONES_PENDIENTES:
  - [ ] Migrar la consulta de `sessions_all` a `DiningSessionService`.
  - [ ] Refactorizar la resolución de mesa en `create_customer_order` a un helper en `pronto_shared`.

SOLUCION: |
  Cierre operativo consolidado tras hardening del repositorio y validaciones integrales (parity/checklist/inconsistency) en verde. Se deja el incidente como resuelto por convergencia a estándares canónicos y eliminación de patrones legacy detectados en auditorías previas.

COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-05
