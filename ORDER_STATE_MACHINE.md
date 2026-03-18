# Order State Machine - PRONTO

## Overview

El sistema de órdenes de PRONTO implementa una **Máquina de Estado Finito (Finite State Machine)** que controla el flujo de vida completo de las órdenes desde su creación hasta su finalización (pago o cancelación).

Este documento describe todos los estados, transiciones válidas, roles autorizados y reglas de negocio asociadas.

## Estados del Sistema

| Estado | Descripción | Tipo |
|--------|-------------|------|
| `new` | Orden creada por cliente | Inicial |
| `queued` | Mesero aceptó la orden | Activo |
| `preparing` | Chef preparando la orden | Activo |
| `ready` | Orden lista para entregar | Activo |
| `delivered` | Orden entregada al cliente | Activo |
| `awaiting_payment` | Esperando confirmación de pago | Activo |
| `paid` | Pago completado | Terminal ✅ |
| `cancelled` | Orden cancelada | Terminal ❌ |

## Diagrama de Estados

```mermaid
stateDiagram-v2
    direction LR
    
    [*] --> new
    new --> queued: accept_or_queue<br/>(waiter, admin, system)
    new --> cancelled: cancel<br/>(client, waiter, admin, system)
    
    queued --> preparing: kitchen_start<br/>(chef, admin, system)
    queued --> ready: skip_kitchen<br/>(system)
    queued --> cancelled: cancel<br/>(client, waiter, admin, system)
    
    preparing --> ready: kitchen_complete<br/>(chef, admin, system)
    preparing --> cancelled: cancel<br/>(waiter, admin, system)<br/>*requires justification*
    
    ready --> delivered: deliver<br/>(waiter, admin, system)
    ready --> cancelled: cancel<br/>(admin, system)<br/>*requires justification*
    
    delivered --> awaiting_payment: mark_awaiting_payment<br/>(waiter, cashier, admin, system)
    delivered --> paid: pay_direct<br/>(admin, system)<br/>*requires justification*
    delivered --> cancelled: cancel<br/>(admin, system)<br/>*requires justification*
    
    awaiting_payment --> paid: pay<br/>(waiter, cashier, admin, system)
    awaiting_payment --> cancelled: cancel<br/>(admin, system)<br/>*requires justification*
    
    state "new<br/>(Solicitada)" as new
    state "queued<br/>(Aceptada)" as queued
    state "preparing<br/>(En cocina)" as preparing
    state "ready<br/>(Lista)" as ready
    state "delivered<br/>(Entregada)" as delivered
    state "awaiting_payment<br/>(Cerrando)" as awaiting_payment
    state "paid<br/>(Pagada)" as paid
    state "cancelled<br/>(Cancelada)" as cancelled
    
    classDef activeState fill:#98FB98,stroke:#333,stroke-width:1px;
    classDef terminalState fill:#32CD32,stroke:#333,stroke-width:2px;
    classDef startState fill:#FFE4B5,stroke:#333,stroke-width:1px;
    
    class new,queued,preparing,ready,delivered,awaiting_payment startState|activeState
    class paid,cancelled terminalState
```

## Transiciones Detalladas

### 1. Creación y Aceptación
- **`new` → `queued`**: Mesero acepta la orden
  - Roles: `waiter`, `admin`, `system`
  - Justificación: No requerida

- **`new` → `cancelled`**: Cancelación inmediata
  - Roles: `client`, `waiter`, `admin`, `system`
  - Justificación: No requerida

### 2. Flujo de Cocina
- **`queued` → `preparing`**: Chef inicia preparación
  - Roles: `chef`, `admin`, `system`
  - Justificación: No requerida

- **`queued` → `ready`**: Salto de cocina (pedidos rápidos)
  - Roles: `system`
  - Justificación: No requerida

- **`preparing` → `ready`**: Chef completa preparación
  - Roles: `chef`, `admin`, `system`
  - Justificación: No requerida

