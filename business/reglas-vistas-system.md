# Reglas de Negocio y Prompt Maestro: Vista del Sistema (System Console)

## Contexto
Esta vista es utilizada por los desarrolladores y el equipo de soporte técnico a través de `pronto-employees/system`. Es el panel de super-administrador de la plataforma Pronto, con acceso total a la infraestructura y datos.

---

## 🤖 Prompt Maestro para Desarrollo de Vista Sistema

"Actúa como un Ingeniero Senior de SRE y Seguridad de Pronto. Tu objetivo es asegurar que la consola del sistema sea la última línea de defensa y control técnico. Al trabajar en `pronto-employees/system`, debes:
1. Validar el aislamiento por scope (`active_scope == 'system'`) mediante `ScopeGuard`.
2. Asegurar que todas las acciones de mantenimiento técnico sean reversibles o generen logs exhaustivos.
3. Implementar herramientas de diagnóstico y corrección directa sobre la base de datos (DDL solo en casos excepcionales).
4. Garantizar que las mutaciones incluyan el header `X-CSRFToken` de forma obligatoria.
5. Prohibir el uso de `Flask.session` para almacenar datos de empleados; utilizar las cookies de JWT (`access_token_system`).
6. Monitorear los estados de los servicios dependientes (PostgreSQL, Redis, Supabase, Stripe)."

---

## 📋 Reglas de Negocio (Business Rules)

### 1. Mantenimiento Operativo
- **Limpieza de Sesiones**: El Sistema puede limpiar sesiones inactivas o redundantes que bloquean el flujo operativo.
- **Corrección de Datos**: Capacidad de editar transacciones, órdenes o sesiones que quedaron en estados inconsistentes (ej. una sesión pagada que sigue apareciendo como abierta).
- **Control de Webhooks**: Verificación y re-envío manual de webhooks de pago si fallaron inicialmente.

### 2. Gestión de Infraestructura
- **Health Check**: Monitoreo en tiempo real de la latencia y disponibilidad de los sub-servicios de la red de Pronto.
- **Log Viewer**: Acceso a los logs consolidados del sistema para depuración de errores reportados por usuarios.

### 3. Seguridad Global
- **Gestión de Roles Base**: Definición de los permisos canónicos de los roles (`waiter`, `chef`, etc.) que luego el Admin asigna.
- **Secretos y Configuración**: Edición de variables de entorno y parámetros de configuración global del sistema (ej. URL del API central).

---

## 🛠️ Reglas Técnicas y de Seguridad

### 1. Seguridad (Security)
- **ScopeGuard**: Todas las rutas bajo `/system/` deben validar que el JWT tenga el `active_scope: 'system'`.
- **Aislamiento Multi-Consola**: Las cookies de autenticación deben estar prefijadas como `access_token_system`.
- **RBAC Máximo**: El usuario System ignora la mayoría de los guards internos de negocio, actuando directamente sobre los modelos.

### 2. Base de Datos
- **Mantenimiento**: Solo System puede disparar procesos de "Garbage Collection" de la DB o compactación de logs.

---

## 🔄 Flujos de Servicio (Service Flows)

1. **Flujo de Corrección de Sesión**:
   Recibir reporte de error -> Buscar Sesión ID -> Inspeccionar Estados (Inconsistent) -> Seleccionar Estado Corrector -> Guardar -> Notificar cambio -> Verificar integridad.
2. **Flujo de Auditoría de Pagos**:
   Admin reporta discrepancia -> System revisa Logs de Transacción vs Respuestas de API de Pago -> Identificar Webhook no procesado -> Ejecutar Re-Sincronización manual -> Notificar a Caja.
3. **Flujo de Backup**:
   Acceder a Panel de Backups -> Seleccionar Puntos de Referencia -> Disparar Backup manual pre-despliegue -> Verificar éxito en S3/GCS.
