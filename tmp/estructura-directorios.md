# 🗂️ Estructura de Directorios - Pronto-App

## 📁 **Directorio Raíz**

```
pronto-app/
├── 📁 build/                    # Código fuente principal
├── 📁 config/                   # Configuración deployment
├── 📁 migrations/               # Migraciones database
├── 📁 scripts/                  # Scripts utilitarios
├── 📁 static_content/           # Assets estáticos compartidos
├── 📁 tests/                    # Tests pytest
├── 📁 bin/                      # Scripts Linux/producción
├── 📁 docker-compose.*.yml      # Configuración Docker
├── 📄 package.json              # Configuración frontend/Vite
├── 📄 pyproject.toml            # Configuración Python/Ruff
├── 📄 Makefile                  # Comandos build/test
└── 📄 AGENTS.md                 # Guía desarrollo
```

---

## 🏗️ **Estructura Principal (`build/`)**

### 📱 **Clients App (`build/pronto_clients/`)**

```
pronto_clients/                      # 🌐 Puerto 6080
├── 📁 routes/
│   ├── 📁 api/                  # 🔄 14 API blueprints
│   │   ├── 🔐 auth.py           # Autenticación cliente
│   │   ├── 📋 orders.py         # Gestión pedidos (20+ endpoints)
│   │   ├── 🍽️ menu.py           # Catálogo menú
│   │   ├── 🛒 sessions.py       # Sesiones & split/merge
│   │   ├── 💳 payments.py       # Stripe/Clip integration
│   │   ├── ⭐ feedback.py       # Sistema feedback
│   │   ├── 🎁 promotions.py     # Promociones activas
│   │   ├── 📞 support.py        # Soporte técnico
│   │   ├── 👨‍🍳 waiter_calls.py  # Llamadas mesero
│   │   ├── 🔔 notifications.py   # Sistema notificaciones
│   │   ├── 📧 feedback_email.py # Feedback email
│   │   ├── ⚡ shortcuts.py      # Atajos aplicación
│   │   ├── 💰 split_bills.py    # División cuentas
│   │   ├── 🎯 stripe_payments.py # Pagos Stripe
│   │   └── 🐛 debug.py          # Debug endpoints
│   └── 🌐 web.py                # Rutas HTML templates
├── 📁 templates/                # 🎨 Jinja2 templates
│   ├── 📄 index.html            # Menú principal cliente
│   ├── 📄 checkout.html         # Flujo checkout
│   └── 📄 thank-you.html        # Post-pedido gracias
├── 📁 services/                 # 🧠 Business logic
│   ├── 🧾 order_service.py     # Lógica pedidos
│   └── 🍽️ menu_service.py       # Lógica menú
├── 📁 static/                   # 🎯 Assets frontend
│   ├── 📁 css/                  # Estilos
│   ├── 📁 js/                   # JavaScript/Vue
│   │   └── 📁 src/
│   │       ├── 📁 entrypoints/  # 🚀 3 entry points
│   │       │   ├── 📄 base.ts
│   │       │   ├── 📄 menu.ts
│   │       │   └── 📄 thank-you.ts
│   │       └── 📁 components/   # 🧩 Vue components
│   └── 📁 assets/               # Imágenes productos
├── 📄 app.py                    # 🏗️ Flask app factory
├── 📄 requirements.txt          # 📦 Dependencies Python
├── 📄 Dockerfile               # 🐳 Container config
└── 📄 __init__.py              # 📦 Module init
```

### 👥 **Employees App (`build/pronto_employees/`)**

