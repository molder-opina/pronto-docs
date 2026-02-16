---
ID: NON_CANONICAL_ROLES_CREATION_ALLOWED
FECHA: 20260206
PROYECTO: pronto-libs, pronto-employees
SEVERIDAD: bloqueante
TITULO: Creación de roles no canónicos permitida
DESCRIPCION: El servicio `CustomRoleService` en `pronto_shared/services/custom_role_service.py` permite la creación y modificación de roles (`role_code`, `role_name`) sin validar que estos sean parte del conjunto de roles canónicos definidos (`waiter`, `chef`, `cashier`, `admin`, `system`). Esto viola el principio "No inventar roles" establecido en `AGENTS.md`.
PASOS_REPRODUCIR:
1. Acceder a los endpoints de la API en `pronto-employees/src/pronto_employees/routes/api/roles.py` (`/roles` POST y PUT).
2. Enviar una solicitud para crear un nuevo rol con un `role_code` o `role_name` que no sea parte de los roles canónicos (ej. `{"role_code": "manager", "role_name": "Manager"}`).
3. El sistema creará/actualizará el rol sin restricciones, permitiendo la existencia de roles no canónicos.
RESULTADO_ACTUAL: El sistema permite la creación y gestión de roles con códigos y nombres arbitrarios, más allá de los roles canónicos.
RESULTADO_ESPERADO: El sistema debería restringir la creación y actualización de roles a solo aquellos definidos como canónicos en `AGENTS.md`, o bien, si se permiten roles "personalizados", estos deben tener un mecanismo de validación que asegure que no colisionan o suplantan a los canónicos.
UBICACION:
- pronto-libs/src/pronto_shared/services/custom_role_service.py: CustomRoleService.create_role, CustomRoleService.update_role
- pronto-employees/src/pronto_employees/routes/api/roles.py: create_role, update_role
EVIDENCIA:
```python
# pronto-libs/src/pronto_shared/services/custom_role_service.py (extract)
class CustomRoleService:
    @staticmethod
    def create_role(data: dict[str, Any], employee_id: int | None = None) -> dict[str, Any]:
        # ... no validation against canonical roles ...
        role = CustomRole(**data, created_by=employee_id)
        # ...

    @staticmethod
    def update_role(role_id: int, data: dict[str, Any]) -> dict[str, Any]:
        # ... no validation against canonical roles ...
        for key, value in data.items():
            # ...
            setattr(role, key, value)
```
HIPOTESIS_CAUSA: Falta de validación en la capa de servicio para asegurar que los `role_code` y `role_name` de los roles creados o actualizados correspondan a una lista blanca de roles canónicos. Esto sugiere que `CustomRole` y `SystemRole` son conceptos distintos pero no están siendo validados para asegurar la coherencia del sistema.
ESTADO: RESUELTO
SOLUCION: Validación en CustomRoleService.create_role() y CustomRoleService.update_role() con lista canónica: waiter, chef, cashier, admin.
COMMIT: 75ce4ef
FECHA_RESOLUCION: 2026-02-07
EVIDENCIA:
- ruff check: PASSED
- Validación probada: waiter=OK, owner=REJECTED
---