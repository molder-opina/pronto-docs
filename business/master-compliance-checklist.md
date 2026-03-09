# Checklist Maestro de Cumplimiento y Auditoría de Archivos - Proyecto PRONTO

Este documento detalla cada archivo crítico del monorepo, su responsabilidad y las reglas de negocio/técnicas que debe hacer cumplir. Úsalo para validar que cualquier cambio mantenga la integridad del sistema.

---

## 🛠️ pronto-api (Autoridad de Negocio)

### Rutas y Controladores (`src/api_app/routes/`)
- [ ] `auth/`: Implementa JWT namespaced. **Regla**: No usar cookies genéricas; usar prefijos por scope.
- [ ] `customers/orders.py`: Validación de pedidos cliente. **Regla**: Debe validar `table_id` y `session_id` activo.
- [ ] `employees/orders.py`: Operaciones mesero/chef. **Regla**: Solo transiciones permitidas por `OrderStateMachine`.
- [ ] `payments.py`: Checkout canónico. **Regla**: El balance debe ser cero para permitir el cierre de sesión.
- [ ] `config.py`: Parámetros de sistema. **Regla**: Distinguir estrictamente entre `public_config` y `admin_config`.

### Validadores y Core
- [ ] `validators.py`: Esquemas de entrada. **Regla**: Sanitizar caracteres especiales; validar tipos de datos (UUID vs Int).

---

## 🛒 pronto-client (BFF y Experiencia Comensal)

### Rutas (`src/pronto_clients/routes/`)
- [ ] `web/`: Shell SSR. **Regla**: Cargar bootstrap config al inicio.
- [ ] `api/auth.py`: Proxy de auth cliente. **Regla**: Inyectar `X-CSRFToken` en mutaciones.
- [ ] `api/sessions.py`: Manejo de contexto de mesa. **Regla**: Persistir `table_id` en la sesión técnica de Flask.

### Frontend (Assets en `pronto-static` o `static/`)
- [ ] `menu-flow.ts`: Orquestador principal. **Regla**: Delegar a Managers especializados (SRP).
- [ ] `cart-manager.ts`: Carrito local. **Regla**: Persistencia en `localStorage` bajo la clave `pronto-cart`.
- [ ] `order-tracker.ts`: Polling de estado. **Regla**: Intervalo de 3 segundos para actualización de pagos.
- [ ] `css/menu-core.css`: Variables globales. **Regla**: Usar nombres BEM para clases.

---

## 👨‍💼 pronto-employees (Consolas de Staff)

### Arquitectura de Consolas
- [ ] `waiter/`: Consola de mesero. **Regla**: Filtrar mesas por asignación activa (`table_assignment`).
- [ ] `chef/`: KDS. **Regla**: Reactividad vía SSE obligatoria para nuevas comandas.
- [ ] `cashier/`: Cobros. **Regla**: Mostrar desglose de impuestos (IVA) y propinas por separado.
- [ ] `admin/`: Gestión. **Regla**: Acceso a reportes financieros y edición de catálogo.
- [ ] `system/`: SRE. **Regla**: Capacidad de corrección de estados inconsistentes.

### Seguridad
- [ ] `ScopeGuard`: Middleware de protección. **Regla**: Validar que `active_scope` del JWT coincida con el segmento de URL.

---

## 📚 pronto-libs (Lógica Compartida - El Cerebro)

### Servicios (`src/pronto_shared/services/`)
- [ ] `order_state_machine_core.py`: **Crítico**. Define el ciclo de vida NEW -> QUEUED -> PREPARING -> READY -> DELIVERED -> PAID.
- [ ] `menu_service_impl.py`: Reglas de Combos. **Regla**: Herencia de modificadores de productos base.
- [ ] `payment_service.py`: Lógica de cobro. **Regla**: Soporte para pagos parciales y validación de balance.
- [ ] `rbac_service.py`: Gestión de permisos. **Regla**: Los roles `system` y `admin` son protegidos.

### Modelos (`src/pronto_shared/models.py`)
- [ ] Definición de tablas. **Regla**: UUID para IDs públicos; Timestamps en UTC para auditoría.

---

## 🖼️ pronto-static (Single Source of Truth de Assets)

### CSS Modular
- [ ] `menu-filters.css`: Búsqueda y navegación.
- [ ] `menu-checkout.css`: Flujo de pago.
- [ ] `menu-orders.css`: Seguimiento de pedidos.

---

## 📜 pronto-scripts (Operaciones e Init)

### Inicialización (`bin/init/`)
- [ ] `00_bootstrap.sh`: Estructura inicial.
- [ ] `03_seed_params.sh`: Carga de datos base. **Regla**: Idempotencia garantizada.

---

## 🧪 pronto-tests (Garantía de Calidad)

### Tipos de Pruebas
- [ ] `functionality/api/`: Pruebas de contrato.
- [ ] `functionality/e2e/`: Flujos completos cliente -> api -> empleado.
- [ ] `performance/`: Pruebas de carga en endpoints críticos.
