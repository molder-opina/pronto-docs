FECHA: 2026-03-14
BUG: BUG-CART-DB
SEVERIDAD: ALTA
ESTADO: APPLIED

TITULO: Carrito transaccional sin capa canónica DB (persistencia solo en `customer_session_store`)

CONTEXTO:
- El carrito ya existía en API/BFF/UI (`/api/customer/orders/cart*`) pero su estado vivía en payload Redis (`cart_buffer`).
- Para reducir inconsistencias y soportar flujo transaccional robusto, se creó persistencia canónica en PostgreSQL compatible con `OrderItem`.

## D0 (verificación previa obligatoria)

1) `pronto-api`:
- Evidencia: [`pronto-api/src/api_app/routes/customers/orders.py`](/Users/molder/projects/github-molder/pronto/pronto-api/src/api_app/routes/customers/orders.py)
- Hallazgo: EXISTE implementación de carrito + idempotencia.
- Decisión: MODIFICAR (refactorizar para usar servicio canónico, conservar endpoints).

2) `pronto-libs`:
- Evidencia: búsqueda transversal sin servicio/modelos de carrito persistente en `src/pronto_shared/models` y `src/pronto_shared/services`.
- Hallazgo: NO_EXISTE capa canónica de carrito en DB.
- Decisión: CREAR (`Cart`, `CartItem`, `cart_service`).

3) `pronto-scripts`:
- Evidencia: [`pronto-scripts/init/sql/10_schema/0110__core_tables.sql`](/Users/molder/projects/github-molder/pronto/pronto-scripts/init/sql/10_schema/0110__core_tables.sql) sin tablas `pronto_carts`.
- Hallazgo: NO_EXISTE DDL canónico de carrito.
- Decisión: CREAR tablas/índices en init + migración idempotente.

4) `pronto-client`/`pronto-static`:
- Evidencia: ya consumen `/api/customer/orders/cart*` y `submitCart()`.
- Hallazgo: EXISTE funcionalidad suficiente; no requiere cambio de contrato HTTP.
- Decisión: SIN CAMBIO (se mantiene compatibilidad).

## Cambios aplicados

1) DDL canónico:
- [`pronto-scripts/init/sql/10_schema/0110__core_tables.sql`](/Users/molder/projects/github-molder/pronto/pronto-scripts/init/sql/10_schema/0110__core_tables.sql)
- [`pronto-scripts/init/sql/migrations/20260314_01__create_cart_tables.sql`](/Users/molder/projects/github-molder/pronto/pronto-scripts/init/sql/migrations/20260314_01__create_cart_tables.sql)

2) Modelos y servicio:
- [`pronto-libs/src/pronto_shared/models/cart_models.py`](/Users/molder/projects/github-molder/pronto/pronto-libs/src/pronto_shared/models/cart_models.py)
- [`pronto-libs/src/pronto_shared/models/__init__.py`](/Users/molder/projects/github-molder/pronto/pronto-libs/src/pronto_shared/models/__init__.py)
- [`pronto-libs/src/pronto_shared/services/cart_service.py`](/Users/molder/projects/github-molder/pronto/pronto-libs/src/pronto_shared/services/cart_service.py)
- [`pronto-libs/tests/unit/services/test_cart_service.py`](/Users/molder/projects/github-molder/pronto/pronto-libs/tests/unit/services/test_cart_service.py)

3) API refactor:
- [`pronto-api/src/api_app/routes/customers/orders.py`](/Users/molder/projects/github-molder/pronto/pronto-api/src/api_app/routes/customers/orders.py)
- El flujo ahora usa `cart_service` para:
  - persistencia/lectura de carrito
  - replay idempotente por fingerprint + idempotency key
  - marca de `submitted`/`abandoned`
- Compatibilidad preservada: mirror hacia `customer_session_store` para clientes existentes.

## Validación

- `AST parse` archivos Python modificados: OK.
- `./pronto-scripts/bin/pronto-rules-check full`: OK.
- `./pronto-scripts/bin/pronto-no-legacy`: OK.
- `pronto-migrate --check`: FAIL por migraciones pendientes preexistentes en entorno local (`pending=9`, incluye archivos legacy previos y la nueva migración).
- `pronto-init --check`: FAIL por dependencia de `pronto-migrate --check` con pendientes.
- `pytest` focal `test_cart_service.py`: no ejecutable en entorno local actual por dependencias faltantes (`sqlalchemy`/`pytest` en intérpretes disponibles).

RIESGO RESIDUAL:
- Hasta aplicar migraciones pendientes en DB local, el runtime seguirá usando fallback de sesión para lectura/escritura de carrito.