### 3. Entrega y Pago
- **`ready` → `delivered`**: Mesero entrega orden
  - Roles: `waiter`, `admin`, `system`
  - Justificación: No requerida

- **`delivered` → `awaiting_payment`**: Solicitar cuenta
  - Roles: `waiter`, `cashier`, `admin`, `system`
  - Justificación: No requerida

- **`awaiting_payment` → `paid`**: Confirmar pago
  - Roles: `waiter`, `cashier`, `admin`, `system`
  - Justificación: No requerida

### 4. Cancelaciones Avanzadas
Las cancelaciones desde estados avanzados requieren justificación:

- **`preparing` → `cancelled`**: Cancelar durante preparación
  - Roles: `waiter`, `admin`, `system`
  - Justificación: **Requerida**

- **`ready` → `cancelled`**: Cancelar orden lista
  - Roles: `admin`, `system`
  - Justificación: **Requerida**

- **`delivered` → `cancelled`**: Cancelar orden entregada
  - Roles: `admin`, `system`
  - Justificación: **Requerida**

- **`awaiting_payment` → `cancelled`**: Cancelar antes del pago
  - Roles: `admin`, `system`
  - Justificación: **Requerida**

### 5. Pagos Directos
- **`delivered` → `paid`**: Pago directo sin solicitar cuenta
  - Roles: `admin`, `system`
  - Justificación: **Requerida**

## Reglas de Negocio Clave

### Roles y Permisos
- **Cliente**: Solo puede cancelar desde `new` y `queued`
- **Mesero**: Puede aceptar, entregar, solicitar pago y cancelar temprano
- **Chef**: Solo maneja transiciones de cocina (`preparing` ↔ `ready`)
- **Cajero**: Solo puede confirmar pagos (`awaiting_payment` → `paid`)
- **Admin/System**: Acceso completo a todas las transiciones

### Estados Terminales
Una vez que una orden alcanza `paid` o `cancelled`, **no se pueden realizar más modificaciones**. Estos son estados finales irreversibles.

### Justificaciones Requeridas
Las cancelaciones desde estados avanzados (`preparing`, `ready`, `delivered`, `awaiting_payment`) **requieren justificación obligatoria** para auditoría y trazabilidad.

## Autoridad Única

Todas las transiciones de estado deben realizarse exclusivamente a través del **OrderStateMachine** ubicado en:

```
pronto-libs/src/pronto_shared/services/order_state_machine.py
```

Cualquier modificación directa de `workflow_status` fuera de este servicio está estrictamente prohibida según las reglas de AGENTS.md.

## Quick Reference Matrix

| Desde → Hacia | new | queued | preparing | ready | delivered | awaiting_payment | paid | cancelled |
|---------------|-----|--------|-----------|-------|-----------|------------------|------|-----------|
| **new** | - | ✅ | - | - | - | - | - | ✅ |
| **queued** | - | - | ✅ | ✅ | - | - | - | ✅ |
| **preparing** | - | - | - | ✅ | - | - | - | ✅* |
| **ready** | - | - | - | - | ✅ | - | - | ✅* |
| **delivered** | - | - | - | - | - | ✅ | ✅* | ✅* |
| **awaiting_payment** | - | - | - | - | - | - | ✅ | ✅* |
| **paid** | - | - | - | - | - | - | - | - |
| **cancelled** | - | - | - | - | - | - | - | - |

✅ = Transición permitida  
✅* = Transición permitida con justificación requerida  
- = Transición no permitida

## Archivos de Referencia

- **Definición de estados**: `pronto-libs/src/pronto_shared/constants.py`
- **Transiciones válidas**: `ORDER_TRANSITIONS` en constants.py  
- **Servicio de estado**: `pronto-libs/src/pronto_shared/services/order_state_machine.py`
- **Validación de transiciones**: `pronto-libs/src/pronto_shared/services/order_transitions.py`

---
*Documento generado automáticamente - Fuente única de verdad: pronto-libs*