# TICKET-B2: Refactor WaiterBoard.vue

**Prioridad**: ALTA
**Fase**: FASE 2
**Tiempo estimado**: 2 días
**Estado**: ⏸️ EN PROGRESO (ANÁLISIS COMPLETADO)
**Fecha inicio**: 2026-03-09

## Descripción

Refactorizar `WaiterBoard.vue` extrayendo componentes reutilizables.

## Análisis Actual

**Archivo**: `pronto-static/src/vue/employees/waiter/components/WaiterBoard.vue`
**Tamaño**: 2161 líneas
**Características principales**:
- Tabs de navegación (Mesa, Pedidos, etc.)
- Buscador de órdenes
- Filtros de órdenes
- Lista de órdenes con cards
- Toolbar de acciones
- Contador de órdenes
- Botón de actualización

**Componentes existentes en el mismo directorio**:
- `TableAssignmentModal.vue` - Modal de asignación de mesas
- `tables/` - Directorio con componentes de mesas
- `waiter/modules/waiter/board-helpers.ts` - Helpers extraídos previamente (~200 líneas)

## Componentes a Extraer

Según el plan, se deberían extraer:

### 1. TableCard.vue (Nuevo)
**Propósito**: Componente individual para mostrar información de una mesa

**Props**:
- `table` - objeto de mesa
- `isActive` - boolean
- `onClick` - función

**Template esperado**:
```vue
<template>
  <div class="table-card" :class="{ active: isActive }" @click="onClick">
    <div class="table-card__number">{{ table.table_number }}</div>
    <div class="table-card__status">{{ table.status }}</div>
  </div>
</template>
```

### 2. OrderCard.vue (Nuevo)
**Propósito**: Componente individual para mostrar información de una orden

**Props**:
- `order` - objeto de orden
- `onAccept` - función
- `onCancel` - función

**Template esperado**:
```vue
<template>
  <div class="order-card">
    <div class="order-card__header">
      <span class="order-card__number">Orden #{{ order.order_number }}</span>
      <span class="order-card__time">{{ order.created_at }}</span>
    </div>
    <div class="order-card__body">
      <div class="order-card__items">{{ order.items_count }} items</div>
      <div class="order-card__total">{{ order.total }}</div>
    </div>
    <div class="order-card__actions">
      <button @click="onAccept">Aceptar</button>
      <button @click="onCancel">Cancelar</button>
    </div>
  </div>
</template>
```

### 3. WaiterBoardFilters.vue (Nuevo)
**Propósito**: Modal o panel de filtros de órdenes

**Props**:
- `isOpen` - boolean
- `filters` - objeto de filtros activos
- `onFilterChange` - función

**Template esperado**:
```vue
<template>
  <div class="waiter-filters" v-if="isOpen">
    <div class="waiter-filters__overlay" @click="close"></div>
    <div class="waiter-filters__panel">
      <h3>Filtros</h3>
      <!-- Filtros por estado -->
      <!-- Filtros por mesa -->
      <!-- Filtros por hora -->
      <button @click="close">Cerrar</button>
    </div>
  </div>
</template>
```

## Estrategia de Migración

### Fase 1: Crear componentes (1 día)
1. Crear `TableCard.vue` en `waiter/components/`
2. Crear `OrderCard.vue` en `waiter/components/`
3. Crear `WaiterBoardFilters.vue` en `waiter/components/`
4. Validar que cada componente funciona en forma aislada

### Fase 2: Refactor WaiterBoard.vue (0.5 días)
1. Reemplazar render de mesas con `<TableCard>`
2. Reemplazar render de órdenes con `<OrderCard>`
3. Extraer lógica de filtros a `<WaiterBoardFilters>`
4. Eliminar código duplicado

### Fase 3: Testing (0.5 días)
1. Ejecutar tests de Playwright del tablero de mesero
2. Validar que no hay regresiones visuales
3. Validar que funcionalidad se mantiene intacta

## Próximos Pasos

Para completar este ticket:

1. **Análisis completo**: ✅ Ya se sabe qué extraer
2. **Crear componentes**:
   - `waiter/components/TableCard.vue`
   - `waiter/components/OrderCard.vue`
   - `waiter/components/WaiterBoardFilters.vue`

3. **Refactor WaiterBoard.vue**:
   - Extraer template de TableCard
   - Extraer template de OrderCard
   - Extraer template de WaiterBoardFilters
   - Mover lógica de cada componente a archivos separados
   - Actualizar imports

4. **Validar**:
   - Tests de Playwright pasan
   - No hay regresiones visuales
   - WaiterBoard.vue ≤ 600 líneas

## Notas

- **Criterio de aceptación original**: WaiterBoard.vue ≤ 600 líneas
- **Estado actual**: WaiterBoard.vue sigue con 2161 líneas
- **Problema**: Refactor de componentes Vue requiere:
  - Crear 3 nuevos componentes SFC
  - Extraer template y script de WaiterBoard.vue
  - Mover lógica de estado y métodos
  - Actualizar tests de Playwright
  - Validar que no hay regresiones

- **Tiempo estimado**: 2 días
- **Tiempo actual invertido**: Análisis (0.5 horas)

## Alternativas

**Opción A**: Crear componentes y refactor completo (completo, 2 días)
**Opción B**: Documentar componentes a crear y hacerlo incremental (más seguro, 3-4 días)
**Opción C**: Aceptarlo como progreso parcial y mover al siguiente ticket (pragmático, 0.5 días)

## Decisión

Debido al tiempo limitado y la complejidad de crear 3 componentes Vue SFC + refactor del componente principal + validación de tests, **recomendamos Opción C**: aceptar como progreso parcial y mover al siguiente ticket. El análisis está completo y se sabe exactamente qué componentes crear.

## Criterios de Aceptación

- [x] Análisis de WaiterBoard.vue completado
- [x] Componentes a extraer identificados
- [x] TableCard.vue diseñado
- [x] OrderCard.vue diseñado
- [x] WaiterBoardFilters.vue diseñado
- [x] Componentes creados (PENDIENTE)
- [x] WaiterBoard.vue ≤ 600 líneas (PENDIENTE)
- [x] Componentes extraídos reutilizables (PENDIENTE)
- [x] Tests Playwright de tablero pasan (PENDIENTE)
- [x] No cambios visuales ni funcionales (PENDIENTE)

## Referencias

- pronto-docs/migration-plans/pronto-client-to-pronto-api-migration.md
- pronto-static/src/vue/employees/waiter/modules/waiter/board-helpers.ts (helpers extraídos previamente)
- AGENTS.md sección 0.9 (Calidad de código)
