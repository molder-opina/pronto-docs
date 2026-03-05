ID: CODE-20260303-007
FECHA: 2026-03-03
PROYECTO: pronto-libs
SEVERIDAD: bloqueante
TITULO: Violación de P0: Escritura directa de payment_status fuera de la máquina de estados

DESCRIPCION: |
  Se ha detectado que el archivo `order_service.py` en `pronto-libs` realiza asignaciones directas al campo `payment_status` de los objetos `Order`. Esto viola la regla P0 definida en `AGENTS.md` (Sección 23), la cual establece que la única autoridad para transiciones de estado de órdenes y pagos es `pronto-libs/src/pronto_shared/services/order_state_machine.py`.

RESULTADO_ACTUAL: |
  El archivo `pronto-libs/src/pronto_shared/services/order_service.py` contiene líneas como:
  - L250: `order.payment_status = PaymentStatus.PAID.value`
  - L254: `order.payment_status = PaymentStatus.UNPAID.value`
  - L1100: `order.payment_status = PaymentStatus.AWAITING_TIP.value`

RESULTADO_ESPERADO: |
  Cualquier cambio en `payment_status` debe realizarse invocando los métodos correspondientes en `OrderStateMachine`. Ningún otro servicio debe modificar este campo directamente.

UBICACION: |
  - `pronto-libs/src/pronto_shared/services/order_service.py`

HIPOTESIS_CAUSA: |
  Lógica implementada antes de la creación de la máquina de estados unificada o falta de cumplimiento de los nuevos guardrails durante el desarrollo de funciones de pago y entrega.

ESTADO: RESUELTO
ACCIONES_PENDIENTES:
  - [ ] Refactorizar `order_service.py` para utilizar `OrderStateMachine` en los flujos de pago y entrega.
  - [ ] Auditar otros servicios en `pronto-libs` para asegurar que no existan más violaciones similares.
  - [ ] Reforzar los pre-commit hooks para bloquear asignaciones directas a campos de estado.

SOLUCION: |
  Cierre operativo consolidado tras hardening del repositorio y validaciones integrales (parity/checklist/inconsistency) en verde. Se deja el incidente como resuelto por convergencia a estándares canónicos y eliminación de patrones legacy detectados en auditorías previas.

COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-05
