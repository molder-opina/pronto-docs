# Plan de Refactorización - Subdivisión de Archivos Grandes

Este documento describe el plan para subdividir archivos grandes del proyecto en componentes más manejables.

## 📊 Estado Actual

### Archivos Críticos (>2000 líneas)
1. **dashboard.js** - 3730 líneas ✅ EN PROGRESO
2. **pronto_employees/routes/api.py** - 2692 líneas 🔴 PENDIENTE
3. **shared/services/seed.py** - 2301 líneas 🔴 PENDIENTE
4. **pronto_clients/routes/api.py** - 2003 líneas 🔴 PENDIENTE

---

## ✅ 1. dashboard.js (COMPLETADO)

### Subdivisión Propuesta
```
dashboard.js (3730 → ~500 líneas)
├── modules/
│   ├── payments.js       ✅ Completado (281 líneas)
│   ├── sessions.js       ✅ Completado (367 líneas)
│   ├── products.js       🔴 TODO (~800 líneas)
│   ├── orders.js         🔴 TODO (~400 líneas)
│   └── utils.js          🔴 TODO (~200 líneas)
└── dashboard-main.js     🔴 TODO (~500 líneas)
```

### Estado
- ✅ Creados módulos de payments y sessions
- ✅ Documentación completa en `modules/README.md`
- 🔴 Pendiente: Completar módulos restantes
- 🔴 Pendiente: Refactorizar dashboard.js principal

---

## 🔴 2. pronto_employees/routes/api.py (2692 líneas)

### Análisis de Contenido
```bash
# Endpoints principales:
- Orders: /api/orders/* (~500 líneas)
- Sessions: /api/sessions/* (~400 líneas)
- Modifications: /api/modifications/* (~300 líneas)
- Menu: /api/menu/* (~400 líneas)
- Business Config: /api/business/* (~300 líneas)
- Employees: /api/employees/* (~400 líneas)
- Reports: /api/reports/* (~200 líneas)
- Waiter Calls: /api/notifications/waiter/* (~200 líneas)
```

### Subdivisión Propuesta
```
pronto_employees/routes/
├── api/
│   ├── __init__.py           # Blueprint principal
│   ├── orders.py             # Endpoints de órdenes
│   ├── sessions.py           # Endpoints de sesiones
│   ├── modifications.py      # Endpoints de modificaciones
│   ├── menu.py               # Endpoints de menú
│   ├── business.py           # Endpoints de configuración
│   ├── employees.py          # Endpoints de empleados
│   ├── reports.py            # Endpoints de reportes
│   └── waiter_calls.py       # Endpoints de llamadas
└── api.py (deprecated)       # Mantener por compatibilidad
```

### Implementación Sugerida
```python
# pronto_employees/routes/api/__init__.py
from flask import Blueprint
from .orders import orders_bp
from .sessions import sessions_bp
from .modifications import modifications_bp
# ... etc

api_bp = Blueprint('api', __name__, url_prefix='/api')

# Registrar sub-blueprints
api_bp.register_blueprint(orders_bp)
api_bp.register_blueprint(sessions_bp)
api_bp.register_blueprint(modifications_bp)
# ... etc
```

```python
# pronto_employees/routes/api/orders.py
from flask import Blueprint

orders_bp = Blueprint('orders', __name__)

@orders_bp.post("/orders/<int:order_id>/accept")
@login_required
def accept_order(order_id: int):
    # ... implementación
    pass

# ... más endpoints de órdenes
```

---

## 🔴 3. shared/services/seed.py (2301 líneas)

### Análisis de Contenido
```bash
# Funciones de seed:
- seed_employees() (~200 líneas)
- seed_menu_categories() (~300 líneas)
- seed_menu_items() (~800 líneas)
- seed_modifiers() (~400 líneas)
- seed_permissions() (~200 líneas)
- seed_business_config() (~400 líneas)
```

### Subdivisión Propuesta
```
shared/services/seed/
├── __init__.py               # Función principal load_seed_data()
├── employees.py              # Seed de empleados
├── menu.py                   # Seed de menú (categorías + items)
├── modifiers.py              # Seed de modificadores
├── permissions.py            # Seed de permisos
├── business_config.py        # Seed de configuración
└── data/
    ├── menu_items.json       # Datos de items (opcional)
    ├── modifiers.json        # Datos de modificadores (opcional)
    └── config.json           # Datos de config (opcional)
```

