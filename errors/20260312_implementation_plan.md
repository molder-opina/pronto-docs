# Plan de Implementación - Sistema de Entrega Parcial y Cancelación por Item

## Regla Fundamental de Optimización para Restaurantes Pequeños/Medianos

**TODO desarrollo en PRONTO debe optimizarse para restaurantes pequeños/medianos, priorizando:**
- ✅ **Operación rápida**: Mesero cansado, cocina rápida, cuentas simples
- ✅ **Modelo fácil de mantener**: Sin sobreingeniería, código limpio y predecible  
- ✅ **Pocos bugs contables**: Consistencia financiera, sin duplicación de datos
- ✅ **Funcionalidad esencial**: Solo lo necesario, no complejidad innecesaria

**NO implementar para restaurantes pequeños/medianos:**
- ❌ Inventario automático
- ❌ Promociones complejas  
- ❌ Event sourcing
- ❌ Reconciliación financiera avanzada
- ❌ Descuentos dinámicos complejos
- ❌ Impuestos avanzados

## Checklist de Implementación (P0 - Bloqueantes)

### 1. Backend - Modelo de Datos (pronto-libs)
- [ ] **AGENTS.md P0 #22**: Actualizar scripts de migración en `pronto-scripts/init/sql/**`
- [ ] **Regla Fundamental**: Agregar solo campos esenciales (`prepared_at`, `created_at`, `price`)
- [ ] Agregar campo `prepared_at` a OrderItem model (para distinguir preparing vs ready)
- [ ] Agregar campo `created_at` a OrderItem model (para ordenar, métricas, debugging)  
- [ ] Agregar campo `price` snapshot a OrderItem model (evita problemas con cambios de precios)
- [ ] Verificar que modelo use UUID para entidades principales (AGENTS.md P0 #12.5)
- [ ] **Regla Fundamental**: No agregar campos calculados duplicados (total_amount, remaining_amount, etc.)
- [ ] Ejecutar `./pronto-scripts/bin/pronto-init-seed-review.sh` antes de commit

### 2. Backend - Lógica de Negocio (pronto-libs)
- [ ] **AGENTS.md P0 #29**: Usar `OrderStatus` y `PaymentStatus` de `pronto_shared/constants.py`
- [ ] **AGENTS.md P0 #29**: Implementar cálculo de estado derivado en `order_state_machine.py`
- [ ] **Regla Fundamental**: Estados derivados desde timestamps, no almacenados
- [ ] Actualizar reglas de cancelación con lógica explícita:
  - Instantáneos (`is_quick_serve=true`): cancelables hasta `delivered_at`
  - Preparados (`is_quick_serve=false`): cancelables solo hasta `prepared_at`
- [ ] **Regla Fundamental**: Mantener reglas simples y realistas para operación diaria
- [ ] **AGENTS.md P0 #30**: Aplicar Regla de Recurrencia - buscar patrones similares en todo el código

### 3. Backend - Servicios (pronto-api)
- [ ] **AGENTS.md P0 #12.1**: Todos los endpoints en `/api/*` servidos por `pronto-api`
- [ ] **Regla Fundamental**: Implementar protección concurrente mínima pero suficiente (`SELECT ... FOR UPDATE`)
- [ ] Implementar protección concurrente con `SELECT ... FOR UPDATE` en servicios de entrega/cancelación
- [ ] **AGENTS.md P0 #12.4.2**: Usar header `X-PRONTO-CUSTOMER-REF` para autenticación clientes
- [ ] Validar tipos de parámetros en rutas con `<uuid:id>` (AGENTS.md P0 #12.5)
- [ ] **Regla Fundamental**: Evitar validaciones complejas que ralenticen operación

### 4. Frontend - Indicadores Visuales (pronto-static)
- [ ] **AGENTS.md P0 #21.1**: Todo nuevo desarrollo frontend 100% Vue 3 Composition API
- [ ] **AGENTS.md P0 #21.4**: Prohibido manipulación DOM directa fuera de componentes Vue
- [ ] **Regla Fundamental**: UI simple y clara para meseros cansados
- [ ] Actualizar KitchenOrders.vue con estados: ⚪ queued, 🟡 preparing, 🟢 ready, 🔵 delivered, 🔴 cancelled
- [ ] Actualizar WaiterBoard.vue con mismos indicadores visuales
- [ ] Mostrar conteo "X/Y items entregados" en interfaces de empleados
- [ ] Validar que solo items 🟢 ready sean entregables/cancelables
- [ ] **Regla Fundamental**: No sobrecargar UI con información innecesaria

### 5. Frontend - Funcionalidad de Entrega (pronto-employees)
- [ ] **AGENTS.md P0 #12.4.4**: Proxy técnico scope-aware en `pronto-employees`
- [ ] **Regla Fundamental**: Funcionalidad esencial para operación diaria
- [ ] Agregar botones de entrega parcial en WaiterBoard.vue
- [ ] Implementar modal para seleccionar items específicos a entregar
- [ ] Asegurar que chef no tenga funcionalidad de entrega (solo preparación)
- [ ] Validar que cajero y admin puedan entregar para flujo de pago
- [ ] **Regla Fundamental**: Mantener flujos simples y rápidos

### 6. Migraciones y Scripts (pronto-scripts)
- [ ] **AGENTS.md P0 #20**: Crear script de migración en `pronto-scripts/init/sql/migrations/`
- [ ] **AGENTS.md P0 #22**: Sincronía obligatoria Modelo/DB/Init/Seeds
- [ ] **Regla Fundamental**: Scripts idempotentes y fáciles de mantener
- [ ] Ejecutar validación: `./pronto-scripts/bin/pronto-migrate --check`
- [ ] Ejecutar validación: `./pronto-scripts/bin/pronto-init --check`

### 7. Pruebas y Validación (pronto-tests)
- [ ] **AGENTS.md P0 #9**: Tests unitarios mínimos pero útiles
- [ ] **AGENTS.md P1 #9**: UI/E2E tests con Playwright
- [ ] **Regla Fundamental**: Probar escenarios reales de restaurantes pequeños/medianos
- [ ] Probar flujo real: burger (preparing), fries (ready), water (ready) → cancelar water
- [ ] Verificar concurrencia: 2 meseros no pueden entregar mismo item
- [ ] Validar cancelación: instantáneos vs preparados con reglas correctas
- [ ] Testear pago anticipado + entrega posterior
- [ ] Ejecutar: `cd pronto-tests && npx playwright test vue-rendering.spec.ts`

### 8. Documentación (pronto-docs)
- [ ] **AGENTS.md P1 #11**: Documentación obligatoria en `pronto-docs/<proyecto>/`
- [ ] **Regla Fundamental**: Documentación clara y útil para operación diaria
- [ ] Actualizar `pronto-docs/contracts/pronto-api/openapi.yaml`
- [ ] Crear guía de uso para empleados en `pronto-docs/features/delivery-cancellation/`
- [ ] Documentar flujos operativos reales en `pronto-docs/standards/`

### 9. Validación de Calidad (Gates Obligatorios)
- [ ] **AGENTS.md P0 #17**: Prohibido código legacy y patrones anticuados
- [ ] **AGENTS.md P0 #18**: Prohibido mezclar código Vue con manipulación DOM legacy
- [ ] **AGENTS.md P0 #21.5**: Checker canónico: `./pronto-scripts/bin/pronto-file-naming-check`
- [ ] **AGENTS.md P0 #23**: Reutilización - revisar `pronto-libs` antes de crear funcionalidad nueva
- [ ] **AGENTS.md P0 #30**: Regla de Recurrencia - validar transversalmente en todo el código
- [ ] **Regla Fundamental**: Eliminar cualquier complejidad innecesaria identificada

### 10. Auditoría y Observabilidad (P0)
- [ ] **AGENTS.md P0 #0.6.1**: Correlation ID único en todo request
- [ ] **AGENTS.md P0 #0.6.2**: Logging estructurado con `StructuredLogger`
- [ ] **AGENTS.md P0 #0.6.6**: Auditoría de acciones de negocio con `audit_action`
- [ ] **Regla Fundamental**: Auditoría suficiente para debugging, no excesiva
- [ ] Registrar todas las entregas/cancelaciones con: quién, qué, cuándo

## Checklist de Verificación Final (Pre-Commit)

### Gates Obligatorios (P0)
- [ ] **Gate A**: Arquitectura - No modificar docker-compose sin orden explícita
- [ ] **Gate B**: Seguridad - No usar `flask.session` en api/employees  
- [ ] **Gate C**: Estáticos - Todo en `pronto-static`, nada en otros repos
- [ ] **Gate D**: Roles - Solo roles canónicos: `waiter`, `chef`, `cashier`, `admin`, `system`
- [ ] **Gate E**: Tests - API tests + Playwright si hay cambios Vue
- [ ] **Gate F**: Docs - Cambio funcional sin doc = REJECTED
- [ ] **Gate G**: API Parity - Ejecutar `./pronto-scripts/bin/pronto-api-parity-check`
- [ ] **Gate H**: Order State Authority - Validar con `rg` que no haya escrituras directas
- [ ] **Gate I**: Init/Seeds Sync - Ejecutar `./pronto-scripts/bin/pronto-init-seed-review.sh`
- [ ] **Gate J**: Recurrencia Transversal - Buscar patrones similares en todo el código
- [ ] **Gate K**: Responsive Web UI - Ejecutar `./pronto-scripts/bin/pronto-responsive-check`
- [ ] **Gate L**: HTTP Client Canonical - Validar patrones HTTP correctos

### Validación de Variables de Ambiente
- [ ] **AGENTS.md P0 #10**: No hardcode secrets, usar `.env.example`
- [ ] Verificar que cada proyecto mantenga su `.env`

### Validación de Nomenclatura (P0)
- [ ] **AGENTS.md P0 #0.7**: Directorios funcionales en `kebab-case`
- [ ] **AGENTS.md P0 #0.7**: Componentes Vue en `PascalCase.vue`
- [ ] **AGENTS.md P0 #0.7**: Módulos lógica en `kebab-case.ts`
- [ ] **AGENTS.md P0 #0.7**: Python código en `snake_case.py`

## Checklist de Despliegue Seguro

### Pre-Commit Validation
- [ ] **AGENTS.md P0 #0.5.6**: Incrementar `PRONTO_SYSTEM_VERSION` en `.env`
- [ ] **AGENTS.md P0 #0.5.7**: Registrar en `pronto-docs/versioning/AI_VERSION_LOG.md`
- [ ] **AGENTS.md P0 #12.1**: Verificar que no haya endpoints fuera de `pronto-api`
- [ ] **AGENTS.md P0 #15**: Router-Hash actualizado si cambia `router.yml`

### Post-Implementation Verification
- [ ] **AGENTS.md P0 #19**: No dependencia de funcionalidad deprecated
- [ ] **AGENTS.md P0 #25**: Herramienta estándar de búsqueda: `rg`
- [ ] **AGENTS.md P0 #26**: Python deps en `requirements.txt` raíz del servicio
- [ ] **AGENTS.md P0 #29**: Autoridad Única de Transiciones de Estado respetada

## Prioridades y Riesgos

### Prioridad Alta (Bloqueantes P0)
- Modelo de datos correcto con campos `prepared_at`, `created_at`
- Cálculo derivado de estados sin inconsistencias
- Protección concurrente en operaciones críticas
- Integración completa entre entrega y cancelación
- **Regla Fundamental**: Todo optimizado para restaurante pequeño/mediano

### Riesgos a Mitigar
- **Riesgo de inconsistencia**: Estados calculados vs almacenados → Solución: solo estados derivados
- **Riesgo de concurrencia**: Doble entrega/cancelación → Solución: `FOR UPDATE` en transacciones
- **Riesgo de complejidad**: Sobreingeniería → Solución: mantener modelo mínimo para restaurante mediano/chico
- **Riesgo de regresión**: Romper flujos existentes → Solución: tests exhaustivos y validación transversal
- **Riesgo de operación lenta**: UI compleja → Solución: mantener interfaces simples y rápidas

## Criterios de Aceptación

El sistema estará listo cuando:

1. **Operación rápida**: Mesero puede entregar/cancelar items en < 2 segundos
2. **Modelo mantenible**: Código limpio, sin duplicación, siguiendo convenciones PRONTO
3. **Pocos bugs contables**: Montos siempre consistentes, sin duplicación de datos
4. **Sin sobreingeniería**: Solo funcionalidad necesaria para restaurantes medianos/chicos
5. **Todos los gates P0 pasados**: Validación completa según AGENTS.md
6. **Pruebas reales exitosas**: Flujos operativos funcionan en escenarios del mundo real
7. **Regla Fundamental cumplida**: Todo optimizado para restaurante pequeño/mediano

## Notas Específicas de Implementación

- **NO implementar**: inventario automático, promociones complejas, event sourcing, reconciliación financiera avanzada
- **Mantener simple**: Split por defecto, solo crear splits adicionales si cliente lo pide
- **Enfocar en realidad**: Mesero cansado, cocina rápida, cuentas simples
- **Validar en contexto**: Todo cambio debe probarse en flujo completo de restaurante real
- **Regla Fundamental**: Siempre preguntar "¿esto es realmente necesario para un restaurante pequeño/mediano?"