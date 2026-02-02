# Implementación: Sistema de Presentación de Precios

**Fecha**: 2025-12-01
**Estado**: ✅ Completado

## Resumen

Se ha implementado un sistema configurable de presentación de precios que permite al restaurante elegir entre dos modos:

1. **Precio con IVA incluido** (`tax_included`) - Modo recomendado para México y LATAM
2. **Precio sin IVA** (`tax_excluded`) - Modo para eventos y empresas

## Cambios Implementados

### 1. Migración de Base de Datos ✅

**Archivo**: `build/shared/migrations/add_price_display_mode_config.sql`

Se agregó una nueva configuración en la tabla `business_config`:
- **Key**: `price_display_mode`
- **Valor por defecto**: `tax_included`
- **Valores permitidos**: `tax_included` | `tax_excluded`

**Aplicación**:
```bash
sudo podman exec pronto-mysql mysql -upronto -ppronto-pass pronto < build/shared/migrations/add_price_display_mode_config.sql
```

### 2. Servicio de Cálculo de Precios ✅

**Archivo**: `build/shared/services/price_service.py` (NUEVO)

Funciones principales:

#### `get_price_display_mode()`
Obtiene el modo configurado desde `business_config`.

#### `calculate_price_breakdown(display_price, tax_rate, mode)`
Calcula el desglose de precios según el modo:

**Modo `tax_included`** (IVA incluido):
```python
price_base = display_price / (1 + tax_rate)
tax_amount = display_price - price_base
price_final = display_price  # Sin cambio
```

**Modo `tax_excluded`** (IVA excluido):
```python
price_base = display_price
tax_amount = display_price * tax_rate
price_final = price_base + tax_amount
```

#### `should_show_tax_indicator()`
Retorna `True` si se debe mostrar indicador "Precios + IVA" en la UI.

#### Otras funciones:
- `calculate_order_totals()` - Calcula totales de órdenes
- `get_display_price_for_ui()` - Obtiene precio para mostrar en UI
- `get_item_total_price()` - Calcula precio total de un item con modifiers

### 3. Actualización de Lógica de Órdenes ✅

#### **Servicio de Órdenes de Clientes**
**Archivo**: `build/pronto_clients/services/order_service.py`

**Cambios**:
- Importa `calculate_price_breakdown` y `get_price_display_mode`
- Al crear órdenes, calcula `subtotal_base` (precio sin IVA) para cada item y modifier
- Calcula el IVA correctamente: `tax_amount = subtotal_base * tax_rate`
- **Antes** (❌ incorrecto): Sumaba IVA sobre precios que ya tenían IVA incluido
- **Ahora** (✅ correcto): Separa precio base y calcula IVA sobre el precio base

#### **Servicio de Modificación de Órdenes**
**Archivo**: `build/shared/services/order_modification_service.py`

**Función actualizada**: `_recalculate_order_totals()`
- Usa la misma lógica corregida para recalcular totales después de modificaciones
- Importa y usa el servicio de precios para cálculos consistentes

### 4. API de Configuración ✅

**Archivo**: `build/pronto_employees/routes/api/config.py` (Ya existía)

**Endpoints disponibles**:
- `GET /api/config` - Listar todas las configuraciones (requiere login)
- `GET /api/config/<config_key>` - Obtener configuración específica (público)
- `PUT /api/config/<config_id>` - Actualizar configuración (requiere admin)

**Uso**:
```bash
# Obtener configuración actual
GET /api/config/price_display_mode

# Cambiar a modo sin IVA
PUT /api/config/{id}
{
  "value": "tax_excluded"
}

# Volver a modo con IVA
PUT /api/config/{id}
{
  "value": "tax_included"
}
```

## Comportamiento del Sistema

### Modo: Precio con IVA incluido (tax_included) - PREDETERMINADO

**Ejemplo con precio de menú = $116.00 y IVA = 16%**

1. **Menú muestra**: $116.00
2. **Al ordenar**:
   - Precio base: $100.00
   - IVA (16%): $16.00
   - Total: $116.00
3. **Ticket/Factura**:
   ```
   Ensalada Mediterránea    1x  $116.00

   Subtotal:                    $100.00
   IVA (16%):                   $ 16.00
   ─────────────────────────────────────
   Total:                       $116.00
   ```

**✅ El cliente paga exactamente lo que vio en el menú**

### Modo: Precio sin IVA (tax_excluded)

**Ejemplo con precio de menú = $100.00 y IVA = 16%**

1. **Menú muestra**: $100.00 + IVA ⚠️
2. **Al ordenar**:
   - Precio base: $100.00
   - IVA (16%): $16.00
   - Total: $116.00
3. **Ticket/Factura**:
   ```
   Ensalada Mediterránea    1x  $100.00

   Subtotal:                    $100.00
   IVA (16%):                   $ 16.00
   ─────────────────────────────────────
   Total:                       $116.00
   ```

**⚠️ El cliente paga $116.00 aunque el menú mostraba $100.00**
**Se debe indicar claramente "+ IVA" en la UI**

## Impacto en el Sistema

### ✅ Afecta:
- Menú de clientes (app, QR, kioscos)
- Catálogo de delivery
- Cálculo de órdenes
- Cálculo de modificaciones de órdenes
- Tickets y facturas
- Sesiones de comedor (dining sessions)

### ℹ️ No afecta (mantiene compatibilidad):
- Precios almacenados en `menu_items.price` (se interpretan según el modo)
- Precios de modifiers en `modifiers.price_adjustment`
- Estructura de la base de datos
- APIs existentes (funcionan con ambos modos)

## Próximos Pasos

### UI Pendientes:

1. **Panel de Administración**:
   - [ ] Agregar selector en "Parámetros Avanzados"
   - [ ] Mostrar descripción de cada modo
   - [ ] Alertar al cambiar de modo sobre el impacto

2. **App de Clientes**:
   - [ ] Mostrar indicador "Precios + IVA" cuando `mode = tax_excluded`
   - [ ] Ubicación sugerida: Footer del menú y header del carrito

3. **Tickets/Facturas**:
   - [ ] Asegurar que el desglose se muestre correctamente en ambos modos
   - [ ] Imprimir indicador del modo activo en el ticket

### Validaciones Recomendadas:

- [ ] Probar creación de órdenes en ambos modos
- [ ] Verificar que los totales cuadren correctamente
- [ ] Probar modificaciones de órdenes
- [ ] Verificar split bills con ambos modos
- [ ] Probar pagos con Stripe en ambos modos

## Notas Técnicas

### Compatibilidad hacia atrás:
- El modo por defecto es `tax_included`, que es el comportamiento esperado en México y LATAM
- Sistemas existentes funcionarán sin cambios

### Migración de datos:
- No se requiere migración de precios existentes
- Los precios en `menu_items.price` se interpretan según el modo configurado

### Performance:
- Se realiza una única consulta a `business_config` por request
- No hay impacto significativo en performance

## Referencias

- Modelo: `build/shared/models.py:684` - `BusinessConfig`
- Servicio: `build/shared/services/price_service.py`
- Orden Cliente: `build/pronto_clients/services/order_service.py:122`
- Modificaciones: `build/shared/services/order_modification_service.py:411`

## Autor

Claude Code - Antropic
Sistema implementado el 2025-12-01
