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

- [ ] `templates/` eliminado
- [ ] Sin `template_folder` en blueprints
- [ ] Sin `render_template` en routes
- [ ] Rutas de auth redirigen a pronto-static
- [ ] Tests pasan
- [ ] Smoke test de login/logout

---

## ESTADO

**ESTADO:** ABIERTO

**Archivos con problemas:** 5
**Líneas de código legacy:** ~500+

---

**ÚLTIMA ACTUALIZACIÓN:** 2026-02-09 14:00
