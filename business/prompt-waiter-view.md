# Reglas Detalladas y Prompt Maestro: Vista del Mesero (Waiter)

## 🤖 Prompt Maestro
"Actúa como un Especialista en Operaciones de Piso de Pronto. Tu objetivo es optimizar la consola del mesero (`pronto-employees/waiter`) para maximizar la velocidad de servicio y la precisión. Debes asegurar:
1. **Asignación de Mesas**: Solo permitir interactuar con mesas devueltas por `/api/table-assignments/my-tables`.
2. **Ciclo de Vida de Órdenes**: Cumplir estrictamente con `OrderStateMachine`. Una orden `READY` debe marcarse como `DELIVERED` manualmente por el mesero.
3. **Notificaciones**: Mantener un stream SSE activo hacia `/api/notifications/waiter/pending` para llamados urgentes.
4. **Seguridad**: Usar el proxy `/<scope>/api/*` para todas las mutaciones, asegurando que se inyecte la cookie `access_token_waiter`.
5. **Pagos Clip**: Al registrar un pago Clip, validar que se incluya la referencia de la terminal física."

---

## 📋 Reglas de Negocio (Business Rules)

### 1. Operación de Mesas
- **Apertura Manual**: El mesero puede abrir sesiones para clientes sin smartphone mediante `POST /api/sessions/open`.
- **Transferencia**: Si un mesero desea ceder una mesa, debe usar `/api/table-assignments/transfer-request` y esperar la aceptación del otro mesero o de un admin.

### 2. Pedidos y Comandas
- **Quick-Add**: Permitir agregar items rápidos al carrito operativo.
- **Modificadores**: Los grupos marcados como `is_required` bloquean la adición al carrito hasta que se cumpla `min_selection`.
- **Notas de Cocina**: Obligar a capturar notas si el item tiene modificadores de tipo "texto libre".

### 3. Servicio
- **Llamados de Cliente**: Un llamado de mesero tiene 3 estados: `PENDING`, `ACCEPTED`, `RESOLVED`. El mesero debe transicionar a `ACCEPTED` para que otros compañeros sepan que la mesa está siendo atendida.

---

## 🛠️ Reglas Técnicas y de Flujo

### 1. Frontend (SPA Consola)
- **Estado Local**: Usar Pinia/Vuex para mantener el estado de las mesas asignadas y evitar refetch constantes.
- **Feedback Visual**: Las mesas con órdenes `READY` (en cocina) deben parpadear o tener un indicador visual prioritario.

### 2. Integración de API
- **Headers**: Todas las peticiones deben viajar por el proxy de `pronto-employees` (Puerto 6081) bajo el prefijo `/waiter/api/`.
- **CSRF**: El header `X-CSRFToken` es obligatorio para `POST /api/orders/<id>/accept`.
