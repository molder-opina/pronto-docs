# Plan de Migración a Arquitectura Multi-Contexto (Strict Scopes)

Este plan detalla la transformación de la aplicación monolítica actual a una arquitectura de 4 aplicaciones aisladas por contexto (`/waiter`, `/chef`, `/cashier`, `/admin`), eliminando la dependencia de roles granulares y forzando la seguridad por contexto.

## 1. Principios Rectores

1.  **Aislamiento Total:** Un mesero en `/waiter` NO carga vistas de cocina ni de admin.
2.  **Scope Único:** Una sesión tiene un solo `active_scope` a la vez.
3.  **Operación Descentralizada:** El Admin no tiene una "súper pantalla". Si quiere meserear, debe ir a `/waiter`.
4.  **Defensa en Profundidad:** Middleware `ScopeGuard` en todas las rutas.

---

## 2. Ejecución Faseada

### Fase 1: Infraestructura y Auth (✅ Completada)

- [x] Base de datos: Columna `allow_scopes` en `Employee`.
- [x] Base de datos: Migración de roles actuales a scopes.
- [x] Middleware: `ScopeGuard` implementado.
- [x] Login: Pantallas de login independientes (`/waiter/login`, etc.).
- [x] Rutas Base: Blueprints de autenticación registrados.

### Fase 2: Especialización de Vistas (Frontend) 🚧 EN PROGRESO

El objetivo es limpiar el HTML "espagueti" actual que tiene `if role == ...` y crear vistas dedicadas.

1.  **App Waiter (`/templates/waiter/`)**
    - Eliminar: Paneles de cocina, gráficas de ventas, configuración.
    - Mantener: Mapa de mesas, toma de comandas, lista de órdenes activas.
    - Acción: Limpiar `dashboard.html` de mesero.

2.  **App Chef (`/templates/chef/`)**
    - Eliminar: Mapa de mesas, cobros.
    - Mantener: KDS (Kitchen Display System), marcado de platos listos.
    - Acción: Limpiar `dashboard.html` de chef.

3.  **App Cashier (`/templates/cashier/`)**
    - Mantener: Lista de cuentas por cobrar, terminal de pago.
    - Acción: Limpiar `dashboard.html` de cajero.

4.  **App Admin (`/templates/admin/`)**
    - Eliminar: Operación en vivo (mesas, cocina).
    - Mantener: Links a las otras apps + Configuración (Usuarios, Menú, Sistema).
    - Acción: Crear un "Launcher Dashboard" que redirija a las apps operativas.

### Fase 3: Migración de Lógica (Backend)

Mover la lógica del "God Controller" (`dashboard.py` y `api/*.py`) a controladores específicos.

1.  **Rutas Waiter (`routes/waiter/`)**
    - `orders.py`: Crear, modificar, enviar órdenes.
    - `tables.py`: Ver estado de mesas.
2.  **Rutas Chef (`routes/chef/`)**
    - `kds.py`: API para obtener órdenes pendientes y cambiar estados.
3.  **Rutas Admin (`routes/admin/`)**
    - `menu.py`: Editor de productos.
    - `users.py`: Gestión de empleados y scopes.

### Fase 4: Navegación y UI Contextual

1.  **Sidebar Dinámico:**
    - Crear `sidebar_waiter.html`, `sidebar_chef.html`, etc.
    - El layout base debe cargar el sidebar según el `active_scope`.
2.  **Switch Scope:**
    - Permitir al usuario con múltiples scopes cambiar de app fácilmente (ej. botón en header "Ir a Cocina" si tiene permiso).

---

## 3. Próximos Pasos Inmediatos (Plan de Acción)

1.  **Limpieza de Dashboards HTML:** Editar los templates copiados para dejar solo lo necesario.
2.  **Route Splitting:** Crear los archivos `routes/<context>/dashboard.py` para renderizar estas vistas limpias con los datos correctos (sin cargar datos innecesarios).
3.  **Sidebar Split:** Separar la navegación.
