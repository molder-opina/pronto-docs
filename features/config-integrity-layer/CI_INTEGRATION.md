# Config Integrity - CI/CD Integration

## Overview

El scanner de fallbacks se ejecuta automáticamente en:
1. **Pre-commit** (local) - modo warn, nunca bloquea
2. **GitHub Actions** (CI) - modo enforce, falla si hay fallbacks NUEVOS

## Scanner Version

```
SCANNER_VERSION = "1.0.0"
```

La versión se muestra en todos los outputs para trazabilidad.

---

## Pre-commit Hook

### Configuración

El scanner se ejecuta automáticamente en cada commit como parte de `pre-commit-ai`:

```bash
# Modo local (warn - no bloquea)
./pronto-scripts/bin/pre-commit-ai
```

### Comportamiento

- **Modo**: `warn` (siempre)
- **Exit code**: 0 (nunca falla local)
- **Output**: Muestra warnings pero permite commit

### Interpretar output

```
🔍 Config Fallback Scanner v1.0.0
   Repo:           pronto-api
   Mode:           warn
   Baseline:       loaded (12 entries)

⚠️  WARN - Fallbacks detected (CI will enforce)
```

**Acción requerida:** Si ves un fallback crítico nuevo, migrar a `get_required_*()` del helper ANTES de hacer push.

### Resolver fallback

**ANTES (incorrecto):**
```python
value = config.get("system.api.items_per_page", 20)
```

**DESPUÉS (correcto):**
```python
from pronto_shared.config_validation import get_required_int
config_map = get_config_map(["system.api.items_per_page"])
value = get_required_int(config_map, "system.api.items_per_page", min_value=1, max_value=200)
```

---

## GitHub Actions

### Workflow

El scanner corre en `pronto-guardrails.yml` en:
- Pull requests a `main` / `develop`
- Push a `main` / `develop`

### Matriz de Repos

```yaml
matrix:
  repo: [pronto-api, pronto-client, pronto-employees, pronto-static, pronto-libs]
```

Cada repo se escanea independientemente.

### Modos del Scanner

| Modo | Baseline | Falla | Cuándo |
|------|----------|-------|--------|
| `warn` | Respeta | Nunca | Pre-commit local |
| `enforce` | Respeta | Solo nuevos | CI normal |
| `strict` / `--audit` | Ignora | Todos | Auditoría / pre-release |

### Fallos del build

Si el scanner detecta fallbacks críticos NUEVOS:

```
🔴 CRITICAL - New fallbacks en config crítica:
  pronto-api/src/api_app/routes/config.py:135
     Key: system.api.items_per_page
     Default: 20

==================================================
     CONFIG FALLBACK SCAN SUMMARY
==================================================
Repo:           pronto-api
Scanner:        v1.0.0
Mode:           enforce
Baseline:       loaded (12 entries)
--------------------------------------------------
New Criticals:  1
Baseline Size:  12
Total Scanned:  63 files
==================================================
❌ FAIL - New critical fallbacks detected
```

El job `guardrails-static` falla y el PR no se puede mergeear.

### Fix en PR

1. Identificar archivo/línea en logs de GitHub
2. Hacer commit con fix (migrar a helper)
3. Push al PR
4. GitHub Actions re-ejecuta automáticamente

---

## Baseline Mechanism

### ¿Qué es el baseline?

El baseline es un "contrato de deuda existente" que permite:
- ✅ Fallar solo en fallbacks NUEVOS (regresiones)
- ✅ Permitir deuda legacy (mientras se fixea gradualmente)
- ✅ Resistir refactors (usa code_hash, no solo línea)

### Estructura

```
pronto-api/.pronto/config-fallback-baseline.json
pronto-client/.pronto/config-fallback-baseline.json
pronto-employees/.pronto/config-fallback-baseline.json
pronto-static/.pronto/config-fallback-baseline.json
pronto-libs/.pronto/config-fallback-baseline.json
```

### Contenido del baseline

```json
{
  "generated_at": "2026-03-19T23:06:59.583562",
  "scanner_version": "1.0.0",
  "repo": "pronto-api",
  "fallbacks": [
    {
      "file": "src/api_app/routes/payments.py",
      "line": 144,
      "key": "tip_amount",
      "default": "0",
      "code_hash": "1ebbe91eda8eea1a038d875e17b6ae8af7527b13f372d98d9451da2dfb8e132f",
      "repo": "pronto-api"
    }
  ]
}
```

**code_hash:** Hash del contexto (3 líneas antes + después). Resiste cambios de línea por refactors.

### Generar baseline

