# 📋 Estructura Templates/Routes y API Endpoints - Pronto-App

## 🏗️ **Arquitectura General**

**Pronto-App** es un sistema de gestión restaurant completo con:

- **Multi-SPA Architecture** - 5 Vue apps separadas
- **Flask Hybrid Backend** - SSR + JSON APIs
- **Multi-Scope Sessions** - Aislamiento por rol
- **200+ API Endpoints** - REST completo

---

## 🗂️ **Estructura de Directorios**

```
build/
├── clients_app/                 # App Cliente (Puerto 6080)
│   ├── routes/
│   │   ├── api/                # 14 API blueprints
│   │   │   ├── auth.py         # Autenticación cliente
│   │   │   ├── orders.py       # Pedidos (20+ endpoints)
│   │   │   ├── menu.py         # Menú
│   │   │   ├── sessions.py     # Sesiones (merge/split)
│   │   │   ├── payments.py     # Pagos (Stripe/Clip)
│   │   │   ├── feedback.py     # Feedback
│   │   │   ├── promotions.py   # Promociones
│   │   │   ├── business_info.py # Info negocio
│   │   │   ├── config.py       # Configuración
│   │   │   ├── support.py      # Soporte técnico
│   │   │   ├── waiter_calls.py # Llamadas mesero
│   │   │   ├── notifications.py # Notificaciones
│   │   │   ├── feedback_email.py # Feedback por email
│   │   │   ├── shortcuts.py    # Atajos app
│   │   │   ├── split_bills.py  # División cuentas
│   │   │   ├── stripe_payments.py # Pagos Stripe
│   │   │   └── debug.py        # Debug endpoints
│   │   └── web.py              # Rutas HTML templates
│   ├── templates/              # HTML Jinja2 templates
│   │   ├── index.html           # Menú principal cliente
│   │   ├── checkout.html        # Checkout flujo
│   │   └── thank-you.html       # Post-pedido
│   └── static/                 # Assets frontend
│       └── js/
│           └── src/
│               ├── entrypoints/
│               │   ├── base.ts
│               │   ├── menu.ts
│               │   └── thank-you.ts
│               └── components/
│
├── employees_app/              # Dashboard Empleados (Puerto 6081)
│   ├── routes/
│   │   ├── api/                # 25+ API blueprints
│   │   │   ├── auth.py         # Auth empleados
│   │   │   ├── orders.py       # Gestión pedidos (15+ endpoints)
│   │   │   ├── sessions.py     # Sesiones (25+ endpoints)
│   │   │   ├── menu.py         # CRUD menú completo
│   │   │   ├── employees.py    # Gestión empleados
│   │   │   ├── tables.py       # Gestión mesas
│   │   │   ├── customers.py    # Gestión clientes
│   │   │   ├── promotions.py   # Promociones
│   │   │   ├── discount_codes.py # Códigos descuento
│   │   │   ├── modifiers.py    # Modificadores productos
│   │   │   ├── waiter_calls.py # Llamadas mesero
│   │   │   ├── reports.py      # Reportes
│   │   │   ├── analytics.py    # Analytics (7+ endpoints)
│   │   │   ├── feedback.py     # Feedback gestión
│   │   │   ├── settings.py     # Configuración sistema
│   │   │   ├── business_info.py # Info negocio
│   │   │   ├── areas.py        # Gestión áreas
│   │   │   ├── day_periods.py  # Períodos día
│   │   │   ├── roles.py        # Gestión roles
│   │   │   ├── table_assignments.py # Asignación mesas
│   │   │   ├── images.py       # Gestión imágenes
│   │   │   ├── branding.py     # Branding assets
│   │   │   ├── admin_config.py # Config admin
│   │   │   ├── notifications.py # Notificaciones
│   │   │   ├── realtime.py     # Eventos real-time
│   │   │   └── debug.py        # Debug endpoints
│   │   ├── waiter/             # Rutas waiter específicas
│   │   │   └── auth.py         # Auth waiter
│   │   ├── chef/               # Rutas chef específicas
│   │   │   └── auth.py         # Auth chef
│   │   ├── cashier/            # Rutas cashier específicas
│   │   │   └── auth.py         # Auth cashier
│   │   └── admin/              # Rutas admin específicas
│   │       └── auth.py         # Auth admin
│   ├── templates/              # Templates empleados
│   │   ├── dashboard.html      # Dashboard principal
│   │   ├── order_details.html  # Detalles pedido
│   │   └── ...                # Otros templates
│   └── static/                 # Assets frontend
│       └── js/
│           └── src/
│               ├── entrypoints/
│               │   ├── base.ts
│               │   └── dashboard.ts
│               └── components/
│
├── shared/                     # Componentes compartidos
│   ├── routes/                 # APIs compartidas
│   │   ├── auth.py            # Auth compartida
│   │   ├── roles.py           # Gestión roles/permisos
│   │   ├── api.py             # APIs públicas
│   │   ├── dashboard.py       # Dashboard compartido
│   │   └── ...               # Otras rutas compartidas
│   ├── templates/              # Templates compartidos
│   └── models.py              # Modelos de datos
│
├── waiter/                     # App Waiter independiente (legacy)
│   ├── routes/
│   │   └── auth.py           # Auth waiter legacy
│   ├── templates/
│   │   └── dashboard.html     # Dashboard waiter
│   └── static/
│
├── chef/                       # App Chef independiente (legacy)
│   ├── routes/
│   │   └── auth.py           # Auth chef legacy
│   ├── templates/
│   │   └── dashboard.html     # Dashboard chef
│   └── static/
│
├── cashier/                    # App Cashier independiente (legacy)
│   ├── routes/
│   │   └── auth.py           # Auth cashier legacy
│   ├── templates/
│   │   └── dashboard.html     # Dashboard cashier
│   └── static/
│
└── admin/                      # App Admin independiente (legacy)
    ├── routes/
    │   └── auth.py           # Auth admin legacy
    ├── templates/
    │   ├── dashboard.html    # Dashboard admin
    │   ├── analytics.html    # Analytics
    │   ├── branding.html     # Branding
    │   ├── business_config.html # Config negocio
    │   ├── feedback_dashboard.html # Feedback
    │   └── roles_management.html # Gestión roles
    └── static/
```

