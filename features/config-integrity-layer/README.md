# Config Integrity Layer

**Fecha:** 2026-03-19  
**Estado:** ✅ Implementado  
**Prioridad:** P0 - Infraestructura crítica

---

## 📋 Resumen

Capa de validación de configuración centralizada para eliminar fallbacks silenciosos en configs críticas del sistema.

---

## 🎯 Objetivo

Eliminar una categoría completa de bugs causados por:
- Fallbacks silenciosos (`config.get(key, default)`)
- Validación inconsistente entre servicios
- Tipos de datos inválidos no detectados
- Ausencia de configs críticas no detectada

---

## 🏗️ Arquitectura

### Componentes

1. **`pronto_shared.config_validation`** - Helpers centralizados
2. **`CRITICAL_CONFIG_KEYS`** - Lista de configs que NO permiten fallback
3. **`pronto-config-fallback-check`** - Scanner de regresiones

---

## 📁 Archivos

### Nuevos

| Archivo | Propósito |
|---------|-----------|
| `pronto-libs/src/pronto_shared/config_validation.py` | Helpers de validación |
| `pronto-tests/unit/config/test_config_validation.py` | Tests unitarios (32 casos) |
| `pronto-scripts/bin/pronto-config-fallback-check` | Scanner de fallbacks |
| `pronto-docs/tech-debt/config-fallbacks.md` | Reporte de hallazgos |

### Modificados

| Archivo | Cambio |
|---------|--------|
| `pronto-libs/src/pronto_shared/constants.py` | Agregado `CRITICAL_CONFIG_KEYS` |
| `pronto-api/src/api_app/routes/config.py` | Migrado a usar helpers |
| `pronto-api/src/api_app/routes/employees/config.py` | Migrado a usar helpers |

---

## 🔧 Helpers Disponibles

### Required (fallan si ausente/inválido)

```python
from pronto_shared.config_validation import (
    ConfigError,
    get_required_int,
    get_required_str,
    get_required_bool,
)

# Entero con validación de rango opcional
value = get_required_int(config, "key", min_value=1, max_value=200)

# String (trim automático)
value = get_required_str(config, "key")

# Booleano (normaliza strings: "true"/"1"/"yes" → True)
value = get_required_bool(config, "key")
```

### Optional (default EXPLÍCITO permitido)

```python
from pronto_shared.config_validation import (
    get_optional_int,
    get_optional_str,
    get_optional_bool,
)

# Default explícito (permitido para configs no críticas)
value = get_optional_int(config, "key", default=10)
```

---

## 📊 CRITICAL_CONFIG_KEYS

Lista inicial de configs que **NO permiten fallback**:

```python
CRITICAL_CONFIG_KEYS = {
    # PAGINACIÓN
    "system.api.items_per_page",
    
    # PAGOS
    "system.payments.stripe_publishable_key",
    "system.payments.stripe_secret_key",
    "system.payments.timeout_seconds",
    "system.payments.enable_cashier_role",
    "system.payments.allow_waiter_cashier_operations",
    
    # SESIÓN
    "system.session.client_ttl_seconds",
    "system.session.employee_ttl_hours",
    
    # LÍMITES OPERATIVOS
    "system.orders.max_items_per_order",
    "system.orders.item_max_qty",
    
    # TIMEOUTS CRÍTICOS
    "system.api.timeout_seconds",
    "system.session.validation_interval_minutes",
}
```

---

## 🧪 Tests

### Ejecución

```bash
cd pronto-tests
source ../pronto-libs/.venv/bin/activate
pytest unit/config/test_config_validation.py -v
```

### Cobertura

- ✅ `get_required_int`: 9 casos (valid, string, missing, none, invalid, min, max, range, trimmed)
- ✅ `get_required_str`: 7 casos (valid, trimmed, missing, empty, whitespace, non-string)
- ✅ `get_required_bool`: 8 casos (bool true/false, string variants, missing, invalid)
- ✅ `get_optional_*`: 8 casos (present, missing, invalid)

**Total:** 32 tests pasando

---

## 🔍 Scanner

### Uso

```bash
./pronto-scripts/bin/pronto-config-fallback-check
```

### Output

```
🔍 Escaneando fallbacks de configuración...
   Root: /Users/molder/projects/github-molder/pronto
   Critical keys: 12

   Escaneando: pronto-api/src
   Escaneando: pronto-employees/src

📊 Resumen:
   🔴 Critical: 0
   🟡 Warnings: 0
   ⚪ Info: 130

📄 Reporte generado: pronto-docs/tech-debt/config-fallbacks.md

✅ PASS - No hay fallbacks críticos
```

### Exit Codes

- `0`: No hay fallbacks críticos
- `1`: Se detectaron fallbacks críticos (CI/CD fail)

---

## 📈 Métricas de Impacto

| Métrica | Antes | Después |
|---------|-------|---------|
| Fallbacks en config crítica | 4+ | 0 |
| Validación inconsistente | Sí | No |
| Tests de validación | 0 | 32 |
| Detección de regresiones | Manual | Automática |

---

## 🚦 Validación de Cierre

### Gate Obligatorio

```bash
# Verificar que TODAS las ocurrencias usan helper
rg "system\.api\.items_per_page" pronto-api/src

# Ejecutar tests
pytest unit/config/test_config_validation.py -v

# Ejecutar scanner
./pronto-scripts/bin/pronto-config-fallback-check
```

### Criterios de Aceptación

- ✅ Helpers creados y testeados
- ✅ `CRITICAL_CONFIG_KEYS` definida
- ✅ Scanner ejecutable
- ✅ Fallbacks eliminados en configs críticas
- ✅ Tests pasan (0 fallos)
- ✅ Reporte generado

---

## 🔮 Próximos Pasos (Backlog)

### Fase 2 (PR siguiente)

- [ ] Integrar scanner en `pre-commit-ai`
- [ ] Expandir `CRITICAL_CONFIG_KEYS` según necesidad
- [ ] Migrar más configs a usar helpers

### Futuro

- [ ] `ConfigService` con API tipo `config.get_required_int("key")`
- [ ] Validación de configs en runtime (startup check)
- [ ] Dashboard de integridad de configuración

---

## 📝 Referencias

- `pronto-docs/tech-debt/config-fallbacks.md` - Reporte de scanner
- `pronto-tests/unit/config/test_config_validation.py` - Tests unitarios
- `pronto-scripts/bin/pronto-config-fallback-check` - Scanner script
