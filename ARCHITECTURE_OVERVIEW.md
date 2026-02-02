
# Arquitectura del Sistema Pronto

Documentación técnica general de la plataforma de gestión de restaurantes "Pronto".

## Visión General
Pronto es una plataforma integral que gestiona el flujo de pedidos de un restaurante, desde la toma de la orden por el cliente o mesero, hasta la preparación en cocina y el cobro.

El sistema está construido como una arquitectura de microservicios contenerizados (Docker), separando la lógica de empleados (`pronto_employees`) de la experiencia del cliente (`pronto_clients`), compartiendo un núcleo común (`shared`).

## Estructura del Proyecto

### 1. `pronto_employees/` (Backend & Frontend Staff)
Panel administrativo y operativo para el personal.
- **Tecnología**: Flask (Python), Jinja2 (Templates), TypeScript (Frontend Interactivo).
- **Módulos Principales**:
  - `routes/auth.py`: Autenticación y Control de Acceso (RBAC).
  - `routes/dashboard.py`: Vistas principales (SPA-like navigation).
  - `routes/api/`: API REST para operaciones dinámicas.
  - `static/js/src/`: Lógica de cliente (WebSockets, UI Managers).

### 2. `pronto_clients/` (Frontend Cliente)
Aplicación para comensales (QR Menu & Ordering).
- **Tecnología**: Flask, TypeScript.
- **Funcionalidad**: Ver menú, carrito de compras, checkout, estado de orden en tiempo real.

### 3. `shared/` (Core Library)
Código compartido entre servicios para garantizar consistencia.
- **Modelos (`models.py`)**: Definiciones SQLAlchemy (ORM) de la base de datos (Orders, Users, Menu items).
- **Base de Datos (`db.py`)**: Gestión de conexiones y sesiones PostgreSQL.
- **Servicios (`services/`)**: Lógica de negocio reutilizable (MenuService, OrderService).
- **Seguridad**: `security.py` (Hashing), `audit_middleware.py` (Logging Estandarizado).

### 4. `api_gateway/` (Puerto 6082)
Punto de entrada unificado (Proxy Reverso) que enruta peticiones a los servicios correspondientes y maneja autenticación centralizada si aplica.

## Componentes Clave

### Base de Datos (PostgreSQL)
Esquema relacional que almacena:
- `users`: Empleados y Clientes.
- `menu_items`: Productos, categorías y precios.
- `orders`: Transacciones y estado del flujo.
- `modifiers`: Personalizaciones de productos.

### Realtime (WebSockets)
Gestión de eventos en tiempo real para:
- Notificar a cocina de nuevas órdenes.
- Notificar a meseros de platos listos.
- Actualizar estado de orden al cliente.

### Sistema de Archivos (Assets)
Contenedor `pronto-static` (Nginx) sirve imágenes y recursos estáticos optimizados.
- Ubicación: `/static_content/assets/`
- Mapeo Docker: Volumen compartido o copia en build time.

## Flujos Críticos

### 1. Creación de Orden
`Client API` -> `OrderService` -> `DB Insert` -> `WebSocket Event` -> `Kitchen Display`.

### 2. Autenticación y Permisos
- Decoradores `@role_required` validan sesión y rol.
- Middleware de Auditoría registra acceso (User|Action|Type...).
- Manejo de Errores 403 redirige a `/authorization-error`.

## Estándares de Desarrollo
- **Logging**: Formato PIPE unificado (Ver `docs/LOGGING_STANDARD.md`).
- **Manejo de Errores**: Catálogo centralizado en `/error-catalog`.
- **Frontend**: TypeScript compilado con Vite. Comunicación API vía `authenticatedFetch`.
