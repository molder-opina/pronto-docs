# Guía de Uso: Entrega Parcial y Cancelación por Item

## Visión General

El sistema de **entrega parcial y cancelación por item** permite a los empleados manejar órdenes de forma granular, mejorando la eficiencia operativa en restaurantes pequeños/medianos.

### Beneficios Clave

- ✅ **Operación rápida**: Cancelar o entregar items específicos sin afectar toda la orden
- ✅ **Flexibilidad**: Manejar diferentes tiempos de preparación (comida vs bebidas)
- ✅ **Precisión**: Indicadores visuales claros del estado de cada item
- ✅ **Control**: Reglas inteligentes basadas en el tipo de producto y rol del empleado

## Indicadores Visuales por Item

Cada item en las órdenes muestra un indicador de estado:

- ⚪ **En cola**: Item pendiente de preparación
- 🟡 **Preparando**: Item en proceso de cocina
- 🟢 **Listo**: Item preparado y listo para entregar
- 🔵 **Entregado**: Item ya entregado al cliente
- 🔴 **Cancelado**: Item cancelado

## Funcionalidad por Rol

### 👨‍🍳 Chef (Cocina)

**Puede:**
- Cancelar cualquier item no entregado (por errores en cocina, ingredientes faltantes, etc.)
- Ver estado de todos los items en tiempo real

**Acciones disponibles:**
- `❌ Cancelar` en items que no han sido entregados

### 👩‍🍳 Mesero (Sala)

**Puede:**
- Cancelar cualquier item no entregado
- Entregar items individuales (entrega parcial)
- Ver estado de todos los items

**Acciones disponibles:**
- `❌ Cancelar` en items que no han sido entregados  
- `🔵 Entregar` en items que están listos (🟢)

### 💰 Cajero (Caja)

**Puede:**
- Cancelar items antes del pago final
- Ver items de órdenes pendientes de pago
- Dividir cuentas por items

**Acciones disponibles:**
- `❌ Cancelar` en items que no han sido entregados
- `👁️ Ver Items` para ver detalles de la orden
- `💰 Dividir` para dividir la cuenta
- `💳 Cobrar` para procesar el pago

## Reglas de Negocio

### Cancelación por Tipo de Producto

#### Productos Instantáneos (`is_quick_serve = true`)
- **Ejemplos**: Bebidas, agua, café americano
- **Cliente puede cancelar**: Hasta que el item sea entregado
- **Empleado puede cancelar**: Siempre que no esté entregado

#### Productos Preparados (`is_quick_serve = false`)  
- **Ejemplos**: Hamburguesas, pizzas, tacos, platos elaborados
- **Cliente puede cancelar**: Solo hasta que el item comience su preparación (`prepared_at = null`)
- **Empleado puede cancelar**: Siempre que no esté entregado

### Protección Concurrente

El sistema incluye protección contra operaciones concurrentes:
- Dos meseros no pueden entregar el mismo item simultáneamente
- No se pueden cancelar items ya entregados
- Las operaciones se validan en tiempo real con bloqueo de base de datos

## Flujos Operativos Comunes

### Escenario 1: Orden Mixta
**Orden**: Hamburguesa + Cerveza
- **Cerveza** lista primero (🟢)
- **Hamburguesa** aún en cocina (🟡)
- **Cliente cancela cerveza**: ✅ Permitido (instantáneo, no entregado)
- **Mesero entrega hamburguesa**: ✅ Permitido cuando esté lista

### Escenario 2: Error en Cocina  
**Orden**: 3 Tacos
- **Chef cancela 1 taco**: ✅ Permitido (error en preparación)
- **Mesero entrega 2 tacos restantes**: ✅ Permitido
- **Orden se marca como entregada**: ✅ Cuando todos los items activos están entregados

### Escenario 3: Pago Anticipado
**Orden**: Comida completa
- **Cliente paga desde app**: ✅ Permitido (estado `paid`)
- **Comida aún no entregada**: ✅ Normal (estado `delivered` ≠ `paid`)
- **Mesero entrega comida**: ✅ Continúa normalmente

## Mejores Prácticas

1. **Ver siempre los indicadores de estado** antes de realizar acciones
2. **Justificar cancelaciones** con motivo claro para auditoría
3. **Entregar items listos** tan pronto como estén disponibles
4. **No duplicar acciones** - el sistema previene operaciones concurrentes

## Solución de Problemas

### "No puedo cancelar este item"
- **Causa**: El item ya fue entregado o es un producto preparado que ya comenzó su preparación
- **Solución**: Verificar el indicador de estado y las reglas por tipo de producto

### "No puedo entregar este item"  
- **Causa**: El item no está listo (no tiene estado 🟢)
- **Solución**: Esperar a que el chef marque el item como listo

### "Error de concurrencia"
- **Causa**: Otro empleado está realizando la misma acción
- **Solución**: Esperar unos segundos y reintentar

## Soporte Técnico

Para problemas técnicos o dudas sobre el funcionamiento del sistema, contacte al soporte técnico con:
- Screenshot de la pantalla
- ID de la orden
- Acción que intentaba realizar
- Mensaje de error mostrado

---
*Este sistema está optimizado para restaurantes pequeños/medianos, priorizando operación rápida, modelo mantenible, y pocos bugs contables.*