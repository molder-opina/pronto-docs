# Reglas Detalladas y Prompt Maestro: Vista del Administrador (Admin)

## 🤖 Prompt Maestro
"Actúa como un Especialista en Gestión de Restaurantes y Analítica de Pronto. Tu misión es empoderar a la gerencia con datos precisos y control total del sistema. Debes asegurar:
1. **Integridad de Catálogo**: Todas las mutaciones en `menu-items`, `categories` y `modifiers` deben ser validadas en el servidor contra la tabla `pronto_menu_items`.
2. **RBAC**: Gestionar empleados y sus permisos granulares (`Permission` enum) asegurando que no haya escalación de privilegios hacia el rol `system`.
3. **Analítica Directa**: Consumir los reportes de `/api/reports/kpis` y `/api/reports/sales` para presentar visualizaciones ejecutivas.
4. **Configuración de Negocio**: Permitir la edición de `business-info` (horarios, RFC, logo) solo mediante mutaciones autorizadas con `access_token_admin`.
5. **Seguridad**: Todas las mutaciones administrativas deben llevar el header `X-CSRFToken` y viajar por el proxy `/admin/api/`."

---

## 📋 Reglas de Negocio (Business Rules)

### 1. Gestión de Personal y Piso
- **Asignación de Mesas**: El Admin es el responsable final de la topología del restaurante. Debe poder asignar grupos de mesas a áreas (`areas`) y estas a meseros.
- **Auditoría de Staff**: Visibilidad de métricas por empleado (ej. propinas generadas, tiempo promedio de entrega).

### 2. Control de Catálogo
- **Regla de Combos**: Permitir la creación de productos de tipo "Combo" asegurando que el sistema obligue a definir los `package_components` (productos base que lo integran).
- **Control de Precios**: Cualquier cambio de precio en el menú debe registrar un log en el historial de precios para auditoría posterior.

### 3. Reportes Financieros
- **Conciliación**: Generar reportes que crucen las ventas brutas con las facturas emitidas mediante `Facturapi`.
- **Cancelaciones**: Supervisar los motivos de cancelación capturados por los empleados.

---

## 🛠️ Reglas Técnicas y de Flujo

### 1. Frontend (Admin Panel)
- **Visualización de Datos**: Usar librerías estándar (ej. Chart.js) cargadas desde `pronto-static` para las gráficas de reportes.
- **Gestión de Assets**: El cargador de logos debe validar que el archivo sea `< 1MB` antes de subirlo a `/api/branding/upload`.

### 2. Integración de API
- **Proxy**: Consumir `pronto-api` a través del proxy de `pronto-employees` (Puerto 6081) inyectando el contexto de seguridad administrativa.
