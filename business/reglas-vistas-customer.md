# Reglas de Negocio y Prompt Maestro: Vista del Cliente (Customer/Guest)

## Contexto
Esta vista es utilizada por los comensales del restaurante a través de `pronto-client`. Permite navegar el menú, realizar pedidos, pagar y solicitar asistencia. Puede funcionar en modo "Mesa" (escaneando QR) o modo "Kiosko".

---

## 🤖 Prompt Maestro para Desarrollo de Vista Cliente

"Actúa como un Ingeniero Senior especializado en la Experiencia del Cliente de Pronto. Tu objetivo es asegurar que la interfaz del cliente sea intuitiva, segura y respete estrictamente las reglas de negocio. Al diseñar o implementar funcionalidades para `pronto-client`, debes:
1. Priorizar la navegación anónima (Guest First): El cliente debe poder ver el menú y armar su carrito sin loguearse inicialmente.
2. Validar siempre el contexto de la mesa (`table_id`) y la sesión activa (`dining_session_id`).
3. Asegurar que los estados de las órdenes se reflejen en tiempo real mediante SSE o WebSockets.
4. Implementar el flujo de 'Combos' permitiendo la personalización heredada de los productos base.
5. Garantizar que las mutaciones (pedir, pagar, llamar mesero) incluyan el header `X-CSRFToken`.
6. No permitir el uso de `Flask.session` para datos de empleados; solo para `customer_id`, `dining_session_id` y claves permitidas."

---

## 📋 Reglas de Negocio (Business Rules)

### 1. Gestión de Sesiones
- **Apertura de Sesión**: Se puede abrir una sesión de forma anónima al escanear un QR válido.
- **Validación de Mesa**: No se puede realizar un pedido sin un `table_id` válido y verificado en el backend.
- **Sesiones Compartidas**: Múltiples clientes pueden unirse a la misma `dining_session_id` escaneando el mismo QR de la mesa.

### 2. Menú y Pedidos
- **Navegación**: El menú debe ser accesible sin autenticación previa (Anonymous Browsing).
- **Combos/Paquetes**:
    - Un combo no es un producto aislado; es una composición de productos base.
    - Debe permitir seleccionar modificadores heredados de los productos que componen el combo.
- **Personalización**: Los items del menú pueden tener `modifier_groups` (ej. término de la carne, extras). Algunos pueden ser obligatorios.
- **Estado de Orden**: El cliente solo puede ver sus propias órdenes y el estado general de la mesa si está en la misma sesión.

### 3. Pagos
- **Stripe**: Pago directo desde el navegador. Requiere confirmación de éxito desde el webhook/API.
- **Clip/Efectivo**: El cliente solicita el pago; esto genera una notificación al mesero/cajero. La sesión no se cierra hasta que el empleado confirme el pago en su respectiva consola.
- **Propina**: El cliente puede sugerir/añadir propina antes de procesar el pago digital.

---

## 🛠️ Reglas Técnicas y de Seguridad

### 1. Seguridad (Security)
- **CSRF**: Obligatorio en todos los `POST`, `PUT`, `DELETE`. El token se obtiene de `/api/client-auth/csrf`.
- **Headers**: Las peticiones a la API deben incluir el header `X-Customer-Ref` si está disponible.
- **Sesión Flask**: Permitido el uso limitado de `flask.session` solo para: `customer_id`, `dining_session_id`, `customer_ref`, `table_id`. **NUNCA** guardar datos sensibles o de empleados.

### 2. Integración de API
- **Proxy/BFF**: `pronto-client` actúa como BFF. Las peticiones a la lógica de negocio deben pasar por el proxy hacia `pronto-api`.
- **Assets**: Todas las imágenes y estilos deben servirse desde `pronto-static`. No usar assets locales.

---

## 🔄 Flujos de Servicio (Service Flows)

1. **Flujo de Pedido**:
   Scan QR -> Browser -> Ver Menú -> Armar Carrito -> Checkout (Confirmar Mesa) -> Enviar Pedido -> Esperar Aceptación (Status: NEW -> QUEUED).
2. **Flujo de Pago Digital**:
   Ver Cuenta -> Seleccionar Stripe -> Ingresar Datos -> Procesar -> Confirmación -> Sesión Cerrada Automáticamente.
3. **Flujo de Llamada al Mesero**:
   Click "Llamar Mesero" -> Seleccionar Motivo -> Enviar -> Notificación enviada a `waiter/api` -> Cliente recibe confirmación de "En camino".
