---
ID: BUG-MISSING-ENUM-WAITERCALL-STATUS-001
TITULO: Falta definición canónica para `WaiterCallStatus` en `pronto_shared.constants.py`
SEVERIDAD: Media
MODULOS: pronto-static, pronto-libs
ESTADO: Resuelto
FECHA_DETECCION: 2026-02-08
---

### Descripción del Error
La aplicación cliente (`pronto-static/src/vue/clients/modules/client-base.ts`) utiliza el string literal `'confirmed'` para representar el estado de una llamada a mesero. No existe una enumeración `WaiterCallStatus` canónica definida en `pronto_shared.constants.py` para estos estados. Aunque el modelo `WaiterCall` en el backend (`pronto-libs/src/pronto_shared/models.py`) tiene un campo `status` de tipo `String`, la falta de una enumeración compartida puede llevar a inconsistencias.

### Ubicación
- `pronto-static/src/vue/clients/modules/client-base.ts`

### Evidencia
```typescript
data.status === 'confirmed'
```

### Impacto
La ausencia de una definición canónica para el estado de las llamadas a mesero puede llevar a:
- **Inconsistencias de Nomenclatura:** Diferentes partes del sistema podrían usar strings ligeramente diferentes (ej., "confirmed", "accepted", "resolved") o tener interpretaciones variadas de los estados.
- **Dificultad de Mantenimiento:** Cambiar o añadir un nuevo estado de llamada a mesero requiere buscar y actualizar múltiples strings literales en el código.
- **Menor Claridad del Código:** El código es menos legible y menos robusto sin una fuente única de verdad para estos valores.

### Fix Mínimo Sugerido
1.  Definir una enumeración `WaiterCallStatus(str, Enum)` en `pronto_shared/constants.py` con el valor `CONFIRMED` (y cualquier otro estado relevante para `WaiterCall`).
2.  Actualizar todos los usos del string literal `'confirmed'` en `client-base.ts` (y potencialmente en otros lugares si se encuentran) para que utilicen la nueva enumeración (ej., `WaiterCallStatus.CONFIRMED.value`).

### Tracking
BUG-MISSING-ENUM-WAITERCALL-STATUS-001