```
pronto_employees/                   # 🌐 Puerto 6081
├── 📁 routes/
│   ├── 📁 api/                  # 🔄 25+ API blueprints
│   │   ├── 🔐 auth.py           # Autenticación empleados
│   │   ├── 📋 orders.py         # Gestión pedidos (15+ endpoints)
│   │   ├── 🛒 sessions.py       # Sesiones (25+ endpoints)
│   │   ├── 🍽️ menu.py           # CRUD menú completo
│   │   ├── 👥 employees.py      # Gestión empleados
│   │   ├── 🪑 tables.py         # Gestión mesas
│   │   ├── 🧑‍💼 customers.py      # Gestión clientes
│   │   ├── 🎁 promotions.py     # Promociones
│   │   ├── 🏷️ discount_codes.py # Códigos descuento
│   │   ├── ⚙️ modifiers.py       # Modificadores productos
│   │   ├── 👨‍🍳 waiter_calls.py # Llamadas mesero
│   │   ├── 📊 reports.py        # Reportes
│   │   ├── 📈 analytics.py      # Analytics (7+ endpoints)
│   │   ├── ⭐ feedback.py       # Feedback gestión
│   │   ├── ⚙️ settings.py       # Configuración sistema
│   │   ├── 🏢 business_info.py   # Info negocio
│   │   ├── 🗺️ areas.py          # Gestión áreas
│   │   ├── 🕐 day_periods.py     # Períodos día
│   │   ├── 👑 roles.py           # Gestión roles
│   │   ├── 🪑 table_assignments.py # Asignación mesas
│   │   ├── 🖼️ images.py         # Gestión imágenes
│   │   ├── 🎨 branding.py       # Branding assets
│   │   ├── 🛠️ admin_config.py   # Config admin
│   │   ├── 🔔 notifications.py  # Notificaciones
│   │   ├── ⚡ realtime.py       # Eventos real-time
│   │   └── 🐛 debug.py          # Debug endpoints
│   ├── 📁 waiter/               # 🍽️ Rutas waiter específicas
│   │   └── 🔐 auth.py           # Auth waiter
│   ├── 📁 chef/                 # 👨‍🍳 Rutas chef específicas
│   │   └── 🔐 auth.py           # Auth chef
│   ├── 📁 cashier/              # 💰 Rutas cashier específicas
│   │   └── 🔐 auth.py           # Auth cashier
│   └── 📁 admin/                # 👑 Rutas admin específicas
│       └── 🔐 auth.py           # Auth admin
├── 📁 templates/                # 🎨 Templates empleados
│   ├── 📄 dashboard.html        # Dashboard principal
│   ├── 📄 order_details.html    # Detalles pedido
│   ├── 📄 table_assignments.html # Asignación mesas
│   └── 📄 ...                  # Otros templates
├── 📁 services/                 # 🧠 Business logic
│   ├── 🧾 order_service.py     # Lógica pedidos
│   ├── 🍽️ menu_service.py       # Lógica menú
│   ├── 👥 role_service.py      # Lógica roles
│   └── 🪑 table_service.py     # Lógica mesas
├── 📁 static/                   # 🎯 Assets frontend
│   └── 📁 js/
│       └── 📁 src/
│           ├── 📁 entrypoints/  # 🚀 2 entry points
│           │   ├── 📄 base.ts
│           │   └── 📄 dashboard.ts
│           └── 📁 components/   # 🧩 Vue components
│               └── 🧪 EmployeesManager.vue
├── 📁 decorators/              # 🔐 Authentication decorators
│   └── 📄 permissions.py       # Permission checks
├── 📁 permissions/             # 🔒 Permission definitions
├── 📄 app.py                   # 🏗️ Flask app factory
└── 📄 __init__.py              # 📦 Module init
```

### 🔗 **Shared Components (`build/shared/`)**

```
shared/                          # 🔧 Componentes compartidos
├── 📁 routes/                   # 🌐 API routes compartidas
│   ├── 🔐 auth.py              # Autenticación compartida
│   ├── 👑 roles.py             # Gestión roles/permisos
│   ├── 📊 api.py               # APIs públicas
│   ├── 📈 dashboard.py         # Dashboard compartido
│   └── 🖼️ images.py           # Gestión imágenes compartida
├── 📁 services/                 # 🧠 Business logic compartida
│   ├── 🔐 auth/                # Auth services
│   ├── 🧾 notifications/       # Notification services
│   ├── 🖼️ images/              # Image processing
│   └── 🔒 secret/              # Secret management
├── 📁 templates/                # 🎨 Templates compartidos
├── 📄 models.py                # 🏗️ SQLAlchemy models
├── 📄 constants.py             # 📋 Constants definitions
├── 📄 db.py                    # 🗄️ Database setup
├── 📄 security_middleware.py   # 🔒 Security middleware
├── 📄 multi_scope_session.py   # 🍪 Session management
├── 📄 supabase_realtime.py     # ⚡ Real-time events
└── 📄 __init__.py              # 📦 Module init
```

### 🍽️ **Legacy Apps (Scope Isolated)**

```
waiter/                          # 🍽️ App Waiter legacy
├── 📁 routes/
│   └── 🔐 auth.py              # Auth waiter
├── 📁 templates/
│   └── 📄 dashboard.html       # Dashboard waiter
└── 📁 static/

chef/                            # 👨‍🍳 App Chef legacy
├── 📁 routes/
│   └── 🔐 auth.py              # Auth chef
├── 📁 templates/
│   └── 📄 dashboard.html       # Dashboard chef
└── 📁 static/

cashier/                         # 💰 App Cashier legacy
├── 📁 routes/
│   └── 🔐 auth.py              # Auth cashier
├── 📁 templates/
│   └── 📄 dashboard.html       # Dashboard cashier
└── 📁 static/

admin/                           # 👑 App Admin legacy
├── 📁 routes/
│   └── 🔐 auth.py              # Auth admin
├── 📁 templates/
│   ├── 📄 dashboard.html       # Dashboard admin
│   ├── 📄 analytics.html       # Analytics
│   ├── 📄 branding.html        # Branding
│   ├── 📄 business_config.html # Config negocio
│   ├── 📄 feedback_dashboard.html # Feedback
│   └── 📄 roles_management.html # Gestión roles
└── 📁 static/
```

---

## 🗃️ **Directorios de Configuración**

### 📋 **Config (`config/`)**

```
config/
├── 📁 environments/             # 🌍 Environment configs
│   ├── 📄 development.py        # Dev settings
│   ├── 📄 production.py         # Prod settings
│   └── 📄 testing.py           # Test settings
├── 📄 __init__.py              # Config factory
├── 📄 docker-compose.yml       # Docker dev
└── 📄 nginx.conf               # Reverse proxy
```

