# Seed Data Utility (`seed.py`)

## Proposito

Populate/restaurar datos de demo y desarrollo local de forma idempotente.

## Cuando usar

- Inicializar base de datos vacia
- Restaurar datos de demo
- Resetear entorno de desarrollo
- Correr tests de integracion que requieren datos base

## Cuando NO usar

- Produccion
- Entornos con datos reales

## Datos que carga

- **Empleados**: system, admin, system, waiter, chef, cashier
- **Areas**: Terraza, Comedor Principal, Barra, VIP, Jardin
- **Mesas**: 15 mesas con QR codes
- **Categorias**: 12 categorias de menu
- **Items**: ~150 productos con precios e imagenes
- **Modifiers**: Grupos y opciones de personalizacion

## Uso programatico

```python
from pronto_shared.services.seed import load_seed_data
from pronto_shared.db import get_session

session = get_session()
try:
    load_seed_data(session)
    session.commit()
finally:
    session.close()
```

## Variables de entorno

| Variable | Default | Descripcion |
|----------|---------|-------------|
| RESTAURANT_NAME | pronto | Slug del restaurante |
| SEED_EMPLOYEE_PASSWORD | ChangeMe!123 | Contrasena inicial |
| RESET_EMPLOYEE_PASSWORDS | true | Resetear passwords existentes |

## Contrasenas por defecto

| Rol | Email | Password |
|-----|-------|----------|
| system | admin@cafeteria.test | ChangeMe!123 |
| admin | admin2@cafeteria.test | ChangeMe!123 |
| system | system@cafeteria.test | ChangeMe!123 |
| waiter | waiter1@cafeteria.test | ChangeMe!123 |
| chef | chef1@cafeteria.test | ChangeMe!123 |
| cashier | cashier1@cafeteria.test | ChangeMe!123 |

## Caracteristicas

- **Idempotente**: Se puede correr multiples veces sin duplicar datos
- **UPSERT logic**: Crea si no existe, actualiza si existe
- **Scoped por RESTAURANT_NAME**: Separa datos entre restaurants
- **QR codes generados**: Unicos por mesa
- **Scopes automaticos**: Roles asignados con scopes correctos