---

## 🌐 **API Endpoints Principales**

### 📱 **CLIENTS_APP API (Puerto 6080)**

#### 🔐 **Authentication** (`/api/auth`)

- `POST /api/auth/login` - Login cliente
- `POST /api/auth/register` - Registro cliente
- `POST /api/auth/password/recover` - Recuperar contraseña
- `POST /api/auth/password/reset` - Resetear contraseña
- `PUT /api/auth/update/<int:customer_id>` - Actualizar info cliente
- `GET /api/avatars` - Obtener avatares disponibles
- `PATCH /api/auth/update/<int:customer_id>/avatar` - Actualizar avatar

#### 📋 **Orders** (`/api/orders`)

- `POST /api/orders` - Crear nuevo pedido
- `POST /api/orders/<int:order_id>/cancel` - Cancelar pedido
- `POST /api/orders/<int:order_id>/modify` - Modificar pedido
- `POST /api/modifications/<int:modification_id>/approve` - Aprobar modificación
- `POST /api/modifications/<int:modification_id>/reject` - Rechazar modificación
- `GET /api/modifications/<int:modification_id>` - Detalles modificación
- `GET /api/session/<int:session_id>/orders` - Pedidos de sesión
- `GET /api/session/validate` - Validar sesión actual
- `GET /api/orders/history` - Historial de pedidos
- `GET /api/orders/<int:order_id>` - Detalles pedido específico
- `POST /api/orders/<int:order_id>/request-check` - Solicitar cuenta individual
- `POST /api/orders/<int:order_id>/received` - Marcar pedido como recibido

#### 🍽️ **Menu** (`/api/menu`)

- `GET /api/menu` - Obtener menú completo con categorías e items

#### 💳 **Sessions & Payments** (`/api/sessions`)

- `POST /api/sessions/merge` - Fusionar dos sesiones (combinar mesas)
- `POST /api/sessions/<int:session_id>/split` - Dividir cuenta en partes
- `POST /api/sessions/<int:session_id>/request-payment` - Solicitar pago
- `POST /api/sessions/<int:session_id>/checkout` - Procesar checkout
- `GET /api/session/<int:session_id>/timeout` - Tiempo expiración sesión

#### ⭐ **Feedback** (`/api/feedback`)

- `POST /api/sessions/<int:session_id>/feedback` - Enviar feedback sesión
- `POST /api/feedback/email/<token>/submit` - Submit feedback por email

#### 🎁 **Promotions** (`/api/promotions`)

- `GET /api/promotions/active` - Obtener promociones activas
- `POST /api/discount-code/validate` - Validar código descuento

