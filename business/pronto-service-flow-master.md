# Guía Maestra de Flujos de Servicio y Prompts: Pronto Restaurant System

Este documento consolida la lógica de negocio, reglas técnicas y flujos operativos extraídos de la revisión exhaustiva de todo el monorepo.

---

## 🚦 Flujo Maestro de Órdenes (OrderStateMachine)

Cualquier cambio en la lógica de pedidos debe respetar este ciclo de vida inmutable:

1. **NEW**: La orden es creada por el cliente o mesero. Está en "borrador" o pendiente de validación técnica.
2. **QUEUED**: La orden ha sido aceptada (`/accept`) y está en la cola de cocina. Es visible en el KDS.
3. **PREPARING**: El chef ha iniciado la preparación (`/kitchen-start`). Se registra el `chef_id`.
4. **READY**: El plato está terminado (`/kitchen-ready`). Se dispara notificación al mesero.
5. **DELIVERED**: El mesero ha entregado el plato a la mesa (`/deliver`).
6. **PAID**: El pago ha sido confirmado (`/pay`). La orden ya no puede ser modificada.

---

## 🛡️ Reglas de Seguridad y Autenticación

### 1. Perímetro de Acceso (Scope Isolation)
- **JWT Multi-Scope**: Los tokens contienen un `active_scope`. Un token de `waiter` no puede acceder a rutas de `admin`.
- **Namespaced Cookies**: Para permitir el uso multi-consola en un mismo navegador, se usan prefijos: `access_token_waiter`, `access_token_chef`, `access_token_admin`.
- **Zero Flask Session for Staff**: Prohibido usar `flask.session` para empleados. La sesión de Flask solo se permite en `pronto-client` para: `customer_id`, `dining_session_id`, `table_id`.

### 2. Mutaciones Protegidas (CSRF)
- Todo `POST`, `PUT`, `DELETE` debe incluir el header `X-CSRFToken`.
- En `pronto-client`, el token se obtiene de `/api/client-auth/csrf`.

---

## 🍽️ Reglas de Catálogo y Menú

### 1. Combos y Paquetes
- **Herencia de Modificadores**: Un combo hereda los modificadores de sus productos base.
- **Validación**: No se puede agregar un combo al carrito si no se han resuelto los grupos de modificadores con `min_selection > 0`.

### 2. Disponibilidad en Tiempo Real
- Marcar un item como no disponible (`is_available = False`) debe propagarse inmediatamente a todas las interfaces mediante SSE.

---

## 💰 Reglas de Transacción y Cierre

### 1. La Regla del Balance Cero
- Una `DiningSession` no puede cerrarse (`status = closed`) si `total_orders != total_payments`.
- Los pagos parciales son permitidos, pero bloquean la edición de órdenes pagadas.

### 2. Facturación (Facturapi)
- El flujo de facturación requiere un `dining_session_id` pagado.
- El RFC y los datos fiscales se validan en el backend antes de enviar a Facturapi.

---

## 🤖 Prompt Maestro Universal para Desarrolladores (PRONTO)

"Eres un Ingeniero Principal de Software trabajando en el sistema Pronto. Conoces cada rincón del monorepo y tu prioridad es la integridad del sistema. Al implementar cualquier funcionalidad, debes:
1. **SSoT**: Asegurarte de que la lógica de negocio resida en `pronto-libs` y sea expuesta por `pronto-api`.
2. **Validación Cruzada**: Antes de mutar un estado de orden, consultar la `OrderStateMachine`.
3. **Identidad**: En flujos de cliente, usar siempre `X-PRONTO-CUSTOMER-REF`. En flujos de empleado, usar el proxy de consola correspondiente.
4. **Clean Frontend**: Seguir la arquitectura de Managers en TS y BEM en CSS. No permitir lógica de negocio en componentes Vue; delegar a los Stores de Pinia.
5. **Logs y Auditoría**: Cada acción crítica (pago, cancelación, cambio de precio) debe generar un log estructurado con `actor_id` y `timestamp`."

---

## 📂 Inventario de Documentos de Soporte (pronto-docs/business/)

- `prompt-customer-view.md`: Reglas detalladas para el comensal.
- `prompt-waiter-view.md`: Operación de piso y meseros.
- `prompt-chef-view.md`: Lógica de cocina y KDS.
- `prompt-cashier-view.md`: Cobros, balances y cierres.
- `prompt-admin-view.md`: Configuración y analítica.
- `prompt-system-view.md`: Mantenimiento y SRE.
- `prompt-architect-general.md`: Estándares técnicos transversales.
- `master-compliance-checklist.md`: Guía de auditoría archivo por archivo.
