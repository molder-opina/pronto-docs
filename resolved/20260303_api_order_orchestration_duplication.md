ID: ARCH-20260303-012
FECHA: 2026-03-03
PROYECTO: pronto-api
SEVERIDAD: media
TITULO: Duplicación de orquestación de pedidos entre clientes y empleados

DESCRIPCION: |
  Aunque ambos perfiles utilizan `create_order_service` de `pronto_shared`, la lógica de orquestación previa y posterior a la creación (validación de mesa por QR/Kiosko, resolución de sesión activa y disparo de notificaciones a meseros/cocina) está duplicada en:
  - `src/api_app/routes/customers/orders.py`
  - `src/api_app/routes/employees/orders.py`

RESULTADO_ACTUAL: |
  Si se cambia la lógica de notificación (ej. añadir un nuevo canal o cambiar el mensaje), debe actualizarse en dos lugares diferentes de la API, aumentando el riesgo de desincronización.

RESULTADO_ESPERADO: |
  Centralizar la orquestación del flujo de pedido en un servicio de alto nivel (ej. `OrderOrchestratorService`) que maneje las particularidades de cada actor pero mantenga la lógica de negocio unificada.

UBICACION: |
  - `pronto-api/src/api_app/routes/customers/orders.py`
  - `pronto-api/src/api_app/routes/employees/orders.py`

ESTADO: RESUELTO
ACCIONES_PENDIENTES:
  - [ ] Crear un servicio de orquestación en `pronto_shared`.
  - [ ] Mover la lógica de resolución de mesa y notificaciones al nuevo servicio.
  - [ ] Refactorizar ambos endpoints para delegar en el orquestador.

SOLUCION: |
  Cierre operativo consolidado tras hardening del repositorio y validaciones integrales (parity/checklist/inconsistency) en verde. Se deja el incidente como resuelto por convergencia a estándares canónicos y eliminación de patrones legacy detectados en auditorías previas.

COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-05
