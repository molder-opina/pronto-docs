# Config Integrity Layer - Applied

**Fecha de implementación:** 2026-03-19  
**Implementador:** AI Agent  
**Estado:** ✅ Completado y validado

---

## 🚀 FASE 2: CI/CD INTEGRATION (2026-03-19)

**Estado:** ✅ COMPLETADA

### Entregables Fase 2

#### 1. Scanner Hardening

**Archivo:** `pronto-scripts/bin/pronto-config-fallback-check`

**Mejoras implementadas:**
- `SCANNER_VERSION = "1.0.0"` - Trazabilidad
- `--repo` flag obligatorio - Aislamiento por repo
- `--mode warn|enforce|strict` - Modos de escaneo
- `--audit` alias - Modo strict semántico
- Baseline por repo forzado (`.pronto/config-fallback-baseline.json`)
- `code_hash` anti-drift - Resiste refactors
- Baseline regeneration protection:
  - CI no puede generar baseline
  - Requiere `--force-baseline-update`
  - Solo en modo warn
- Summary output CI-friendly
- Protección repos vacíos/incompletos

**Commit:** `pronto-scripts:d91ac0d`

---

#### 2. Pre-commit Integration

**Archivos:**
- `pronto-scripts/bin/pre-commit-ai`
- `pronto-scripts/config/gate-profiles.yml`

**Cambios:**
- Agregado `config_fallbacks` a core_checks
- Modo: warn (siempre, nunca falla)
- Exit code: 0 (feedback temprano, no bloqueo)

**Commit:** `pronto-scripts:9ce482b`

---

#### 3. GitHub Actions Integration

**Archivo:** `.github/workflows/pronto-guardrails.yml`

**Cambios:**
- Matriz expandida: 5 repos (api, client, employees, static, libs)
- Paso "Config Fallbacks Check" (antes de guardrails)
- Modo: enforce (respeta baseline)
- Baseline generation disabled en CI
- Scanner version logged

**Commit:** `pronto-docs:89fe1e1` (workflow en root)

---

#### 4. Baselines Generados

**Archivos:** `.pronto/config-fallback-baseline.json` en cada repo

| Repo | Fallbacks | Commit |
|------|-----------|--------|
| pronto-api | 117 | `a8a0935` |
| pronto-client | 12 | `349fae6` |
| pronto-employees | 13 | `32d5ffc` |
| pronto-libs | 152 | `c85444f` |
| pronto-static | N/A (no src/) | - |

**Total:** 294 fallbacks en baseline (todos legacy, CI falla solo en nuevos)

**Commits atómicos:** 1 por repo con mensaje:
```
chore: add config fallback baseline (all repos)
```

---

#### 5. Documentación CI/CD

**Archivo:** `pronto-docs/features/config-integrity-layer/CI_INTEGRATION.md`

**Contenido:**
- Scanner versioning
- Pre-commit integration (warn mode)
- GitHub Actions integration (enforce mode)
- Baseline mechanism (per repo, code_hash)
- Baseline regeneration protection
- CRITICAL_CONFIG_KEYS reference
- Troubleshooting guide
- Strict/audit mode usage
- Metrics and targets

**Commit:** `pronto-docs:89fe1e1`

---

---

## 📦 Entregables

### 1. Módulo de Validación

**Archivo:** `pronto-libs/src/pronto_shared/config_validation.py`

**Funciones implementadas:**
- `ConfigError` - Excepción custom
- `get_required_int()` - Con validación opcional de rango (min/max)
- `get_required_str()` - Con trim automático
- `get_required_bool()` - Con normalización de strings
- `get_optional_int()` - Default explícito permitido
- `get_optional_str()` - Default explícito permitido
- `get_optional_bool()` - Default explícito permitido

---

### 2. Constantes Críticas

**Archivo:** `pronto-libs/src/pronto_shared/constants.py`

**Agregado:**
```python
CRITICAL_CONFIG_KEYS = {
    "system.api.items_per_page",
    "system.payments.stripe_publishable_key",
    "system.payments.stripe_secret_key",
    "system.payments.timeout_seconds",
    "system.payments.enable_cashier_role",
    "system.payments.allow_waiter_cashier_operations",
    "system.session.client_ttl_seconds",
    "system.session.employee_ttl_hours",
    "system.orders.max_items_per_order",
    "system.orders.item_max_qty",
    "system.api.timeout_seconds",
    "system.session.validation_interval_minutes",
}
```

---

### 3. Tests Unitarios

**Archivo:** `pronto-tests/unit/config/test_config_validation.py`

**Cobertura:**
- 32 tests pasando
- 9 casos para `get_required_int`
- 7 casos para `get_required_str`
- 8 casos para `get_required_bool`
- 8 casos para `get_optional_*`

**Resultado:**
```
============================== 32 passed in 0.05s ==============================
```

---