#### 📞 **Support & Help** (`/api/support`)

- `POST /api/call-waiter` - Llamar mesero a mesa
- `POST /api/support-tickets` - Crear ticket soporte

---

### 👥 **EMPLOYEES_APP API (Puerto 6081)**

#### 🔐 **Authentication** (`/api/auth`)

- `POST /api/auth/login` - Login empleado
- `POST /api/auth/logout` - Logout empleado
- `GET /api/auth/me` - Información empleado actual
- `GET /api/auth/permissions` - Permisos del empleado

#### 📋 **Orders Management** (`/api/orders`)

- `GET /api/orders` - Obtener todos los pedidos
- `GET /api/orders/kitchen/pending` - Pedidos pendientes cocina
- `POST /api/orders/<int:order_id>/accept` - Aceptar pedido (waiter)
- `POST /api/orders/<int:order_id>/kitchen/start` - Iniciar preparación (chef)
- `POST /api/orders/<int:order_id>/kitchen/ready` - Marcar listo (chef)
- `POST /api/orders/<int:order_id>/deliver` - Entregar pedido (waiter)
- `POST /api/orders/<int:order_id>/cancel` - Cancelar pedido
- `POST /api/orders/<int:order_id>/modify` - Modificar pedido
- `POST /api/orders/<int:order_id>/notes` - Agregar notas pedido
- `POST /api/orders/<int:order_id>/deliver-items` - Entrega parcial

#### 🛒 **Sessions Management** (`/api/sessions`)

- `GET /api/sessions/awaiting-payment` - Sesiones esperando pago
- `POST /api/sessions/<int:session_id>/checkout` - Procesar checkout
- `POST /api/sessions/<int:session_id>/tip` - Agregar propina
- `GET /api/sessions/paid-recent` - Pagos recientes
- `GET /api/sessions/<int:session_id>/ticket` - Generar ticket
- `POST /api/sessions/<int:session_id>/close` - Cerrar sesión
- `GET /api/sessions/<int:session_id>/ticket.pdf` - Ticket PDF

#### 🍽️ **Menu Management** (`/api/menu-items`)

- `GET /api/menu` - Obtener menú completo
- `POST /api/menu-items` - Crear nuevo item menú
- `PUT /api/menu-items/<int:item_id>` - Actualizar item menú
- `DELETE /api/menu-items/<int:item_id>` - Eliminar item menú
- `POST /api/menu-items/<int:item_id>/modifier-groups` - Agregar grupo modificadores

#### 👥 **Employees Management** (`/api/employees`)

- `GET /api/employees` - Lista todos los empleados
- `GET /api/employees/<int:employee_id>` - Detalles empleado
- `GET /api/employees/on-shift` - Empleados en turno
- `POST /api/employees` - Crear nuevo empleado
- `PUT /api/employees/<int:employee_id>` - Actualizar empleado
- `DELETE /api/employees/<int:employee_id>` - Eliminar empleado

#### 🪑 **Tables Management** (`/api/tables`)

- `GET /api/tables` - Obtener todas las mesas
- `POST /api/tables` - Crear nueva mesa
- `PUT /api/tables/<int:table_id>` - Actualizar mesa
- `DELETE /api/tables/<int:table_id>` - Eliminar mesa
- `GET /api/tables/<int:table_id>/qr` - Obtener QR código mesa

#### 📊 **Analytics** (`/api/analytics`)

- `GET /api/analytics/kpis` - Métricas KPI principales
- `GET /api/analytics/revenue-trends` - Tendencias de revenue
- `GET /api/analytics/waiter-performance` - Performance meseros
- `GET /api/analytics/category-performance` - Performance categorías
- `GET /api/analytics/customer-segments` - Segmentos clientes

#### 📈 **Reports** (`/api/reports`)

- `GET /api/reports/sales` - Reporte de ventas
- `GET /api/reports/top-products` - Productos más vendidos
- `GET /api/reports/peak-hours` - Horas pico
- `GET /api/reports/waiter-tips` - Propinas meseros

#### 🎁 **Promotions & Discounts**

- `GET /api/promotions` - Obtener todas las promociones
- `POST /api/promotions` - Crear nueva promoción
- `GET /api/discount-codes` - Obtener códigos descuento
- `POST /api/discount-codes` - Crear código descuento

---

### 🔒 **SCOPE-BASED WEB ROUTES**