### 📜 **Migrations (`migrations/`)**

```
migrations/
├── 📁 versions/                # 📋 Migration files
├── 📄 alembic.ini             # Alembic config
├── 📄 env.py                  # Migration environment
└── 📄 script.py.mako          # Migration template
```

### 🧪 **Tests (`tests/`)**

```
tests/
├── 📁 unit/                   # 🔬 Unit tests
├── 📁 integration/            # 🔗 Integration tests
├── 📁 e2e/                    # 🎭 End-to-end tests
├── 📁 fixtures/               # 📎 Test data
├── 📄 conftest.py             # pytest configuration
└── 📄 test_orders.py          # Example test file
```

### 🔧 **Scripts (`scripts/`)**

```
scripts/
├── 📁 database/               # 🗄️ DB utilities
├── 📁 deployment/             # 🚀 Deployment scripts
├── 📁 maintenance/            # 🔧 Maintenance tasks
└── 📄 setup.sh               # Environment setup
```

### 🐳 **Container Configuration**

```
bin/                           # 🐳 Production scripts
├── 📁 mac/                    # 🍎 macOS development
│   ├── 📄 start.sh            # Start services
│   ├── 📄 rebuild.sh         # Rebuild containers
│   ├── 📄 status.sh           # Check status
│   └── 📄 stop.sh            # Stop services
├── 📄 start.sh               # Linux production start
├── 📄 rebuild.sh             # Linux production rebuild
├── 📄 status.sh              # Linux status check
└── 📄 stop.sh                # Linux stop services
```

---

## 🎯 **Frontend Assets**

### 🖼️ **Static Content (`static_content/`)**

```
static_content/
├── 📁 assets/                # 🎨 Shared assets
│   ├── 📁 images/            # 🖼️ Product images
│   ├── 📁 icons/             # 🎭 UI icons
│   └── 📁 fonts/             # 🔤 Font files
├── 📁 css/                   # 🎨 Global styles
│   ├── 📄 components.css      # Component styles
│   ├── 📄 utilities.css       # Utility classes
│   └── 📄 variables.css      # CSS custom properties
└── 📄 index.html             # Static entry point
```

### 🚀 **Vue.js Build (`vite.config.ts`)**

```typescript
// Multi-target configuration
targets: {
  clients: {
    entrypoints: {
      base: 'entrypoints/base.ts',
      menu: 'entrypoints/menu.ts',
      'thank-you': 'entrypoints/thank-you.ts',
    },
  },
  employees: {
    entrypoints: {
      base: 'entrypoints/base.ts',
      dashboard: 'entrypoints/dashboard.ts',
    },
  },
}
```

---

## 📊 **Estadísticas de Estructura**

| Componente        | Archivos | Líneas Código | Endpoints |
| ----------------- | -------- | ------------- | --------- |
| **pronto_clients**   | ~150     | ~15,000       | ~50       |
| **pronto_employees** | ~300     | ~35,000       | ~150      |
| **shared**        | ~80      | ~8,000        | ~30       |
| **Legacy Apps**   | ~40      | ~4,000        | ~8        |
| **Tests**         | ~60      | ~5,000        | -         |
| **TOTAL**         | **~630** | **~67,000**   | **~238**  |

---

## 🔧 **Patrones de Organización**

### 📦 **Modular Architecture**

- **Blueprints** para routing modular
- **Services** para business logic
- **Models** centralizados en `shared`
- **Static assets** separados por app

### 🔒 **Security Layers**

- **Multi-scope sessions** por rol
- **Permission decorators** en endpoints
- **Encrypted PII** en modelos sensibles
- **CSRF protection** global

### 🚀 **Build Pipeline**

- **Vite** multi-target para frontend
- **Docker** containers por servicio
- **Alembic** para database migrations
- **pytest** para testing pipeline

### 📈 **Scalability Design**

- **Blueprint architecture** escalable
- **Database connection pooling**
- **Redis caching** para sesiones
- **CDN-ready** static assets

---

## 🎯 **Consideraciones de Desarrollo**

### 🔐 **Multi-Scope Isolation**

Cada app legacy (`waiter/`, `chef/`, `cashier/`, `admin/`) mantiene:

- **Cookie path isolation**
- **Separate sessions**
- **Role-specific routing**
- **Independent authentication**

### 🧩 **Component Reusability**

- **Shared models** en `build/shared/models.py`
- **Common services** en `build/shared/services/`
- **Reusable templates** en `build/shared/templates/`
- **Global utilities** en `build/shared/utils/`

### 🔄 **Development Workflow**

```bash
# Start dev environment
bash bin/mac/start.sh

# Rebuild specific app
bash bin/mac/rebuild.sh --keep-sessions waiter

# Run tests
make test-fast

# Lint and format
make check-all
```

Esta estructura proporciona una **arquitectura modular y escalable** con **claras separaciones de responsabilidades** y **seguridad multi-nivel** para sistemas enterprise de restaurant management.
