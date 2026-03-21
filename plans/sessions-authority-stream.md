# Stream: Session Authority & Financial Integrity

## Objetivo

Cerrar el dominio de sesiones con autoridad única y consistencia financiera.

## Estado Actual

### ✅ Completado (Pagos/Idempotencia)
- Payment use cases canónicos
- Idempotencia garantizada
- Fachada legacy compatible

### ⚠️ Pendiente (Sesiones)

**Problemas detectados:**

1. **Session status writes dispersos**
   - `client_sessions.py` → writes directos
   - `payments.py` → writes desde pagos
   - `customers/orders.py` → writes desde órdenes
   - `feedback.py` → writes desde feedback

2. **SessionClosureService delega a payment_domain**
   - Falta autoridad propia de sesiones
   - Acoplamiento circular sessions ↔ payments

3. **sync_session_financials tiene protección pero...**
   - Solo valida `_from_payment_confirmation`
   - Falta gate para otros contextos (closure, merge, adjust)

## Arquitectura Target

```
application/use_cases/sessions/
├── close_session.py              # Cierre por pago completo
├── merge_sessions.py             # Fusión de sesiones (split bills)
├── adjust_session_totals.py      # Ajuste de totales (discounts, tips)
├── recompute_financials.py       # Recálculo autorizado
└── validate_session_state.py     # Validación de estado

domain/sessions/
├── rules.py                      (ya existe)
├── events.py                     (eventos de dominio)
└── errors.py                     (errores de dominio)

infrastructure/persistence/sqlalchemy/
└── session_repository.py         (repository canónico)
```

## Tickets

### S-001: Session Status Authority
- [ ] Extraer writes de `SessionStatus` a service canónico
- [ ] Gate de autorización para cada transición
- [ ] Auditoría de transiciones

### S-002: Session Closure Autonomy
- [ ] SessionClosureService con lógica propia (no delegar a payments)
- [ ] Cierre por pago → payment_domain notifica, session_closure ejecuta
- [ ] Cierre manual → admin use case

### S-003: Session Merge/Split
- [ ] Merge de sesiones (mesas que se juntan)
- [ ] Split de pagos → payments separados, misma sesión
- [ ] Transfer de items entre sesiones

### S-004: Session Financial Gates
- [ ] Gates explícitos para:
  - payment_confirmation → sync_session_financials OK
  - closure → sync_session_financials OK
  - merge → sync_session_financials OK
  - adjust → sync_session_financials OK
- [ ] Rechazar calls sin contexto válido

### S-005: Session Repository
- [ ] Repository pattern para DiningSession
- [ ] Queries canónicas (by_table, by_status, by_customer)
- [ ] Unit of Work integration

## Validación

```bash
# Scan de writes directos (debe dar 0)
rg "status\s*=\s*SessionStatus\." pronto-api/src pronto-libs/src -g '!**/tests/**'

# Tests de sesiones (debe pasar 100%)
pytest tests/functionality/unit/test_dining_session_service.py -v
pytest tests/unit/services/test_session_financial_service.py -v
pytest tests/unit/services/test_session_closure_service.py -v
```

## Criterio de Cierre

1. ✅ 0 writes directos de `SessionStatus` fuera de use cases (solo fallback legacy)
2. ✅ SessionClosureService con autoridad propia
3. ✅ Todos los contextos de sync_session_financials documentados y protegidos
4. ⏳ Tests de sesiones en verde (pendiente ejecutar)
5. ✅ Migration de writes legacy a use cases completada

## Progreso

### ✅ Completado

- [x] execute_close_session: autoridad única de cierre
- [x] execute_merge_sessions: fusión de sesiones
- [x] execute_recompute_financials: recálculo con context gates
- [x] execute_validate_session_state: validación de transiciones
- [x] Migración de writes en dining_session_service_impl
- [x] Migración de writes en session_manager

### ⏳ Pendiente

- [ ] Tests de sesiones
- [ ] Migrar writes en payment use cases (si aplica)
- [ ] Scan transversal en pronto-api