```bash
# Solo local (CI bloquea generación)
./pronto-scripts/bin/pronto-config-fallback-check \
  --repo pronto-api \
  --generate-baseline \
  --force-baseline-update

# Revisar cambios
git diff .pronto/config-fallback-baseline.json

# Commit atómico (todos los repos)
git add .pronto/
git commit -m "chore: add config fallback baseline (all repos)"
```

### Protección contra regeneración irresponsable

**Bloqueos:**
1. ❌ CI no puede generar baseline (`CI=true` → error)
2. ❌ Requiere `--force-baseline-update` explícito
3. ❌ Solo en modo `warn`

**Workflow correcto:**
```bash
# ✅ CORRECTO: Generar local, revisar, commit
./pronto-scripts/bin/pronto-config-fallback-check \
  --repo pronto-api \
  --generate-baseline \
  --force-baseline-update

git diff .pronto/config-fallback-baseline.json
git commit -m "chore: update baseline"

# ❌ INCORRECTO: Intentar en CI (bloqueado)
# CI falla si intentas --generate-baseline
```

### Actualizar baseline

Cuando se fixea un fallback:

1. Fixear el fallback (migrar a helper)
2. Regenerar baseline (local)
3. Commit del baseline actualizado

```bash
# Después de fixear fallbacks
./pronto-scripts/bin/pronto-config-fallback-check \
  --repo pronto-api \
  --generate-baseline \
  --force-baseline-update

git add .pronto/config-fallback-baseline.json
git commit -m "chore: update baseline after fixing payments fallbacks"
```

---

## CRITICAL_CONFIG_KEYS

Lista actual de configs que NO permiten fallback:

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

**Fuente:** `pronto-libs/src/pronto_shared/constants.py`

---

## Troubleshooting

### Falso positivo

Si el scanner reporta un fallback que crees que es válido:

1. Verificar si la key está en `CRITICAL_CONFIG_KEYS`
2. Si no está, es warning (no bloquea en CI)
3. Si está, migrar a helper

### Scanner no encuentra baseline

```
Baseline: not found (will create on first run)
```

**Solución:**
```bash
# Generar baseline inicial
./pronto-scripts/bin/pronto-config-fallback-check \
  --repo pronto-api \
  --generate-baseline \
  --force-baseline-update
```

### Baseline corrupto

```
⚠️  Warning: Could not load baseline
```

**Solución:**
```bash
# Regenerar baseline
./pronto-scripts/bin/pronto-config-fallback-check \
  --repo pronto-api \
  --generate-baseline \
  --force-baseline-update
```

### CI falla inesperadamente

1. Revisar logs para ver qué fallback crítico se detectó
2. Fixear el fallback
3. Push al PR
4. CI re-ejecuta

### Fallbacks legacy que quiero mantener temporalmente

**Opción A:** Actualizar baseline
```bash
# Agregar al baseline (local)
./pronto-scripts/bin/pronto-config-fallback-check \
  --repo pronto-api \
  --generate-baseline \
  --force-baseline-update
```

**Opción B:** Strict mode para auditoría
```bash
# Ver TODOS los fallbacks (ignora baseline)
./pronto-scripts/bin/pronto-config-fallback-check \
  --repo pronto-api \
  --mode strict
```

---

## Strict Mode / Audit

### Cuándo usar

- 📋 Sprints de deuda técnica
- 🔍 Auditorías de código
- 🚀 Pre-release checks
- 🧹 Limpieza de baseline

### Comandos

```bash
# Modo strict
./pronto-scripts/bin/pronto-config-fallback-check \
  --repo pronto-api \
  --mode strict

# Alias audit (más legible)
./pronto-scripts/bin/pronto-config-fallback-check \
  --repo pronto-api \
  --audit
```

### Output

```
Mode:           strict
Baseline:       not found
--------------------------------------------------
New Criticals:  5
...
❌ FAIL - Critical fallbacks detected (strict mode)
```

---

## Métricas

### Después de implementar (medir a 1 semana)

| Métrica | Target |
|---------|--------|
| Builds rotos por scanner | < 5% primera semana |
| Fallbacks nuevos detectados | > 0 (previene bugs) |
| Falsos positivos | 0 |
| Tiempo adicional CI | < 15 segundos |
| Baseline shrink rate | -10%/semana |

---

## Referencias

- `pronto-scripts/bin/pronto-config-fallback-check` - Scanner script
- `pronto-libs/src/pronto_shared/constants.py` - CRITICAL_CONFIG_KEYS
- `pronto-libs/src/pronto_shared/config_validation.py` - Validation helpers
- `.github/workflows/pronto-guardrails.yml` - GitHub Actions workflow
- `pronto-docs/features/config-integrity-layer/README.md` - Documentación principal
