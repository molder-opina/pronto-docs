# Error: Endpoints sin JWT en pronto-api

## Metadata
ID: ERR-20260218-001
FECHA: 2026-02-18
PROYECTO: pronto-api
SEVERIDAD: bloqueante
TITULO: Endpoints de orders sin autenticación JWT

## Descripción
Durante la auditoría general de pronto-api se detectaron endpoints de mutación (POST) sin el decorador `@jwt_required`, lo que permite acceso no autenticado a operaciones críticas del flujo de órdenes.

## Pasos para reproducir
1. Hacer POST a `/api/orders/<order_id>/kitchen/start` sin header de Authorization
2. Hacer POST a `/api/orders/<order_id>/kitchen/ready` sin header de Authorization

## Resultado actual
Los endpoints respondían sin requerir autenticación (401 no se retornaba)

## Resultado esperado
Todos los endpoints de mutación deben requerir JWT válido

## Ubicación
pronto-api/src/api_app/routes/employees/orders.py

## Evidencia
```python
# Líneas afectadas (antes del fix):
@bp.post("/<order_id>/kitchen/start")  # SIN @jwt_required
@bp.post("/<order_id>/kitchen/ready") # SIN @jwt_required
```

## Hipótesis causa
Duplicación de rutas durante refactorización - las rutas con `/kitchen/start` y `/kitchen/ready` (con slash) quedaron huérfanas sin los decorators de seguridad mientras existían versiones con guiones (`kitchen-start`, `kitchen-ready`) que sí tenían seguridad.

## Estado: RESUELTO

## Solución
Se eliminaron las rutas duplicadas sin JWT:
- `@bp.post("/<order_id>/kitchen/start")` → ELIMINADO
- `@bp.post("/<order_id>/kitchen/ready")` → ELIMINADO

Las rutas canónicas con guiones (`kitchen-start`, `kitchen-ready`) ya tenían `@jwt_required` y `@scope_required`.

## Commit
Auditoría y corrección de endpoints sin JWT en orders.py

## Fecha Resolución
2026-02-18
