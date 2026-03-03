---
ID: BUG-MISSING-ENUM-TABLE-STATUS-001
TITULO: Falta definición canónica para `TableStatus` en `pronto_shared.constants.py`
SEVERIDAD: Media
MODULOS: pronto-static, pronto-libs
ESTADO: Resuelto
FECHA_DETECCION: 2026-02-08
---

### Descripción del Error
Las aplicaciones frontend (`pronto-static/src/vue/employees/modules/tables-manager.ts` y `pronto-static/src/vue/clients/modules/tables-manager.ts`) utilizan strings literales (`"available"`, `"occupied"`, `"reserved"`, `"indisposed"`) para representar el estado de las mesas. No existe una enumeración `TableStatus` canónica definida en `pronto_shared.constants.py` para estos estados.

### Ubicación
- `pronto-static/src/vue/employees/modules/tables-manager.ts`
- `pronto-static/src/vue/clients/modules/tables-manager.ts`

### Evidencia
```typescript
table.status === "available"
table.status === "occupied"
table.status === "reserved"
table.status === "indisposed"
```

### Impacto
La ausencia de una definición canónica para el estado de las mesas puede llevar a:
- **Inconsistencias de Nomenclatura:** Diferentes partes del sistema podrían usar strings ligeramente diferentes o tener interpretaciones variadas de los estados.
- **Dificultad de Mantenimiento:** Cambiar o añadir un nuevo estado de mesa requiere buscar y actualizar múltiples strings literales en el código, lo que es propenso a errores.
- **Menor Claridad del Código:** El código es menos legible y menos robusto sin una fuente única de verdad para estos valores.

### Fix Mínimo Sugerido
1.  Definir una enumeración `TableStatus(str, Enum)` en `pronto_shared/constants.py` con los valores `AVAILABLE`, `OCCUPIED`, `RESERVED`, `INDISPOSED`.
2.  Actualizar todos los usos de los strings literales (`"available"`, etc.) en los archivos `tables-manager.ts` para que utilicen la nueva enumeración (ej., `TableStatus.AVAILABLE.value`).

### Tracking
BUG-MISSING-ENUM-TABLE-STATUS-001
