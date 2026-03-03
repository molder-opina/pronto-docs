# 🚨 PROBLEMA: Templates HTML en PRONTO-EMPLOYEES

**ID:** BUG-20250209-004-LEGACY-TEMPLATES
**FECHA:** 2026-02-09
**PROYECTO:** pronto-employees
**SEVERIDAD:** alta
**TITULO:** Código legacy con templates HTML viola AGENTS.md

---

## DESCRIPCIÓN

Los siguientes archivos usan `render_template()` con templates HTML locales:

| Archivo | Líneas con `render_template` | Template Folder |
|---------|------------------------------|-----------------|
| `routes/waiter/auth.py` | 62, 195 | `../../templates/waiter` |
| `routes/admin/auth.py` | ~50+ | `../../templates/admin` |
| `routes/cashier/auth.py` | ~50+ | `../../templates/cashier` |
| `routes/chef/auth.py` | ~50+ | `../../templates/chef` |
| `routes/system/auth.py` | ~50+ | `../../templates/system` |

## VIOLACIÓN

**AGENTS.md sección 8-10:**
> "Todo contenido estático es Vue y vive exclusivamente en `pronto-static`"
> "Vue se compila únicamente en build"
> "Prohibido estáticos locales en `pronto-client` / `pronto-employees`"

## IMPACTO

1. **Duplicación de frontend** - Templates HTML + Vue en pronto-static
2. **Code rot** - Templates desactualizados vs Vue
3. **Inconsistencia UI** - Diferentes renderizados
4. **Mantenimiento两份** - Cambios en 2 lugares

## SOLUCIÓN PROPUESTA

### Fase 1: Eliminar templates y referencias

```bash
# Eliminar directorios de templates
rm -rf pronto-employees/templates/

# Eliminar template_folder de blueprints
# En cada routes/*/auth.py:
-     template_folder="../../templates/waiter"
```

### Fase 2: Cambiar rutas a redirects

```python
# ANTES (routes/waiter/auth.py)
@waiter_bp.route("/login", methods=["GET"])
def login():
    return render_template("login_waiter.html")

@waiter_bp.route("/dashboard")
def dashboard():
    return render_template("dashboard.html")

# DESPUÉS
@waiter_bp.route("/login", methods=["GET"])
def login():
    # Redirect a pronto-static Vue app
    from flask import redirect
    return redirect(f"{config.STATIC_URL}/waiter/login")

@waiter_bp.route("/dashboard")
def dashboard():
    from flask import redirect
    return redirect(f"{config.STATIC_URL}/waiter/dashboard")
```

### Fase 3: Mantener solo login/logout para cookies

```python
@waiter_bp.route("/login", methods=["GET"])
def login():
    """Solo POST procesa auth. GET redirect a Vue."""
    return redirect(f"{STATIC_URL}/waiter/login")

@waiter_bp.route("/logout")
def logout():
    """Cerrar sesión y redirect."""
    # ... lógica de logout ...
    return redirect(f"{STATIC_URL}/waiter/logged-out")
```

## ARCHIVOS A MODIFICAR

1. `routes/waiter/auth.py` - Eliminar templates
2. `routes/admin/auth.py` - Eliminar templates
3. `routes/cashier/auth.py` - Eliminar templates
4. `routes/chef/auth.py` - Eliminar templates
5. `routes/system/auth.py` - Eliminar templates
6. `templates/` directory - Eliminar todo

## CHECKLIST DE VERIFICACIÓN

- [x] `templates/` por rol eliminado (queda shell único `templates/index.html`)
- [x] Sin `template_folder` en blueprints
- [x] Sin templates legacy por rol (`login_waiter.html`, `dashboard.html`, etc.)
- [x] Rutas de auth unificadas sobre shell SPA por scope (`app_context`)
- [x] Smoke test de login y carga de assets en same-origin (`/waiter/login`, `/assets/js/employees/main.js`)
- [x] Tests de employees orders en verde (`playwright-tests/employees/orders.spec.ts`)

---

## ESTADO

**ESTADO:** RESUELTO

**SOLUCIÓN APLICADA (2026-02-18):**
- Se eliminó el esquema de templates por rol y se consolidó en un único shell `pronto-employees/src/pronto_employees/templates/index.html`.
- El shell no contiene estáticos locales por rol; carga bundle compilado de Vue desde `pronto-static` (`{{ assets_js_employees }}/main.js`).
- El flujo auth/dashboard por scope (`waiter`, `chef`, `cashier`, `admin`, `system`) permanece, pero renderiza el shell SPA con `app_context` en lugar de templates duplicados.

**COMMIT:** pendiente
**FECHA_RESOLUCIÓN:** 2026-02-18

---

**ÚLTIMA ACTUALIZACIÓN:** 2026-02-18
