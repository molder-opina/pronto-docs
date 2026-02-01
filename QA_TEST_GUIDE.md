# PRONTO Cafetería - Guía de Pruebas QA Completo

## Pre-requisitos

- Servicios corriendo en: localhost:6080 (Cliente), localhost:6081 (Empleados), localhost:6082 (API)
- Email de prueba: luartx@gmail.com

---

## PASO 1: Crear orden en Cliente (localhost:6080)

### 1.1 Navegar a la aplicación

- Abrir navegador en: http://localhost:6080
- Verificar que cargue correctamente sin errores

### 1.2 Agregar productos al carrito

- **PRUEBA CRÍTICA**: Validación de campos obligatorios ANTES de agregar al carrito
  - Intentar agregar un producto sin seleccionar modificadores requeridos
  - **ESPERADO**: El sistema debe bloquear la acción y mostrar error
  - **IMPACTO**: Previene órdenes inválidas

- Agregar al menos 2 productos diferentes con sus modificadores
- Verificar que aparezca el carrito en el panel lateral

### 1.3 Proceder al checkout

- Abrir panel del carrito
- Verificar que el resumen del pedido sea correcto
- Click en "Confirmar Pedido"

### 1.4 Completar formulario de checkout

- **PRUEBA CRÍTICA**: Validación de campos obligatorios
  - Dejar email vacío y intentar confirmar
  - **ESPERADO**: Sistema debe mostrar error de validación
  - **IMPACTO**: Previene órdenes sin contacto

- Completar email: `luartx@gmail.com`
- Completar nombre: `Test QA User`
- Click en "Confirmar Pedido"

### 1.5 Verificar confirmación visual

- **PRUEBA CRÍTICA**: Confirmación visual de email enviado
  - Verificar que aparezca mensaje de éxito
  - **ESPERADO**: Mensaje claro "Pedido confirmado" o similar
  - **IMPACTO**: Feedback inmediato al usuario

- Verificar que no haya errores en consola
- Verificar que no aparezca DEBUG PANEL

---

## PASO 2: Mesero (localhost:6081)

### 2.1 Login

- Navegar a: http://localhost:6081/waiter/login
- Login con: `juan.mesero@cafeteria.test`
- Password: `ChangeMe!123`

### 2.2 Verificar dashboard

- Verificar que cargue correctamente
- Verificar que no aparezca DEBUG PANEL

### 2.3 Aceptar orden

- **PRUEBA CRÍTICA**: Estados transicionen correctamente
  - Buscar la orden creada en el paso 1
  - Click en "Aceptar" (para enviar a cocina)
  - **ESPERADO**: Orden pase a estado "En preparación" o similar
  - **IMPACTO**: Proceso de cocina iniciado

- Verificar que no aparezca estado "ATRASADO" sin razón

---

## PASO 3: Chef (localhost:6081)

### 3.1 Login

- Navegar a: http://localhost:6081/chef/login
- Login con: `carlos.chef@cafeteria.test`
- Password: `ChangeMe!123`

### 3.2 Verificar dashboard

- Verificar que cargue correctamente
- Verificar que no aparezca DEBUG PANEL

### 3.3 Procesar orden

- **PRUEBA CRÍTICA**: Estados transicionen correctamente
  - Buscar la orden en la cocina
  - Click en "Iniciar" (Start)
  - **ESPERADO**: Orden pase a estado "En preparación"
  - **IMPACTO**: Chef ha comenzado a preparar

- Click en "Listo" (Ready)
- **ESPERADO**: Orden pase a estado "Listo para servir"
- **IMPACTO**: Orden lista para ser entregada

- Verificar que no aparezca estado "ATRASADO" sin razón

---

## PASO 4: Mesero - Entregar y Cobrar (localhost:6081)

### 4.1 Login

- Navegar a: http://localhost:6081/waiter/login
- Login con: `juan.mesero@cafeteria.test`
- Password: `ChangeMe!123`

### 4.2 Entregar orden

- Buscar la orden en el dashboard
- Click en "Entregar"
- **ESPERADO**: Orden pase a estado "Entregada"
- **IMPACTO**: Cliente ha recibido el pedido

### 4.3 Cobrar (Efectivo)

- Click en "Efectivo"
- **ESPERADO**: Se abra modal de pago
- **IMPACTO**: Proceso de cobro iniciado

- Verificar que el monto sea correcto
- Confirmar el pago

---

## PASO 5: Cajera - Verificar Pagadas (localhost:6081)

### 5.1 Login

- Navegar a: http://localhost:6081/cashier/login
- Login con: `laura.cajera@cafeteria.test`
- Password: `ChangeMe!123`

### 5.2 Verificar tab de Pagadas

- Click en tab "Pagadas"
- **ESPERADO**: Aparezca la orden en la lista

### 5.3 Verificar PDF descargable

