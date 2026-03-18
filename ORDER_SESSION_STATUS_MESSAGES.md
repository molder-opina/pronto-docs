# Mensajes Descriptivos Equivalentes - Estados de Orden y Sesión

## Overview

Este documento proporciona el listado completo de mensajes descriptivos equivalentes para los estados de **órdenes** y **sesiones** del cliente en el sistema PRONTO, organizados por idioma y contexto de uso.

## Estados de Orden (OrderStatus)

### Fuente Única de Verdad
- **Metadatos técnicos**: `pronto-libs/src/pronto_shared/constants.py` (`ORDER_STATUS_META_DEFAULT`)
- **Traducciones UI**: `pronto-static/src/vue/shared/i18n/locales/*.json` (`status.order`)

### Español (es)

| Estado | Traducción UI | Etiqueta Cliente | Etiqueta Empleado | Descripción Admin |
|--------|---------------|------------------|-------------------|-------------------|
| `new` | "Solicitada" | "Orden creada" | "Esperando mesero" | "Orden creada; aún no ha sido enviada a preparación." |
| `queued` | "Aceptada" | "En proceso" | "Enviando a cocina" | "Orden confirmada y en cola para preparación o salto de cocina." |
| `preparing` | "En cocina" | "Preparando tu orden" | "En cocina" | "Preparación en curso (cocina inició)." |
| `ready` | "Lista" | "Lista" | "Listo entrega" | "Preparación finalizada; lista para entrega." |
| `delivered` | "Entregada" | "Entregada" | "Entregado" | "Orden entregada al cliente." |
| `awaiting_payment` | "Cerrando" | "Pendiente de pago" | "Esperando pago" | "Orden entregada; esperando cobro/registro." |
| `paid` | "Pagada" | "Pagada" | "Pagada" | "Pago registrado y confirmado." |
| `cancelled` | "Cancelada" | "Cancelada" | "Cancelada" | "Orden cancelada." |

### Inglés (en)

**Nota**: Los metadatos técnicos (`client_label`, `employee_label`, `admin_desc`) solo existen en español en el backend. Las traducciones en inglés se infieren de las traducciones UI y contexto lógico.

| Estado | Traducción UI | Etiqueta Cliente (inferida) | Etiqueta Empleado (inferida) | Descripción Admin (inferida) |
|--------|---------------|----------------------------|-----------------------------|------------------------------|
| `new` | "Requested" | "Order created" | "Waiting for waiter" | "Order created; not yet sent to preparation." |
| `queued` | "Accepted" | "In process" | "Sending to kitchen" | "Order confirmed and queued for preparation or kitchen skip." |
| `preparing` | "In kitchen" | "Preparing your order" | "In kitchen" | "Preparation in progress (kitchen started)." |
| `ready` | "Ready" | "Ready" | "Ready for delivery" | "Preparation completed; ready for delivery." |
| `delivered` | "Delivered" | "Delivered" | "Delivered" | "Order delivered to customer." |
| `awaiting_payment` | "Closing" | "Payment pending" | "Waiting for payment" | "Order delivered; awaiting payment/collection." |
| `paid` | "Paid" | "Paid" | "Paid" | "Payment registered and confirmed." |
| `cancelled` | "Cancelled" | "Cancelled" | "Cancelled" | "Order cancelled." |

## Estados de Sesión (SessionStatus)

### Fuente Única de Verdad
- **Traducciones UI**: `pronto-static/src/vue/shared/i18n/locales/*.json` (`status.session`)
- **Nota**: Los estados de sesión no tienen metadatos técnicos equivalentes a las órdenes

### Español (es)

| Estado | Traducción UI | Contexto de Uso |
|--------|---------------|-----------------|
| `open` | "Abierta" | Sesión recién creada, esperando órdenes |
| `active` | "Activa" | Sesión con órdenes activas |
| `awaiting_tip` | "Propina" | Esperando propina del cliente |
| `awaiting_payment` | "Pago pendiente" | Cuenta solicitada, esperando pago |
| `awaiting_payment_confirmation` | "Confirmación de pago" | Pago procesado, esperando confirmación |
| `merged` | "Fusionada" | Sesión fusionada con otra |
| `closed` | "Cerrada" | Sesión cerrada sin pago (cancelada) |
| `paid` | "Pagada" | Sesión pagada y cerrada |

### Inglés (en)

| Estado | Traducción UI | Contexto de Uso |
|--------|---------------|-----------------|
| `open` | "Open" | Session newly created, waiting for orders |
| `active` | "Active" | Session with active orders |
| `awaiting_tip` | "Tip" | Waiting for customer tip |
| `awaiting_payment` | "Payment pending" | Check requested, awaiting payment |
| `awaiting_payment_confirmation` | "Payment confirmation" | Payment processed, awaiting confirmation |
| `merged` | "Merged" | Session merged with another |
| `closed` | "Closed" | Session closed without payment (cancelled) |
| `paid` | "Paid" | Session paid and closed |

## Estados de Pago (PaymentStatus)

### Fuente Única de Verdad
- **Traducciones UI**: `pronto-static/src/vue/shared/i18n/locales/*.json` (`status.payment`)

### Español (es)

| Estado | Traducción UI | Contexto de Uso |
|--------|---------------|-----------------|
| `unpaid` | "Sin pagar" | Pago no iniciado |
| `awaiting_tip` | "Propina" | Propina solicitada |
| `paid` | "Pagada" | Pago completado |

### Inglés (en)

| Estado | Traducción UI | Contexto de Uso |
|--------|---------------|-----------------|
| `unpaid` | "Unpaid" | Payment not started |
| `awaiting_tip` | "Tip" | Tip requested |
| `paid` | "Paid" | Payment completed |

## Mapeo de Contextos

### Cliente (Customer Interface)
- **Órdenes**: Usa `client_label` de `ORDER_STATUS_META_DEFAULT`
- **Sesiones**: Usa traducciones directas de `status.session`
- **Pagos**: Usa traducciones directas de `status.payment`

### Empleado (Employee Interface)
- **Órdenes**: Usa `employee_label` de `ORDER_STATUS_META_DEFAULT`
- **Sesiones**: Usa traducciones directas de `status.session`
- **Pagos**: Usa traducciones directas de `status.payment`

### Administración (Admin Interface)
- **Órdenes**: Usa `admin_desc` de `ORDER_STATUS_META_DEFAULT`
- **Sesiones**: Usa traducciones directas de `status.session`
- **Pagos**: Usa traducciones directas de `status.payment`

## Reglas de Uso

1. **Consistencia**: Las traducciones UI deben coincidir con las etiquetas correspondientes según el contexto
2. **Internacionalización**: Todas las cadenas deben estar disponibles en ambos idiomas (es/en)
3. **Extensibilidad**: Nuevos estados deben seguir el mismo patrón de metadatos y traducciones
4. **Autoridad Única**: Cualquier cambio debe actualizarse en ambas fuentes (metadatos y traducciones)

## Archivos de Referencia

- **Metadatos de orden**: `pronto-libs/src/pronto_shared/constants.py`
- **Traducciones español**: `pronto-static/src/vue/shared/i18n/locales/es.json`
- **Traducciones inglés**: `pronto-static/src/vue/shared/i18n/locales/en.json`
- **Sincronización automática**: `pronto-static/scripts/generate-canonical-types.py`

---
*Documento generado automáticamente - Fuente única de verdad: pronto-libs y pronto-static*