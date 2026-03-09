# Reglas de Negocio y Prompt Maestro: Vista del Mesero (Waiter Console)

## Contexto
Esta vista es utilizada por los meseros del restaurante a través de `pronto-employees/waiter`. Permite gestionar las mesas asignadas, tomar pedidos manuales, responder a llamados de clientes y gestionar las cuentas.

---

## 🤖 Prompt Maestro para Desarrollo de Vista Mesero

"Actúa como un Ingeniero Senior especializado en Operaciones de Servicio de Pronto. Tu objetivo es asegurar que la consola del mesero sea eficiente, robusta y segura. Al trabajar en `pronto-employees/waiter`, debes:
1. Validar estrictamente el aislamiento por scope (`active_scope == 'waiter'`) mediante `ScopeGuard`.
2. Asegurar que el mesero solo gestione las mesas que le han sido asignadas mediante `table_assignment`.
3. Implementar notificaciones en tiempo real para llamados de clientes y estados de pedidos.
4. Garantizar que todas las mutaciones (abrir mesa, añadir orden, procesar pago) incluyan el header `X-CSRFToken`.
5. Prohibir el uso de `Flask.session` para almacenar datos de empleados; utilizar las cookies de JWT (`access_token_waiter`).
6. Asegurar que las órdenes sigan el ciclo de vida definido por `OrderStateMachine` (ej. NEW -> QUEUED)."

---

## 📋 Reglas de Negocio (Business Rules)

### 1. Gestión de Mesas (Table Management)
- **Asignación**: Un mesero debe tener mesas asignadas antes de poder operarlas. Un Administrador puede realizar estas asignaciones.
- **Estado de Mesa**: El mesero puede ver si una mesa está ocupada, libre o requiere limpieza.
- **Apertura de Sesión**: Solo un mesero o cajero puede abrir una `DiningSession` de forma manual para clientes que no usan el QR.

### 2. Toma de Pedidos (Ordering)
- **Orden Manual**: El mesero puede añadir items a una sesión activa seleccionándolos del menú.
- **Modificadores**: Debe seleccionar obligatoriamente los modificadores marcados como requeridos en el menú.
- **Envío a Cocina**: Al confirmar el pedido, las órdenes pasan a estado `QUEUED`.

### 3. Servicio y Atención
- **Llamados de Cliente**: El mesero recibe notificaciones en tiempo real (SSE) cuando un cliente solicita asistencia. Debe poder "Aceptar" el llamado para notificar al sistema que está atendiendo.
- **Entrega de Pedidos**: Cuando una orden está `READY` (listada por el Chef), el mesero es responsable de marcarla como `DELIVERED` al entregarla en la mesa.

### 4. Pagos
- **Solicitud de Cuenta**: El mesero puede imprimir/solicitar el ticket para el cliente.
- **Clip**: Si el cliente paga con terminal Clip, el mesero procesa el cobro físicamente y lo marca como `PAID` en su consola indicando la referencia.

---

## 🛠️ Reglas Técnicas y de Seguridad

### 1. Seguridad (Security)
- **ScopeGuard**: Todas las rutas bajo `/waiter/` deben validar que el JWT tenga el `active_scope: 'waiter'`.
- **Aislamiento Multi-Consola**: Las cookies de autenticación deben estar prefijadas como `access_token_waiter`.
- **JWT Inmutable**: No se permite modificar el scope del token sin un nuevo proceso de login/refresh.

### 2. Integración de API
- **Proxy Operativo**: La consola del mesero consume `pronto-api` a través de un proxy en `pronto-employees` que inyecta los encabezados de seguridad necesarios.

---

## 🔄 Flujos de Servicio (Service Flows)

1. **Flujo de Asistencia**:
   Recibir Notificación (SSE) -> Ver Mesa -> Atender Cliente -> Marcar como "Atendido" -> Notificación eliminada de la lista.
2. **Flujo de Entrega**:
   Notificación de "Orden Lista" -> Recoger de Cocina -> Entregar -> Marcar Orden como `DELIVERED` -> Estado actualizado en la cuenta de la mesa.
3. **Flujo de Pago Clip**:
   Cliente solicita cuenta -> Mesero genera ticket -> Mesero usa terminal Clip -> Pago exitoso -> Mesero marca como pagado en la consola.
