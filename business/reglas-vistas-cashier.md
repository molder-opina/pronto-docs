# Reglas de Negocio y Prompt Maestro: Vista del Cajero (Cashier Console)

## Contexto
Esta vista es utilizada por los cajeros del restaurante a través de `pronto-employees/cashier`. Su función principal es la gestión de cobros, cierre de cuentas y supervisión de las transacciones financieras del día.

---

## 🤖 Prompt Maestro para Desarrollo de Vista Cajero

"Actúa como un Ingeniero Senior especializado en Sistemas de Cobro y Transacciones Financieras de Pronto. Tu objetivo es asegurar que la consola del cajero sea precisa, segura y fácil de operar. Al trabajar en `pronto-employees/cashier`, debes:
1. Validar el aislamiento por scope (`active_scope == 'cashier'`) mediante `ScopeGuard`.
2. Asegurar que el cálculo de totales, impuestos y propinas sea exacto y consistente con `pronto-api`.
3. Implementar una interfaz clara para el manejo de efectivo, terminales Clip y pagos digitales (Stripe).
4. Garantizar que todas las mutaciones financieras (procesar pago, cerrar mesa) incluyan el header `X-CSRFToken`.
5. Prohibir el uso de `Flask.session` para almacenar datos de empleados; utilizar las cookies de JWT (`access_token_cashier`).
6. Manejar correctamente el historial de transacciones de la sesión para auditoría interna."

---

## 📋 Reglas de Negocio (Business Rules)

### 1. Gestión de Cuentas (Checkout & Settlement)
- **Totales y Descuentos**: El cajero es el único con capacidad de aplicar descuentos globales a una cuenta (si tiene el permiso asignado).
- **Propinas**: Debe poder registrar propinas pagadas en efectivo o mediante tarjeta por separado.
- **División de Cuentas (Split Bill)**: El cajero debe gestionar la división de cuentas por personas o productos si los clientes lo solicitan.

### 2. Métodos de Pago
- **Efectivo**: El cajero registra la cantidad recibida y el sistema calcula el cambio.
- **Clip (Terminal Física)**: El cajero procesa el pago externamente y confirma en el sistema la referencia de transacción.
- **Pagos Digitales (Stripe)**: El cajero puede ver si una mesa ya pagó digitalmente y solo debe proceder a cerrar la sesión.

### 3. Cierre de Sesión (Session Close)
- **Condición de Cierre**: Una `DiningSession` solo puede cerrarse si el balance es cero (total órdenes - total pagos = 0).
- **Emisión de Tickets**: Generación y re-impresión de tickets fiscales o de cortesía.
- **Facturación**: Integración con servicios de facturación (ej. Facturapi) para emitir CFDI si el cliente lo requiere.

---

## 🛠️ Reglas Técnicas y de Seguridad

### 1. Seguridad (Security)
- **ScopeGuard**: Todas las rutas bajo `/cashier/` deben validar que el JWT tenga el `active_scope: 'cashier'`.
- **Aislamiento Multi-Consola**: Las cookies de autenticación deben estar prefijadas como `access_token_cashier`.
- **RBAC**: Algunas acciones (ej. cancelar un pago ya procesado) pueden requerir nivel de Admin superior al de Cajero estándar.

### 2. Auditoría
- **Logs de Pago**: Cada transacción de pago debe registrar el `employee_id` del cajero que la procesó y el timestamp exacto.

---

## 🔄 Flujos de Servicio (Service Flows)

1. **Flujo de Cobro de Mesa**:
   Ver Mesa (Status: Occupied) -> Revisar Cuenta -> Recibir Pago (Cash/Clip) -> Registrar Transacción -> Verificar Balance Zero -> Cerrar Sesión -> Mesa disponible.
2. **Flujo de Facturación**:
   Pago Confirmado -> Cliente solicita factura -> Cajero ingresa datos fiscales -> Generar Factura -> Enviar por Correo/Imprimir XML-PDF.
3. **Flujo de Reembolso**:
   Cajero selecciona orden pagada -> Selecciona motivo -> Procesa reembolso parcial/total -> Actualiza balance de la sesión -> Registra en auditoría.
