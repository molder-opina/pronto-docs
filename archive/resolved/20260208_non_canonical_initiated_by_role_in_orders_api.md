---
ID: BUG-ORDERS-API-INITIATED-BY-ROLE-001
TITULO: Uso de rol no canónico 'employee' en `initiated_by_role` en Orders API
SEVERIDAD: Media
MODULOS: pronto-api
ESTADO: Resuelto
FECHA_DETECCION: 2026-02-08
---

### Descripción del Error
El endpoint de la API de órdenes en `pronto-api/src/api_app/routes/employees/orders.py` asigna la cadena literal `"employee"` a la variable `initiated_by_role` al crear una modificación de orden. Los valores canónicos esperados para este campo, según la lógica del servicio de modificación de órdenes, son `customer` o `waiter` (o sus equivalentes del enum `ModificationInitiator`).

### Ubicación
`pronto-api/src/api_app/routes/employees/orders.py:382`

### Evidencia
```python
initiated_by_role="employee",
```

### Impacto
El uso de una cadena no canónica para `initiated_by_role` puede causar inconsistencias en el seguimiento y procesamiento de las modificaciones de órdenes. Esto podría llevar a que la lógica que depende de este campo (por ejemplo, notificaciones, auditoría, o reglas de aprobación) no funcione correctamente, ya que no reconocerá `"employee"` como un iniciador válido.

### Fix Mínimo Sugerido
Reemplazar `initiated_by_role="employee"` con uno de los valores canónicos esperados, como `initiated_by_role=ModificationInitiator.WAITER.value` o `initiated_by_role=ModificationInitiator.CUSTOMER.value`, según la intención del código. Dado que el contexto es un API de `employees`, es probable que la intención sea `waiter`.

```diff
--- a/pronto-api/src/api_app/routes/employees/orders.py
+++ b/pronto-api/src/api_app/routes/employees/orders.py
@@ -379,7 +379,7 @@
         status,
         reason,
         # Initiated by an employee through the orders API (likely a waiter)
-        initiated_by_role="employee",
+        initiated_by_role=ModificationInitiator.WAITER.value, # Assuming employee action is usually waiter
         employee_id=employee_id,
     )
```

### Tracking
BUG-ORDERS-API-INITIATED-BY-ROLE-001
