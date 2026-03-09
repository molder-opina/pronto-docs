# Guía de Deuda Técnica y Anti-Patrones: Pronto System Guardrails

Este documento captura los errores históricos resueltos y define qué **NO HACER** al desarrollar en el proyecto Pronto.

---

## 🚫 Lo que NUNCA debes hacer (Anti-Patrones)

### 1. Flask Session para Staff
- **Error**: `session['employee_id'] = user.id`.
- **Por qué**: Rompe el principio de arquitectura stateless y el aislamiento multi-consola.
- **Alternativa**: Usar cookies de JWT prefijadas (`access_token_<role>`) manejadas por `jwt_middleware.py`.

### 2. Lógica de Negocio en el Frontend
- **Error**: Calcular impuestos o totales de órdenes en un componente Vue.
- **Por qué**: Genera discrepancias financieras. El cliente solo debe "mostrar" lo que `pronto-api` calcula.
- **Alternativa**: Consumir los campos `total`, `tax` y `subtotal` devueltos por los servicios de `pronto-libs`.

### 3. Borrado Físico de Datos Núcleo
- **Error**: `DELETE FROM pronto_menu_items WHERE id = ...`.
- **Por qué**: Rompe la integridad referencial de órdenes históricas y reportes.
- **Alternativa**: Usar `is_deleted = True` o `is_available = False`.

### 4. Estilos Inline y Scripts Locales
- **Error**: `<style> .my-class { color: red; } </style>` en un archivo `.html` o `.vue`.
- **Por qué**: Dificulta el mantenimiento y viola la política de seguridad de contenido (CSP).
- **Alternativa**: Agregar la clase en el módulo CSS correspondiente en `pronto-static`.

---

## ⚠️ Puntos de Dolor Históricos (Resolved Gaps)

### 1. Desincronización de Identidad Anónima
- **Lección**: Al registrar un cliente que venía operando de forma anónima, se debe migrar su `dining_session_id` al nuevo `customer_id`. No duplicar sesiones.

### 2. Timeouts en Realtime (SSE)
- **Lección**: Los streams SSE deben tener un heartbeat para evitar que los proxies (Nginx) cierren la conexión por inactividad.

### 3. Colisiones de CSRF
- **Lección**: En entornos de desarrollo con múltiples servicios en localhost, los tokens CSRF pueden colisionar si no tienen el flag `Secure` y el `Path` correcto. Siempre refrescar el token si se recibe un error 403 inesperado.

---

## 🔍 Checklist de Revisión de Código (Code Review)

- [ ] ¿La nueva función está en `pronto_shared` si es reutilizable?
- [ ] ¿Se están usando Type Hints en Python y tipos estrictos en TS?
- [ ] ¿El cambio de estado de la orden pasa por `OrderStateMachine`?
- [ ] ¿Se inyectó el header de identidad (`X-PRONTO-CUSTOMER-REF`)?
- [ ] ¿El endpoint implementa `/health` si es un servicio nuevo?
- [ ] ¿Se agregaron las variables de entorno al `.env.example`?
