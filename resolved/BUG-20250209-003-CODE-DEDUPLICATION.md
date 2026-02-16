# Deduplicación de Código y Patrones Legacy - PRONTO

**ID:** BUG-20250209-003-CODE-DEDUPLICATION
**FECHA:** 2026-02-09
**PROYECTO:** PRONTO
**SEVERIDAD:** alta
**TITULO:** Deduplicación de código y eliminación de patrones legacy
**DESCRIPCION:** Identificar y eliminar código duplicado, patrones legacy no soportados, y unificar implementaciones.

---

## 1. PROBLEMAS ENCONTRADOS

### 1.1 Duplicación de `close_session`

**Archivos afectados:**
- `pronto-api/src/api_app/routes/employees/sessions.py:200` - `close_session()`
- `pronto-libs/src/pronto_shared/services/order_service.py:2084` - `close_session()`

**Análisis:**
Ambas funciones hacen lo mismo:
1. Buscar DiningSession por ID
2. Verificar que no esté pagada
3. Cancelar todas las órdenes no canceladas
4. Cerrar la sesión

**Solución:** Unificar en `order_service.py` y que la route solo llame al servicio.

### 1.2 Duplicación de `get_session`

**Archivos afectados:**
- `pronto-libs/src/pronto_shared/db.py:160` - `get_session()` → DB session (SQLAlchemy)
- `pronto-api/src/api_app/routes/employees/sessions.py:96` - `get_session()` → Dining session
- `pronto-api/src/api_app/routes/sessions.py:17` - `get_session_ticket_pdf()`
- `pronto-client/src/pronto_clients/routes/api/payments.py:406` - `get_session_orders()`

**Análisis:**
- `db.get_session()` es el patrón correcto (DB connection)
- Las routes usan `get_session` para dining sessions → confundir con DB session

**Solución:**
- Renombrar `db.get_session()` → `get_db_session()`
- Mantener naming claro en routes: `get_dining_session()`

### 1.3 Uso de `flask.session` en pronto-client

**Archivos afectados:**
- `pronto-client/src/pronto_clients/routes/api/orders.py:9` - Importa `session`
- `pronto-client/src/pronto_clients/utils/customer_session.py:12` - Importa `session`

**Código problemático:**
```python
# pronto-client/src/pronto_clients/routes/api/orders.py
from flask import session
...
session["dining_session_id"] = ...
session["customer_ref"] = ...
```

**Problema:**
- AGENTS.md prohíbe `flask.session` excepto para `dining_session_id` y `customer_ref`
- Pero estos deben ir en Redis con TTL 60m, no en cookie session

**Solución:**
- Mover `dining_session_id` y `customer_ref` a Redis
- Usar servicio `DiningSessionService` de pronto-libs

### 1.4 Múltiples implementaciones de sesión cliente

**Archivos afectados:**
- `pronto-libs/src/pronto_shared/services/dining_session_service.py`
- `pronto-client/src/pronto_clients/utils/customer_session.py`
- `pronto-api/src/api_app/routes/client_sessions.py`
- `pronto-api/src/api_app/routes/sessions.py`

**Solución:**
- `DiningSessionService` (pronto-libs) debe ser la fuente única
- Eliminar lógica duplicada en routes

---

## 2. PLAN DE ACCIÓN

### Fase 1: Limpieza de flask.session en pronto-client

- [ ] 2.1.1 Modificar `pronto-client/src/pronto_clients/routes/api/orders.py`
  - Remover import de `session`
  - Usar `DiningSessionService` para guardar session_id
  -TTL 60m en Redis

- [ ] 2.1.2 Modificar `pronto-client/src/pronto_clients/utils/customer_session.py`
  - Cambiar `store_customer_ref()` para usar Redis
  - TTL 60m máximo

### Fase 2: Unificar close_session

- [ ] 2.2.1 Verificar que `order_service.close_session()` cubre todos los casos
- [ ] 2.2.2 Modificar `pronto-api/src/api_app/routes/employees/sessions.py`
  - Remover implementación propia
  - Llamar a `order_service.close_session()`

### Fase 3: Clarificar naming de sessions

- [ ] 2.3.1 Renombrar `db.get_session()` → `get_db_session()` (más claro)
- [ ] 2.3.2 Renombrar routes `get_session()` → `get_dining_session()`
- [ ] 2.3.3 Actualizar todos los imports

### Fase 4: Unificar DiningSessionService

- [ ] 2.4.1 Asegurar que `dining_session_service.py` tiene todos los métodos necesarios
- [ ] 2.4.2 Eliminar lógica duplicada en routes de client_sessions
- [ ] 2.4.3 Eliminar lógica duplicada en routes de sessions (api)

---

## 3. ARCHIVOS A MODIFICAR

### Modificar (6 archivos)
1. `pronto-client/src/pronto_clients/routes/api/orders.py`
2. `pronto-client/src/pronto_clients/utils/customer_session.py`
3. `pronto-api/src/api_app/routes/employees/sessions.py`
4. `pronto-api/src/api_app/routes/sessions.py`
5. `pronto-libs/src/pronto_shared/db.py`
6. `pronto-libs/src/pronto_shared/services/dining_session_service.py`

### Eliminar (0 archivos)
- Ninguno por ahora

### Crear (1 archivo)
- Script de migración para renombrar funciones

---

## 4. CRITERIOS DE ÉXITO

- [ ] Sin imports de `flask.session` en routes de orders/payments (pronto-client)
- [ ] Una sola implementación de `close_session` en `order_service.py`
- [ ] Naming claro: `get_db_session()` vs `get_dining_session()`
- [ ] TTL 60m en Redis para datos de sesión cliente
- [ ] Tests pasan después de los cambios

---

## 5. CHECKLIST DE VERIFICACIÓN

### Antes de modificar
- [ ] Backup de archivos a modificar
- [ ] Tests existentes pasan
- [ ] Documentar comportamiento actual

### Después de modificar
- [ ] ruff check pasa
- [ ] Tests pasan
- [ ] Smoke test de servicios
- [ ] Verificar flujos end-to-end

---

## ESTADO

- **Archivos por modificar:** 6
- **Problemas encontrados:** 4 patrones de duplicación
- **Fases completadas:** 0

**ESTADO:** ABIERTO

---

## NOTAS

Ver también:
- `pronto-docs/errors/20260209_missing_pii_redis_ttl.md`
- `pronto-docs/errors/20260208_customer_pii_plaintext.md`
- AGENTS.md sección 6 (PRONTO-STATIC) y 7 (PRONTO-LIBS)

---

**ÚLTIMA ACTUALIZACIÓN:** 2026-02-09 11:00