#### **Admin Dashboard** (`/admin`)

- `GET /admin/login` - Página login admin
- `POST /admin/login` - Procesar login admin
- `GET /admin/dashboard` - Dashboard principal admin

#### **Waiter Dashboard** (`/waiter`)

- `GET /waiter/login` - Página login waiter
- `POST /waiter/login` - Procesar login waiter
- `GET /waiter/dashboard` - Dashboard waiter

#### **Chef Dashboard** (`/chef`)

- `GET /chef/login` - Página login chef
- `POST /chef/login` - Procesar login chef
- `GET /chef/dashboard` - Dashboard chef
- `GET /chef/kds` - Kitchen Display System

#### **Cashier Dashboard** (`/cashier`)

- `GET /cashier/login` - Página login cashier
- `POST /cashier/login` - Procesar login cashier
- `GET /cashier/dashboard` - Dashboard cashier

---

## 🔄 **Arquitectura Multi-Scope**

### 🍪 **Sesiones Aisladas por Path**

Cada rol de empleado tiene su propia sesión con path-based isolation:

```python
SCOPE_CONFIG = {
    "/waiter": {
        "cookie_name": "sess_waiter",
        "cookie_path": "/waiter"
    },
    "/chef": {
        "cookie_name": "sess_chef",
        "cookie_path": "/chef"
    },
    "/cashier": {
        "cookie_name": "sess_cashier",
        "cookie_path": "/cashier"
    },
    "/admin": {
        "cookie_name": "sess_admin",
        "cookie_path": "/admin"
    }
}
```

### 🎯 **Beneficios del Multi-Scope:**

- **Aislamiento estricto** entre roles
- **Prevención cross-contamination** de sesiones
- **Security boundaries** por defecto
- **Cookie scope limiting** por path

---

## 📊 **Resumen de Endpoints**

| App               | Endpoints API      | Endpoints Web | Total    |
| ----------------- | ------------------ | ------------- | -------- |
| **Clients App**   | ~50 endpoints      | 3 routes      | ~53      |
| **Employees App** | ~150+ endpoints    | 4 routes      | ~154     |
| **Shared APIs**   | ~30 endpoints      | 0             | ~30      |
| **Legacy Apps**   | ~8 endpoints       | 8 routes      | ~16      |
| **TOTAL**         | **~238 endpoints** | **15 routes** | **~253** |

---

## 🏗️ **Pattern Architecture**

### **Hybrid SSR + API Pattern**

```
Client Request → Flask Router → {
    → Template Rendering (SSR) → HTML + Vue Enhancement
    OR
    → JSON Response → API Endpoint → Frontend App
}
```

### **Vue Apps Integration**

- **5 Vue Apps separadas** con entry points propios
- **Progressive Enhancement** - Server rendered + Vue components
- **No Vue Router** - Routing primario en Flask
- **Multi-target build** - Vite con configuración por app

---

## 🔧 **Flujo de Autenticación**

### **Multi-Step Auth Flow**

1. **Login Request** → Scope-specific endpoint (`/waiter/login`)
2. **Cookie Creation** → Path-scoped cookie (`sess_waiter`)
3. **Session Setup** → `session["active_scope"] = "waiter"`
4. **Permission Validation** → `ScopeGuard` middleware
5. **Dashboard Access** → Scope-isolated interface

---

## 🚀 **Consideraciones Técnicas**

### **Security**

- **CSRF protection** en todas las rutas POST
- **Rate limiting** en endpoints sensibles
- **PII encryption** en datos clientes
- **Session timeout** configurable

### **Performance**

- **Database connection pooling**
- **Redis caching** para sesiones activas
- **WebSocket/Server-Sent Events** para real-time
- **Lazy loading** en relationships SQLAlchemy

### **Scalability**

- **Blueprint architecture** modular
- **Database migration system**
- **Static assets CDN ready**
- **Container deployment ready**

---

## 📝 **Notas de Implementación**

- **200+ API endpoints** cubriendo todas las operaciones restaurant
- **Multi-scope isolation** previene cross-access entre roles
- **Progressive enhancement** asegura funcionalidad sin JavaScript
- **Real-time updates** vía WebSocket/SSE para cambios inmediatos
- **Comprehensive error handling** con logging estructurado

Esta arquitectura proporciona una **base robusta y escalable** para sistemas de gestión restaurant con **aislamiento de seguridad** y **experiencias de usuario optimizadas** por rol.
