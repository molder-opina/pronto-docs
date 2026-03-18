# Guía de Cancelación Inteligente para Restaurantes

## Overview

PRONTO implementa un sistema de cancelación inteligente que permite a los clientes y staff cancelar items específicos en una orden, basado en el tipo de producto y su estado actual.

## Tipos de Productos

### Productos con Preparación (`is_quick_serve = false`)
- Hamburguesas, pizzas, tacos, platos elaborados
- **Cancelación permitida**: Solo hasta estado `QUEUED` (antes de cocina)

### Productos Instantáneos (`is_quick_serve = true`)  
- Agua, refrescos, cerveza, café americano
- **Cancelación permitida**: Hasta estado `READY` (antes de servir)

## Reglas por Rol

### Cliente
- Puede cancelar productos instantáneos hasta que estén listos para servir
- Puede cancelar productos con preparación solo antes de que entren a cocina
- No requiere justificación para cancelaciones permitidas

### Mesero/Admin
- Puede cancelar cualquier item en cualquier estado (excepto ya entregado)
- Requiere justificación para cancelaciones en estados avanzados
- Tiene control total sobre la operación

## Estados del Sistema

```
NEW → QUEUED → PREPARING → READY → SERVED → COMPLETED
                   ↓             ↓
                CANCELLED     CANCELLED  
```

**Estados terminales**: `COMPLETED`, `CANCELLED`

## Flujos Comunes

### Cliente cancela bebida
1. Cliente pide agua mineral y hamburguesa
2. Agua llega a estado `READY`, hamburguesa a `PREPARING`
3. Cliente cancela agua → agua se marca como `CANCELLED`
4. Hamburguesa continúa su flujo normal
5. Orden se completa con solo la hamburguesa

### Mesero maneja orden mixta
1. Orden contiene cerveza (`READY`) y pizza (`PREPARING`)
2. Cliente quiere cancelar cerveza
3. Mesero cancela solo la cerveza con justificación "cliente cambió de opinión"
4. Pizza continúa su preparación normal

## API Endpoints

### Obtener reglas de cancelación
```
GET /api/orders/{order_id}/cancellation-rules
```

Respuesta:
```json
{
  "items": [
    {
      "item_id": "uuid1",
      "can_cancel": true,
      "reason": null
    },
    {
      "item_id": "uuid2",
      "can_cancel": false, 
      "reason": "Item already in preparation"
    }
  ]
}
```

### Cancelar items
```
POST /api/orders/{order_id}/cancel-items
```

Payload:
```json
{
  "item_ids": ["uuid1", "uuid2"],
  "cancellation_reason": "Cliente cambió de opinión",
  "cancellation_type": "customer_changed_mind"
}
```

## Auditoría y Métricas

Todas las cancelaciones se registran con:
- Item específico cancelado
- Actor (cliente, mesero, admin)
- Razón de cancelación
- Timestamp exacto

Métricas disponibles:
- Tasa de cancelación por tipo de producto
- Razones más comunes de cancelación
- Tiempos de cancelación vs entrega

## Migración de Productos Existentes

El sistema automáticamente clasifica productos existentes:
- **Bebidas y agua**: `is_quick_serve = true`
- **Todo lo demás**: `is_quick_serve = false`

Los administradores pueden ajustar manualmente esta configuración si es necesario.