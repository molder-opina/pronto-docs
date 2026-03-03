# Auditoría Integral PRONTO - 2026-02-26 (Completa)

## Resumen Ejecutivo

| Gate | Estado | Hallazgos |
|------|--------|-----------|
| Gate H - Order State Authority | ✅ PASS | Sin asignaciones directas a workflow_status/payment_status |
| Gate C - Estáticos fuera de pronto-static | ✅ PASS | No hay .css/.js locales en pronto-client/employees |
| Gate B - flask.session en api/employees | ✅ PASS | No se usa flask.session |
| Gate D - Roles inválidos | ✅ PASS | Solo roles canónicos: waiter, chef, cashier, admin, system |
| Gate A - docker-compose* | ✅ PASS | Sin cambios no autorizados |
| Versionado PRONTO_SYSTEM_VERSION | ✅ PASS | Sincronizado (1.0217) |
| Gate CSRF | ✅ PASS | Solo excepciones válidas (/sessions/open, login endpoints) |
| Tipos de rutas UUID | ✅ PASS | WaiterCall es excepción válida (AGENTS.md 12.5) |
| DDL Runtime | ✅ PASS | Sin DROP/TRUNCATE en código de aplicación |
| Contratos API | ✅ PASS | Documentados en pronto-docs/contracts/ |

---

## Hallazgos

### ✅ Gates P0 - Todos PASS

1. **Order State Authority**: No hay asignaciones directas a workflow_status/payment_status fuera de order_state_machine.py
2. **Estáticos**: No hay CSS/JS en pronto-api, pronto-client, pronto-employees
3. **flask.session**: No se usa en api/employees
4. **Roles inválidos**: Solo waiter, chef, cashier, admin, system
5. **docker-compose**: Sin cambios no autorizados
6. **Versionado**: .env y .env.example sincronizados (1.0217)

### ⚠️ Hallazgos Menores

1. **CSRF Exempt**: 
   - `/sessions/open` (válido - AGENTS.md excepción)
   - `/waiter/auth/login`, `/chef/auth/login`, etc. (válido - login endpoints)
   
2. **Secrets en scripts**:
   - `pronto-scripts/bin/python/verify_split_bill.py:16` - PRONTO_INTERNAL_SECRET con valor por defecto
   - `pronto-scripts/bin/tests/reproduce_csrf_bff.py:33` - PRONTO_INTERNAL_SECRET con valor por defecto
   - **Estado**: ABIERTO (BUG-20260226-SEC-01)

---

## Detalle de Verificaciones

### Gate H: Order State Authority
```bash
rg "workflow_status\s*=" pronto-api/src | rg -v "order_state_machine.py"  # 0 resultados
rg "payment_status\s*=" pronto-api/src | rg -v "order_state_machine.py"   # 0 resultados
```
**Resultado**: ✅ PASS

### Gate C: Estáticos
```bash
glob pronto-api/**/*.css  # 0 resultados
glob pronto-employees/**/*.css  # 0 resultados
glob pronto-client/**/*.css  # 0 resultados
```
**Resultado**: ✅ PASS

### Gate B: flask.session
```bash
rg "flask\.session" pronto-api/src  # 0 resultados
rg "flask\.session" pronto-employees/src  # 0 resultados
```
**Resultado**: ✅ PASS

### Gate D: Roles
```bash
rg "'(manager|super_admin|guest|kiosko_user|operator)'" pronto-api/src  # 0 resultados
```
**Resultado**: ✅ PASS

### Versionado
```
.env: PRONTO_SYSTEM_VERSION=1.0217
.env.example: PRONTO_SYSTEM_VERSION=1.0217
```
**Resultado**: ✅ PASS

---

## Bugs Abiertos

| ID | Bug | Severidad | Estado |
|----|-----|-----------|--------|
| BUG-20260226-SEC-01 | Secretos hardcodeados en scripts de verificación | Alta | ABIERTO |

---

## Acciones Recomendadas

1. **BUG-20260226-SEC-01**: Remover valores por defecto de PRONTO_INTERNAL_SECRET en scripts
   - Cambiar a `os.environ.get("PRONTO_INTERNAL_SECRET")` y fallar si no está definido
   - O usar valores dummy para desarrollo

---

## Contratos y Documentación

- ✅ pronto-docs/contracts/ completo para todos los servicios
- ✅ pronto-prompts/tests/ con 24 flujos de negocio documentados
- ✅ AI_VERSION_LOG.md actualizado

---
*Auditoría ejecutada: 2026-02-26*
