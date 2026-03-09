# Reglas Detalladas y Prompt Maestro: Vista del Cliente (Customer)

## 🤖 Prompt Maestro
"Actúa como un Experto en UX y Desarrollador Senior de `pronto-client`. Tu misión es implementar una experiencia de usuario fluida y segura para el comensal. Debes cumplir con:
1. **Identidad Técnica**: Inyectar el header `X-PRONTO-CUSTOMER-REF` en cada petición mutante.
2. **Contexto de Sesión**: Solo permitir operaciones si existe un `table_id` verificado y una `dining_session_id` abierta.
3. **Flujo de Pago**: Implementar el polling de pago cada 3 segundos una vez solicitada la cuenta. Mostrar overlay de espera.
4. **Validación de Items**: Antes de enviar una orden, validar que los modificadores requeridos (min_selection > 0) estén seleccionados.
5. **Combos**: Aplicar la regla de herencia; si el usuario personaliza un combo, los cambios deben trazarse a los productos base correspondientes.
6. **Seguridad**: Nunca almacenar JWT de empleados en esta vista. Usar `flask.session` solo para claves de cliente permitidas."

---

## 📋 Reglas de Negocio (Business Rules)

### 1. Órdenes y Carrito
- **Regla de Existencia**: No se puede crear una orden con 0 productos.
- **Regla de Mesa**: Si el `table_id` de la sesión técnica no coincide con el enviado en el request, rechazar con 400.
- **Regla de Cancelación**: El cliente solo puede cancelar órdenes en estado `NEW`. Una vez en `QUEUED` o superior, solo un empleado puede cancelarla.

### 2. Personalización (Modificadores)
- **Selección Mínima/Máxima**: Validar que `count(seleccionados)` esté entre `min_selection` y `max_selection` definido en el grupo.
- **Precio Dinámico**: El total del item debe actualizarse en tiempo real sumando los `price_adjustment` de los modificadores seleccionados.

### 3. Sesiones y Checkout
- **Apertura Controlada**: `POST /api/sessions/open` requiere un `table_id` de tipo UUID.
- **Balance Zero**: El cliente puede ver el ticket en cualquier momento, pero el botón de "Cerrar Mesa" solo se activa cuando el balance es 0 (tras confirmación de pago).

---

## 🛠️ Reglas Técnicas y de Flujo

### 1. Frontend (TypeScript/CSS)
- **Arquitectura**: Seguir el patrón de Managers (`CartManager`, `ModalManager`, `OrderTracker`).
- **Persistencia**: Carrito guardado en `localStorage` (`pronto-cart`). Limpiar solo tras éxito en `submitCheckout`.
- **Diseño**: Usar exclusivamente clases BEM definidas en `menu-filters.css` y `menu-checkout.css`.

### 2. Integración de API
- **BFF**: Consumir los endpoints de `/api/*` del servicio `pronto-client` (Puerto 6080).
- **CSRF**: Obtener el token de `/api/client-auth/csrf` antes de cualquier `POST`.
