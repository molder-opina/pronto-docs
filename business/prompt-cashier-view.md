# Reglas Detalladas y Prompt Maestro: Vista del Cajero (Cashier)

## 🤖 Prompt Maestro
"Actúa como un Experto en Sistemas POS y Auditoría Financiera de Pronto. Tu objetivo es asegurar que la consola del cajero (`pronto-employees/cashier`) sea el punto de cierre perfecto de cada transacción. Debes garantizar:
1. **Precisión de Balance**: Validar que `total_orders == total_payments` antes de habilitar el botón de 'Cerrar Sesión'.
2. **Diversidad de Pago**: Soportar pagos mixtos (ej. parte en Cash, parte en Clip) mediante `POST /api/sessions/<id>/pay`.
3. **Gestión de Propinas**: Registrar propinas de forma independiente al subtotal del consumo para reportes de nómina.
4. **Seguridad Financiera**: Bloquear la edición de órdenes que ya tienen un pago parcial registrado, salvo por un usuario con permiso `admin`.
5. **Autenticación**: Inyectar `access_token_cashier` y validar el scope `cashier` en cada petición."

---

## 📋 Reglas de Negocio (Business Rules)

### 1. Cierre de Cuentas
- **Split Bills**: El cajero debe poder dividir una cuenta por items o por partes iguales mediante `/api/split-bills/sessions/<id>/create`.
- **Descuentos**: Solo el cajero (con permiso explícito) puede aplicar `discount_codes` o cortesías a una sesión abierta.
- **Ticketing**: Al cerrar la sesión, disparar automáticamente la generación del PDF mediante `/api/sessions/<id>/ticket.pdf`.

### 2. Flujos de Cobro
- **Efectivo**: Calcular automáticamente el cambio sugerido. Registrar el `cash_received`.
- **Clip**: Solicitar y guardar la referencia de transacción de la terminal. No permitir cerrar sin referencia válida.
- **Stripe**: Verificar el estado del `payment_intent` en `pronto-api` antes de marcar como pagado.

---

## 🛠️ Reglas Técnicas y de Flujo

### 1. Frontend (Cashier SPA)
- **Modo Offline**: Cachear los items del menú localmente para permitir seguir operando ante micro-cortes de red.
- **Auditoría**: Mostrar un historial de "Eventos de Caja" (ej. apertura de cajón, cancelación de pago) en la vista de reportes del día.

### 2. Integración de API
- **Proxy**: Todas las peticiones deben usar el prefijo `/cashier/api/`.
- **Facturación**: Integrar con el flujo de `/api/client/invoices/request` si el cliente solicita CFDI al momento del pago.