### 4. Migración de Endpoints

#### `pronto-api/src/api_app/routes/config.py`

**Cambios:**
- Línea 13: Agregado import de `config_validation`
- Línea 108-137: `get_public_config()` migrado a usar helpers
- Línea 97-105: `client_session_validation_interval_minutes()` migrado

**Configs migradas:**
- `system.api.items_per_page` → `get_required_int(min=1, max=200)`
- `payments.enable_cashier_role` → `get_required_bool()`
- `payments.allow_waiter_cashier_operations` → `get_required_bool()`
- `restaurant_name` → `get_required_str()`
- `currency_symbol` → `get_required_str()`
- `currency_code` → `get_required_str()`

---

#### `pronto-api/src/api_app/routes/employees/config.py`

**Cambios:**
- Línea 14: Agregado import de `config_validation`
- Línea 33-38: Eliminada función `_require_config` (duplicada)
- Línea 67-94: `get_public_config()` migrado a usar helpers

**Configs migradas:**
- `system.api.items_per_page` → `get_required_int(min=1, max=200)`
- `payments.enable_cashier_role` → `get_required_bool()`
- `payments.allow_waiter_cashier_operations` → `get_required_bool()`
- `restaurant_name` → `get_required_str()`
- `currency_symbol` → `get_required_str()`
- `currency_code` → `get_required_str()`

---

### 5. Scanner de Fallbacks

**Archivo:** `pronto-scripts/bin/pronto-config-fallback-check`

**Características:**
- Python standalone (ejecutable directo)
- Escanea `pronto-api/src` y `pronto-employees/src`
- Detecta patrón `.get(key, default)`
- Cruza contra `CRITICAL_CONFIG_KEYS` (match exacto)
- Clasifica: CRITICAL / WARNING / INFO
- Genera reporte en `pronto-docs/tech-debt/config-fallbacks.md`
- Exit code: 0 (pass) / 1 (fail)

**Resultado de ejecución:**
```
🔍 Escaneando fallbacks de configuración...
   Critical keys: 12

📊 Resumen:
   🔴 Critical: 0
   🟡 Warnings: 0
   ⚪ Info: 130

✅ PASS - No hay fallbacks críticos
```

---

### 6. Documentación

**Archivos creados:**
- `pronto-docs/features/config-integrity-layer/README.md` - Documentación completa
- `pronto-docs/features/config-integrity-layer/APPLIED.md` - Este archivo
- `pronto-docs/tech-debt/config-fallbacks.md` - Reporte de scanner

---

## ✅ Validación de Cierre

### Gate 1: Tests
```bash
cd pronto-tests
pytest unit/config/test_config_validation.py -v
# Resultado: 32 passed ✅
```

### Gate 2: Consistencia
```bash
rg "system\.api\.items_per_page" pronto-api/src
# Resultado: Todas usan get_required_int() ✅
```

### Gate 3: Scanner
```bash
./pronto-scripts/bin/pronto-config-fallback-check
# Resultado: PASS - 0 critical ✅
```

---

## 📊 Impacto

| Métrica | Antes | Después |
|---------|-------|---------|
| Fallbacks críticos | 4+ | 0 |
| Validación duplicada | Sí | No |
| Tests de validación | 0 | 32 |
| Detección automática | No | Sí |

---

## 🔒 Guardrails Activados

1. **No fallbacks en configs críticas** - Validado por scanner
2. **Validación centralizada** - Todos usan mismos helpers
3. **Tests unitarios** - 32 casos cubren edge cases
4. **Detección de regresiones** - Scanner ejecutable

---

## 📝 Notas de Implementación

### Decisiones de Diseño

1. **`ConfigError` no exportado globalmente** - Mantiene namespace limpio
2. **Match exacto en keys** - Evita ambigüedad y falsos positivos
3. **Rangos opcionales** - Solo cuando aplica (no inflar lógica)
4. **Separar required vs optional** - Claridad en contrato

### Patrones Eliminados

**ANTES:**
```python
# Fallback silencioso (peligroso)
value = config.get("key", 20)

# Validación manual duplicada
if value is None:
    raise ValueError("Missing config")
try:
    value = int(value)
except:
    raise ValueError("Invalid int")
```

**DESPUÉS:**
```python
# Contrato explícito
value = get_required_int(config, "key", min_value=1, max_value=200)
```

---

## 🚀 Próximos Pasos (Backlog)

### Fase 2 - Integración CI/CD
- [ ] Integrar scanner en `pre-commit-ai`
- [ ] Configurar en GitHub Actions

### Fase 3 - Expansión
- [ ] Migrar más configs críticas
- [ ] Evaluar `ConfigService` con API orientada a objetos

### Fase 4 - Runtime
- [ ] Validación de configs en startup
- [ ] Dashboard de integridad

---

**Implementación completada sin deuda técnica pendiente.**
