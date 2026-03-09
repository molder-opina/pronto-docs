# Plan de Retiro: TEMP_REDIS_FALLBACK

## Contexto

El `TEMP_REDIS_FALLBACK` es un mecanismo de fallback en `dining_session_service_impl.py` que permite guardar datos de cliente en la tabla `Customer` de PostgreSQL cuando Redis no está disponible.

### Ubicación del código
- `pronto-libs/src/pronto_shared/services/dining_session_service_impl.py`
  - Línea 114: `notes="TEMP_REDIS_FALLBACK"` (creación)
  - Línea 178: Verificación `customer.notes == "TEMP_REDIS_FALLBACK"` (lectura)
  - Línea 208: Verificación `customer.notes == "TEMP_REDIS_FALLBACK"` (limpieza)

### Funcionamiento actual
1. **Store (líneas 102-121)**: Si Redis no está disponible, crea un registro en `pronto_customers` con marca `notes="TEMP_REDIS_FALLBACK"`
2. **Get (líneas 172-187)**: Primero intenta Redis, si falla busca en DB con marca `TEMP_REDIS_FALLBACK`
3. **Clear (líneas 202-212)**: Limpia tanto Redis como registros con marca `TEMP_REDIS_FALLBACK`

---

## Problemas Identificados

1. **Violación de principios**: Guardar datos efímeros de sesión en la tabla de clientes persistentes
2. **Campo `notes` usado incorrectamente**: Es un campo de negocio, no debería usarse como marker técnico
3. **Sin TTL en DB**: Los registros en DB no expiran automáticamente (a diferencia de Redis)
4. **Riesgo de acumulación**: Registros huérfanos si Redis vuelve y nunca se limpian

---

## Plan de Retiro

### Fase 1: Monitoreo y Limpieza (Inmediata)
- [ ] Crear script de limpieza para eliminar registros huérfanos con `notes = 'TEMP_REDIS_FALLBACK'` mayores a 24h
- [ ] Agregar logging cuando se usa el fallback (actualmente solo warning genérico)
- [ ] Crear métrica/alerta cuando Redis no está disponible

### Fase 2: Eliminación Progresiva (Semana 2)
- [ ] Hacer el fallback opcional via config: `system.customer_ref.redis_fallback_enabled = false`
- [ ] En producción, deshabilitar el fallback (forzar que Redis sea requerido)
- [ ] Si Redis falla, retornar error explícito en lugar de fallback silencioso

### Fase 3: Remoción Completa (Semana 3-4)
- [ ] Eliminar código de fallback en `store_customer_ref`
- [ ] Eliminar búsqueda en DB en `get_customer_ref`
- [ ] Eliminar limpieza de markers en `clear_customer_ref`
- [ ] Eliminar campo `notes` como marker técnico
- [ ] Crear script de limpieza final para eliminar registros `TEMP_REDIS_FALLBACK` restantes

---

## Criterios de Éxito

- [ ] **Sin uso en producción**: Métricas muestran 0 uso del fallback
- [ ] **Redis 100% disponible**: Health checks de Redis confiables
- [ ] **Código limpio**: Eliminado todo código relacionado con el fallback
- [ ] **Datos limpiados**: Tabla `pronto_customers` sin registros con `notes = 'TEMP_REDIS_FALLBACK'`

---

## Fallback Strategy Alternativa

Si en el futuro se necesita resiliencia ante fallos de Redis:
- **NO** usar la tabla de clientes como fallback
- Crear tabla específica `customer_refs` con TTL automático o job de limpieza
- O usar otro storage efímero (Memcached, etc.)

---

## Responsable
TBD

## Fecha Target
TBD (depende de estabilidad de Redis en producción)
