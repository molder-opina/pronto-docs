# Reglas de Negocio y Prompt Maestro: Vista del Administrador (Admin Console)

## Contexto
Esta vista es utilizada por los gerentes y administradores del restaurante a través de `pronto-employees/admin`. Sus funciones cubren la gestión de inventarios, personal, reportes financieros y configuración de negocio.

---

## 🤖 Prompt Maestro para Desarrollo de Vista Administrador

"Actúa como un Ingeniero Senior especializado en el Panel de Administración y Gestión de Negocios de Pronto. Tu objetivo es asegurar que la consola administrativa sea potente, intuitiva y extremadamente segura. Al trabajar en `pronto-employees/admin`, debes:
1. Validar el aislamiento por scope (`active_scope == 'admin'`) mediante `ScopeGuard`.
2. Asegurar que los procesos de creación y edición (empleados, menú, precios) sean atómicos y validados en backend.
3. Implementar vistas de reportes y analítica basadas en los datos consolidados de `pronto-api`.
4. Garantizar que todas las mutaciones de configuración y datos incluyan el header `X-CSRFToken`.
5. Prohibir el uso de `Flask.session` para almacenar datos de empleados; utilizar las cookies de JWT (`access_token_admin`).
6. Asegurar que el Administrador tenga visibilidad transversal del estado del restaurante pero respetando los límites operativos."

---

## 📋 Reglas de Negocio (Business Rules)

### 1. Gestión de Catálogo (Menu Management)
- **Categorías e Items**: Crear, editar y eliminar categorías del menú y productos. (Atención: no borrar productos con órdenes activas).
- **Precios e Impuestos**: Definir precios y el porcentaje de impuesto (IVA) global o por producto.
- **Modifiers & Combos**: Gestionar grupos de modificadores y la composición de los combos/paquetes.

### 2. Gestión de Personal (Employee Management)
- **Roles y Permisos**: Crear empleados, asignar roles canónicos (`waiter`, `chef`, `cashier`, `admin`, `system`) y gestionar sus permisos granulares.
- **Asignación de Mesas**: Definir qué meseros atienden qué mesas o áreas del restaurante.

### 3. Configuración de Negocio (Business Config)
- **Datos de Empresa**: Nombre, dirección, logo (vía `pronto-static`), RFC.
- **Horarios**: Configurar horarios de apertura y cierre por día de la semana.
- **Políticas de Venta**: Configurar reglas como el porcentaje de propina sugerida y métodos de pago aceptados.

### 4. Reportes y Auditoría
- **Ventas**: Generar reportes de ventas por día, turno, mesero o categoría de producto.
- **Cancelaciones**: Revisar el historial de órdenes canceladas con sus respectivos motivos y actores involucrados.

---

## 🛠️ Reglas Técnicas y de Seguridad

### 1. Seguridad (Security)
- **ScopeGuard**: Todas las rutas bajo `/admin/` deben validar que el JWT tenga el `active_scope: 'admin'`.
- **Aislamiento Multi-Consola**: Las cookies de autenticación deben estar prefijadas como `access_token_admin`.
- **RBAC Extendido**: El administrador tiene acceso a casi todas las capacidades del sistema, pero el `active_scope` rige su interacción con la UI.

### 2. Integración
- **Assets de Branding**: El logo cargado por el Administrador debe procesarse y almacenarse en `pronto-static/src/static_content/assets/pronto/branding/`.

---

## 🔄 Flujos de Servicio (Service Flows)

1. **Flujo de Alta de Nuevo Plato**:
   Admin entra a Menú -> Crear Item -> Subir Imagen -> Definir Precio -> Asignar Categoría -> Asignar Modificadores -> Guardar -> Disponible en Cliente y Mesero.
2. **Flujo de Reporte Mensual**:
   Seleccionar Rango de Fechas -> Seleccionar Tipo de Reporte (Ventas/Tips) -> Generar -> Visualizar Gráficas -> Exportar a PDF/Excel.
3. **Flujo de Re-asignación de Mesas**:
   Admin entra a Mesas -> Seleccionar Area -> Ver Meseros Disponibles -> Drag & Drop Mesas a Meseros -> Guardar -> Actualización en tiempo real para meseros.
