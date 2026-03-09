# Reglas de Negocio y Prompt Maestro: Vista del Chef (Kitchen Console/KDS)

## Contexto
Esta vista es utilizada por los cocineros y chefs del restaurante a través de `pronto-employees/chef`. Funciona como un Sistema de Visualización de Cocina (KDS) para gestionar la preparación de pedidos.

---

## 🤖 Prompt Maestro para Desarrollo de Vista Chef

"Actúa como un Ingeniero Senior especializado en el Sistema de Gestión de Cocina de Pronto. Tu objetivo es asegurar que el KDS sea rápido, reactivo y robusto. Al trabajar en `pronto-employees/chef`, debes:
1. Validar el aislamiento por scope (`active_scope == 'chef'`) mediante `ScopeGuard`.
2. Implementar una actualización inmediata de la interfaz mediante SSE al recibir nuevas órdenes.
3. Asegurar que las transiciones de estado (`PREPARING`, `READY`) se realicen mediante la `OrderStateMachine` de forma atómica.
4. Garantizar que todas las mutaciones incluyan el header `X-CSRFToken`.
5. Prohibir el uso de `Flask.session` para almacenar datos de empleados; utilizar las cookies de JWT (`access_token_chef`).
6. Manejar correctamente las notas de los platos y las personalizaciones para evitar errores en la preparación."

---

## 📋 Reglas de Negocio (Business Rules)

### 1. Gestión de Órdenes (Kitchen Display System - KDS)
- **Cola de Entrada**: El Chef ve una lista de órdenes con estado `QUEUED`, ordenadas por tiempo de llegada.
- **Preparación**: Al seleccionar una orden para preparar, su estado debe cambiar a `PREPARING` (registrando el `chef_id`).
- **Prioridad**: Las órdenes pueden marcarse como urgentes si el sistema así lo determina (ej. pedidos demorados).
- **Consolidación**: El chef puede ver la cantidad total de un mismo producto por preparar en todas las órdenes activas.

### 2. Estados de Preparación
- **Finalización**: Una vez terminado el plato, el Chef marca la orden como `READY`. Esto dispara automáticamente una notificación al mesero asignado a esa mesa.
- **Cancelaciones en Cocina**: El Chef puede solicitar cancelar una orden por falta de insumos, pero requiere aprobación o notificación automática a los meseros involucrados.

### 3. Personalización e Insumos
- **Visualización de Modificadores**: Los modificadores (ej. "sin cebolla") deben ser resaltados visualmente en la pantalla para evitar errores.
- **Agotamiento de Insumos**: El Chef debe poder marcar un producto del menú como "No Disponible" de forma rápida, lo cual deshabilitará el item para los clientes y meseros en tiempo real.

---

## 🛠️ Reglas Técnicas y de Seguridad

### 1. Seguridad (Security)
- **ScopeGuard**: Todas las rutas bajo `/chef/` deben validar que el JWT tenga el `active_scope: 'chef'`.
- **Aislamiento Multi-Consola**: Las cookies de autenticación deben estar prefijadas como `access_token_chef`.

### 2. Reactividad (Realtime)
- **SSE (Server-Sent Events)**: Es crítico para evitar el polling. La pantalla debe reaccionar inmediatamente a eventos de `pronto-api`.

---

## 🔄 Flujos de Servicio (Service Flows)

1. **Flujo de Preparación**:
   Recibir Orden (Status: QUEUED) -> Seleccionar "Preparar" -> Orden pasa a `PREPARING` -> Preparar -> Marcar "Listo" -> Orden pasa a `READY` -> Notificación enviada al mesero.
2. **Flujo de Agotamiento de Item**:
   Chef detecta falta de ingrediente -> Menú -> Buscar Item -> Marcar "Fuera de Inventario" -> Item se oculta para todos en el sistema.
3. **Flujo de Notas**:
   Orden llega con nota personalizada -> Sistema resalta nota -> Chef confirma lectura al iniciar preparación.