- **PRUEBA CRÍTICA**: Generación correcta de PDF
  - Buscar botón de descarga de PDF
  - Click en botón PDF
  - **ESPERADO**: Se descargue un archivo PDF válido
  - **IMPACTO**: Cliente puede guardar comprobante

- Verificar que el PDF contenga:
  - Información del pedido
  - Monto total
  - Fecha y hora
  - Detalle de productos

### 5.4 Verificar email

- **PRUEBA CRÍTICA**: Generación correcta de email
  - Verificar que se haya enviado email de confirmación
  - **ESPERADO**: Email con asunto "Confirmación de pedido" o similar
  - **IMPACTO**: Cliente recibe confirmación

---

## PASO 6: Verificación Final

### 6.1 Verificar email

- Revisar inbox de: `luartx@gmail.com`
- **ESPERADO**: Recibir email de confirmación del pedido
- **IMPACTO**: Comunicación con cliente

### 6.2 Verificar PDF

- Abrir el PDF descargado
- **ESPERADO**: PDF sea legible y completo
- **IMPACTO**: Documentación del pedido

### 6.3 Verificar estado en Pagadas

- Verificar que la orden aparezca en tab "Pagadas"
- **ESPERADO**: Orden con estado "Pagada"
- **IMPACTO**: Registro contable

---

## PASO 7: Generar email y PDF desde Pagadas

### 7.1 Login como cajera

- Navegar a: http://localhost:6081/cashier/login
- Login con: `laura.cajera@cafeteria.test`
- Password: `ChangeMe!123`

### 7.2 Ir a tab Pagadas

- Click en tab "Pagadas"

### 7.3 Generar email desde Pagadas

- Buscar opción para reenviar email
- **ESPERADO**: Se envíe email de confirmación
- **IMPACTO**: Comunicación adicional

### 7.4 Generar PDF desde Pagadas

- Buscar opción para descargar PDF
- **ESPERADO**: Se descargue PDF del pedido
- **IMPACTO**: Documentación adicional

---

## PASO 8: Verificar DEBUG PANEL

### 8.1 Comprobar en todas las vistas

- Verificar que no aparezca DEBUG PANEL en:
  - Cliente (localhost:6080)
  - Mesero (localhost:6081/waiter)
  - Chef (localhost:6081/chef)
  - Cajera (localhost:6081/cashier)
  - Admin (localhost:6081/admin)

- **PRUEBA CRÍTICA**: No exista DEBUG PANEL en producción
- **ESPERADO**: No ver panel de debug
- **IMPACTO**: Seguridad y limpieza visual

---

## FORMATO DE REPORTES DE ERRORES

Para cada error encontrado, reportar en este formato:

```
- ERROR [SEVERIDAD]: Descripción
  - Ubicación: URL/componente
  - Impacto: usuario/sistema
  - Solución sugerida
```

### Ejemplos de severidad:

- **CRITICAL**: Error que impide completar el flujo
- **HIGH**: Error importante que afecta funcionalidad
- **MEDIUM**: Error moderado que afecta experiencia
- **LOW**: Error menor que afecta detalles

---

## CHECKLIST DE VALIDACIÓN

### Validación de campos obligatorios

- [ ] Validación de email antes de confirmar pedido
- [ ] Validación de nombre antes de confirmar pedido
- [ ] Validación de modificadores antes de agregar al carrito
- [ ] Mensajes de error claros y visibles

### Confirmación visual

- [ ] Mensaje de éxito al confirmar pedido
- [ ] Feedback de email enviado
- [ ] Feedback de pago realizado

### Generación de PDF

- [ ] PDF se descarga correctamente
- [ ] PDF contiene toda la información
- [ ] PDF es legible y bien formateado

### Generación de email

- [ ] Email se envía correctamente
- [ ] Email tiene asunto apropiado
- [ ] Email contiene información del pedido

### Estados transicionales

- [ ] Estados cambian correctamente
- [ ] No aparece "ATRASADO" sin razón
- [ ] Flujo lógico de estados se mantiene

### DEBUG PANEL

- [ ] No aparece en cliente
- [ ] No aparece en mesero
- [ ] No aparece en chef
- [ ] No aparece en cajera
- [ ] No aparece en admin

---

## NOTAS ADICIONALES

- Si algún servicio no responde, verificar que Docker esté corriendo
- Si hay errores de conexión, verificar que los puertos estén abiertos
- Si hay errores de email, verificar configuración de SMTP
- Si hay errores de PDF, verificar librería de generación de PDF

---

## INFORMACIÓN DE CUENTAS DE PRUEBA

### Cliente

- Email: luartx@gmail.com
- Nombre: Test QA User

### Mesero

- Email: juan.mesero@cafeteria.test
- Password: ChangeMe!123

### Chef

- Email: carlos.chef@cafeteria.test
- Password: ChangeMe!123

### Cajera

- Email: laura.cajera@cafeteria.test
- Password: ChangeMe!123

### Admin

- Email: admin@cafeteria.test
- Password: ChangeMe!123
