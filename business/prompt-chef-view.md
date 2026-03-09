# Reglas Detalladas y Prompt Maestro: Vista del Chef (Kitchen/KDS)

## 🤖 Prompt Maestro
"Actúa como un Especialista en Sistemas de Visualización de Cocina (KDS) de Pronto. Tu misión es asegurar que la consola del Chef (`pronto-employees/chef`) garantice la salida perfecta de cada plato. Debes:
1. **Gestión de Cola**: Mostrar las órdenes en estado `QUEUED` ordenadas por el timestamp `accepted_at`.
2. **Atomicidad de Estados**: Usar `/api/orders/<id>/kitchen-start` para pasar a `PREPARING` y `/api/orders/<id>/kitchen-ready` para `READY`.
3. **Visibilidad de Modificadores**: Resaltar visualmente (color o iconos) cualquier modificador que altere la receta base (ej. 'Sin Sal', 'Alérgico a...').
4. **Disponibilidad**: Permitir al Chef marcar un item como 'Fuera de Stock' mediante `PUT /api/menu-items/<id>` (toggle availability).
5. **Seguridad**: Todas las peticiones deben incluir `access_token_chef` y validarse contra el scope `chef` en el servidor."

---

## 📋 Reglas de Negocio (Business Rules)

### 1. Preparación de Órdenes
- **Inicio de Preparación**: Al ejecutar `kitchen-start`, el sistema debe registrar el `chef_id` actual.
- **Tiempos de Preparación**: El Chef puede actualizar el tiempo estimado de un item si la cocina está saturada vía `PATCH /api/menu-items/<id>/preparation-time`.
- **Cancelación Técnica**: Si el Chef cancela una orden por falta de insumos, debe dispararse automáticamente una notificación al mesero asignado.

### 2. Organización de Pantalla
- **Consolidación**: Permitir agrupar items idénticos de diferentes comandas (ej. "Preparar 5 Hamburguesas total") para optimizar la carga de trabajo.
- **Alertas de Retraso**: Los items que excedan su `preparation_time` base en más de un 50% deben marcarse en rojo.

---

## 🛠️ Reglas Técnicas y de Flujo

### 1. Frontend (KDS)
- **Reactividad**: SSE es mandatorio. La pantalla no debe requerir recarga manual para ver nuevos pedidos.
- **Sonidos**: Implementar alertas sonoras diferenciadas para "Nuevo Pedido" y "Orden con Modificadores Críticos".

### 2. Integración de API
- **Proxy**: Todas las peticiones deben usar el prefijo `/chef/api/`.
- **Trazabilidad**: Enviar `X-Correlation-ID` para rastrear demoras desde la creación de la orden hasta el marcaje de `READY`.