### Implementación Sugerida
```python
# shared/services/seed/__init__.py
from .employees import seed_employees
from .menu import seed_menu
from .modifiers import seed_modifiers
from .permissions import seed_permissions
from .business_config import seed_business_config

def load_seed_data(session):
    """Carga todos los datos de seed en orden correcto"""
    print("Seeding permissions...")
    seed_permissions(session)

    print("Seeding employees...")
    seed_employees(session)

    print("Seeding business config...")
    seed_business_config(session)

    print("Seeding menu...")
    seed_menu(session)

    print("Seeding modifiers...")
    seed_modifiers(session)

    session.commit()
```

---

## 🔴 4. pronto_clients/routes/api.py (2003 líneas)

### Análisis de Contenido
```bash
# Endpoints principales:
- Auth: /api/auth/* (~200 líneas)
- Orders: /api/orders/* (~400 líneas)
- Sessions: /api/sessions/* (~300 líneas)
- Menu: /api/menu/* (~300 líneas)
- Waiter Calls: /api/notifications/waiter/* (~200 líneas)
- Payments: /api/payments/* (~400 líneas)
- Modifications: /api/modifications/* (~200 líneas)
```

### Subdivisión Propuesta
```
pronto_clients/routes/
├── api/
│   ├── __init__.py           # Blueprint principal
│   ├── auth.py               # Endpoints de autenticación
│   ├── orders.py             # Endpoints de órdenes
│   ├── sessions.py           # Endpoints de sesiones
│   ├── menu.py               # Endpoints de menú
│   ├── waiter_calls.py       # Endpoints de llamadas
│   ├── payments.py           # Endpoints de pagos
│   └── modifications.py      # Endpoints de modificaciones
└── api.py (deprecated)       # Mantener por compatibilidad
```

---

## 📋 Plan de Implementación

### Fase 1: Preparación (1-2 días)
- [x] Analizar archivos grandes
- [x] Documentar estructura actual
- [x] Proponer subdivisión lógica
- [x] Crear plan de implementación

### Fase 2: JavaScript (2-3 días)
- [x] Crear módulos base (payments, sessions)
- [ ] Completar módulos restantes (products, orders, utils)
- [ ] Refactorizar dashboard.js principal
- [ ] Pruebas de integración

### Fase 3: Python - API Routes (3-4 días)
- [ ] Crear estructura de sub-blueprints
- [ ] Migrar endpoints de pronto_employees/routes/api.py
- [ ] Migrar endpoints de pronto_clients/routes/api.py
- [ ] Actualizar imports en todo el proyecto
- [ ] Pruebas de integración

### Fase 4: Python - Seed Services (2-3 días)
- [ ] Crear estructura modular para seed
- [ ] Migrar funciones de seed a módulos
- [ ] Opcionalmente: Mover datos a JSON
- [ ] Actualizar scripts de seed
- [ ] Pruebas

### Fase 5: Validación y Deploy (1-2 días)
- [ ] Tests completos
- [ ] Revisión de código
- [ ] Actualizar documentación
- [ ] Deploy gradual

---

## 🎯 Beneficios Esperados

### Mantenibilidad
- ✅ Archivos más pequeños y enfocados
- ✅ Más fácil encontrar código
- ✅ Reducción de conflictos en git

### Performance
- ✅ Imports más específicos
- ✅ Menos carga en memoria
- ✅ Bundle splitting en JavaScript

### Desarrollo
- ✅ Onboarding más rápido
- ✅ Tests más enfocados
- ✅ Desarrollo en paralelo más fácil

### Calidad
- ✅ Menos bugs por archivos complejos
- ✅ Code reviews más efectivos
- ✅ Mejor separación de responsabilidades

---

## ⚠️ Consideraciones

### Compatibilidad
- Mantener archivos originales como deprecated durante transición
- Importar nuevos módulos desde archivos antiguos
- Migración gradual sin romper funcionalidad

### Testing
- Tests unitarios para cada módulo nuevo
- Tests de integración para verificar compatibilidad
- Tests de regresión antes de eliminar código antiguo

### Documentación
- README en cada directorio nuevo
- JSDoc/Docstrings completos
- Guías de migración

---

## 📝 Notas

- **Prioridad**: JavaScript (dashboard.js) > Python API Routes > Seed Services
- **Metodología**: Crear nuevos módulos → Migrar código → Deprecar antiguo → Eliminar
- **Timeline estimado**: 2-3 semanas
- **Riesgo**: Bajo (migración gradual, compatibilidad mantenida)

---

**Creado:** 2025-11-10
**Última actualización:** 2025-11-10
**Estado:** Fase 1 completada, Fase 2 en progreso
