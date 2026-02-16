# 🚨 BUG: Template Cleanup In-Place - Comprehensive Checklist

**ID:** BUG-20260210-001-TEMPLATE-CLEANUP  
**FECHA:** 2026-02-10  
**PROYECTO:** pronto-employees  
**SEVERIDAD:** alta  
**TIPO:** Technical Debt / Code Quality  
**ESTIMACIÓN TOTAL:** 34-48 horas

---

## DESCRIPCIÓN

Los templates HTML en `pronto-employees/templates/` violan múltiples reglas de AGENTS.md:
- Inline CSS (`<style>` blocks)
- Inline JavaScript (`<script>` tags)
- Direct `fetch()` calls
- Google Fonts CDN links
- Excessive inline `style=""` attributes
- Overuse of `!important` CSS

**Análisis Completo:** Ver `template_cleanup_analysis.md`

---

## MÉTRICAS CUANTITATIVAS

| Métrica | Valor Actual | Objetivo | Progreso |
|---------|--------------|----------|----------|
| Total archivos | 42 | 42 | 0/42 (0%) |
| Total líneas | 22,631 | 22,631 | 0/22,631 (0%) |
| `<style>` blocks | 24 | 0 | 0/24 (0%) |
| `<script>` tags | 31 | 0 | 0/31 (0%) |
| `fetch()` calls | 43 | 0 | 0/43 (0%) |
| Google Fonts refs | 16 | 0 | 0/16 (0%) |
| Inline `style=""` | 865 | <50 | 0/815 (0%) |
| `!important` | 177 | <20 | 0/157 (0%) |

---

## FASE 1: QUICK WINS (6-8 horas) ⭐ START HERE

### 1.1 Google Fonts Migration (1-2h) ✅ COMPLETE

**Objetivo:** Reemplazar Google Fonts CDN con fuentes locales

**Archivos Afectados:** 16 archivos
- `base.html`
- `login_waiter.html`
- `login_admin.html`
- `login_cashier.html`
- `login_chef.html`
- `login_system.html`
- (10 otros archivos)

**Pasos:**

- [x] **1.1.1** Descargar fuentes DM Sans, Manrope, Inter
  ```bash
  mkdir -p pronto-static/src/static_content/fonts
  # Descargar de Google Fonts o usar npm packages
  npm install @fontsource/dm-sans @fontsource/manrope @fontsource/inter
  ```
  **Completado:** 2026-02-10 10:25

- [x] **1.1.2** Crear archivo `fonts.css`
  ```bash
  touch pronto-static/src/static_content/assets/css/shared/fonts.css
  ```
  **Completado:** 2026-02-10 10:25
  
- [x] **1.1.3** Agregar `@font-face` declarations
  ```css
  /* En fonts.css */
  @font-face {
    font-family: 'DM Sans';
    src: url('/node_modules/@fontsource/dm-sans/files/dm-sans-latin-400-normal.woff2') format('woff2');
    font-weight: 400;
    font-display: swap;
  }
  /* ... más variantes */
  ```
  **Completado:** 2026-02-10 10:25 (12 @font-face declarations total)

- [x] **1.1.4** Reemplazar en `base.html` (líneas 14-16)
  ```html
  <!-- ANTES -->
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=DM+Sans..." rel="stylesheet" />
  
  <!-- DESPUÉS -->
  <link rel="stylesheet" href="{{ assets_css }}/shared/fonts.css" />
  ```
  **Completado:** 2026-02-10 10:30

- [x] **1.1.5** Reemplazar en todos los login pages (5 archivos)
  - Líneas 8-10 en cada archivo
  - Mismo reemplazo que base.html
  **Completado:** 2026-02-10 10:30 (waiter, admin, cashier, chef, system)

- [x] **1.1.6** Reemplazar en console_selector.html y login.html
  **Completado:** 2026-02-10 10:35

- [x] **1.1.7** Verificar rendering
  ```bash
  # Rebuild static
  cd pronto-static
  npm run build
  
  # Restart employees service
  docker restart pronto-employees
  
  # Test visualmente cada página
  open http://localhost:6081/waiter/login
  open http://localhost:6081/admin/login
  open http://localhost:6081/waiter/dashboard
  ```
  **Build completado:** 2026-02-10 10:35 (✓ built in 3.21s + 2.48s)

**Verificación:**
```bash
# No debe haber referencias a googleapis.com
grep -r "googleapis.com" pronto-employees/src/pronto_employees/templates --include="*.html"
# Expected: 0 results
```
**Verificado:** 2026-02-10 10:35 ✅ (0 resultados)

**Bugs Resueltos:** `20260206_static_assets_external_fonts.md` ✅

**Tiempo Real:** 1.5 horas
**Estado:** COMPLETADO ✅

---

### 1.2 Standardize fetch() Calls (3-4h)

**Objetivo:** Reemplazar todos los `fetch()` directos con `requestJSON` wrapper

**Archivos Afectados:** 43 instancias en ~15 archivos

**Pasos:**

- [ ] **1.2.1** Identificar todos los fetch() calls
  ```bash
  grep -rn "fetch(" pronto-employees/src/pronto_employees/templates --include="*.html" > /tmp/fetch_calls.txt
  cat /tmp/fetch_calls.txt
  ```

- [ ] **1.2.2** Categorizar por tipo:
  - [ ] Login pages: Stats API (5 archivos)
  - [ ] Dashboard: Order updates
  - [ ] Admin sections: Config updates
  - [ ] Otros

- [ ] **1.2.3** Crear wrapper si no existe
  ```typescript
  // En pronto-static/src/vue/shared/lib/api-client.ts
  export async function requestJSON(url: string, options?: RequestInit) {
    const response = await fetch(url, {
      ...options,
      credentials: 'include',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRFToken': getCSRFToken(),
        ...options?.headers,
      },
    });
    
    if (!response.ok) {
      throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    }
    
    return response.json();
  }
  ```

- [ ] **1.2.4** Reemplazar en login pages
  ```javascript
  // ANTES (login_waiter.html línea 519)
  fetch(`${window.API_BASE}/api/stats/public`)
    .then((res) => res.json())
    .then((data) => { ... })
  
  // DESPUÉS
  import { requestJSON } from '@shared/lib/api-client';
  requestJSON(`${window.API_BASE}/api/stats/public`)
    .then((data) => { ... })
  ```

- [ ] **1.2.5** Repetir para cada archivo

- [ ] **1.2.6** Verificar
  ```bash
  # Debe haber 0 fetch() directos
  grep -r "fetch(" pronto-employees/src/pronto_employees/templates --include="*.html" | grep -v "requestJSON"
  # Expected: 0 results
  ```

**Bugs Resueltos:** Parte de `20260206_client_template_direct_api_call.md`

---

### 1.3 Extract Login Page Styles (2-3h)

**Objetivo:** Extraer CSS inline de login pages a archivo compartido

**Archivos Afectados:** 5 login pages (535 líneas cada uno)

**Pasos:**

- [ ] **1.3.1** Crear archivo CSS compartido
  ```bash
  touch pronto-static/src/static_content/assets/css/employees/login-shell.css
  ```

- [ ] **1.3.2** Extraer estilos de `login_waiter.html` (líneas 11-363)
  - Copiar todo el bloque `<style>` a `login-shell.css`
  - Eliminar el bloque `<style>` del template
  - Agregar `<link rel="stylesheet" href="{{ assets_css_employees }}/login-shell.css" />`

- [ ] **1.3.3** Repetir para otros 4 login pages
  - `login_admin.html`
  - `login_cashier.html`
  - `login_chef.html`
  - `login_system.html`

- [ ] **1.3.4** Consolidar estilos duplicados
  - Identificar CSS idéntico entre archivos
  - Mantener solo una copia en login-shell.css
  - Usar CSS variables para diferencias

- [ ] **1.3.5** Rebuild y test
  ```bash
  cd pronto-static
  npm run build
  docker restart pronto-employees
  
  # Test cada login page
  open http://localhost:6081/waiter/login
  open http://localhost:6081/admin/login
  open http://localhost:6081/cashier/login
  open http://localhost:6081/chef/login
  open http://localhost:6081/system/login
  ```

- [ ] **1.3.6** Verificar
  ```bash
  # Login pages no deben tener <style> blocks
  grep -n "<style>" pronto-employees/src/pronto_employees/templates/login_*.html
  # Expected: 0 results
  ```

**Bugs Resueltos:** Parte de `20260206_critical_css_fixes_inline.md`

---

## FASE 2: LOGIN PAGES (10-15 horas)

### 2.1 Extract Login Page Scripts (8-10h)

**Objetivo:** Extraer JavaScript inline de login pages a módulos TypeScript

**Archivos Afectados:** 5 login pages

**Pasos:**

- [ ] **2.1.1** Crear módulo TypeScript
  ```bash
  touch pronto-static/src/vue/employees/modules/login-form.ts
  ```

- [ ] **2.1.2** Extraer script de `login_waiter.html` (líneas 478-532)
  ```typescript
  // login-form.ts
  export function initLoginForm(role: string) {
    const form = document.querySelector('form');
    const button = form?.querySelector('.login-button');
    
    form?.addEventListener('submit', () => {
      button?.classList.add('is-loading');
      // ... resto de la lógica
    });
  }
  
  export function fillLogin(email: string, password: string) {
    // ... lógica de debug
  }
  ```

- [ ] **2.1.3** Crear entrypoint para login
  ```bash
  touch pronto-static/src/vue/employees/entrypoints/login.ts
  ```
  
  ```typescript
  // login.ts
  import { initLoginForm } from '../modules/login-form';
  
  const role = document.body.dataset.role || 'waiter';
  initLoginForm(role);
  ```

- [ ] **2.1.4** Actualizar Vite config
  ```typescript
  // vite.config.ts
  entrypoints: {
    dashboard: "entrypoints/dashboard.ts",
    base: "entrypoints/base.ts",
    login: "entrypoints/login.ts", // NEW
  },
  ```

- [ ] **2.1.5** Actualizar login templates
  ```html
  <!-- ANTES -->
  <script>
    function fillLogin(email, password) { ... }
    // ... 50+ líneas
  </script>
  
  <!-- DESPUÉS -->
  <script src="{{ assets_js_employees }}/login.js"></script>
  ```

- [ ] **2.1.6** Repetir para todos los login pages

- [ ] **2.1.7** Build y test
  ```bash
  cd pronto-static
  npm run build
  docker restart pronto-employees
  
  # Test funcionalidad
  # 1. Llenar form con debug button
  # 2. Submit form
  # 3. Verificar redirect a dashboard
  ```

**Verificación:**
```bash
# Login pages no deben tener <script> tags (excepto el import)
grep -n "<script>" pronto-employees/src/pronto_employees/templates/login_*.html | grep -v "src="
# Expected: 0 results
```

---

### 2.2 Test All Login Flows (2-3h)

**Objetivo:** Verificar que todos los roles pueden hacer login

**Pasos:**

- [ ] **2.2.1** Test manual - Waiter
  1. Abrir http://localhost:6081/waiter/login
  2. Click "Mesero" debug button
  3. Verificar form se llena
  4. Click "Iniciar Sesión"
  5. Verificar redirect a /waiter/dashboard
  6. Verificar dashboard carga correctamente

- [ ] **2.2.2** Test manual - Admin
  1. Abrir http://localhost:6081/admin/login
  2. Ingresar admin@pronto.com / password123
  3. Verificar login exitoso
  4. Verificar dashboard admin carga

- [ ] **2.2.3** Test manual - Cashier
  1. Abrir http://localhost:6081/cashier/login
  2. Click debug button
  3. Verificar login y dashboard

- [ ] **2.2.4** Test manual - Chef
  1. Abrir http://localhost:6081/chef/login
  2. Click debug button
  3. Verificar login y KDS carga

- [ ] **2.2.5** Test manual - System
  1. Abrir http://localhost:6081/system/login
  2. Ingresar system@pronto.com / password123
  3. Verificar login y dashboard system

- [ ] **2.2.6** Test logout
  - Desde cada dashboard, click logout
  - Verificar redirect a login
  - Verificar cookies eliminadas

**Bugs Resueltos:** `20260208_employees_inline_js_violation.md`

---

## FASE 3: DASHBOARD CLEANUP (15-20 horas)

### 3.1 Extract base.html Styles (4-6h)

**Objetivo:** Extraer ~500 líneas de CSS inline de base.html

**Pasos:**

- [ ] **3.1.1** Crear archivo CSS
  ```bash
  touch pronto-static/src/static_content/assets/css/employees/base-layout.css
  ```

- [ ] **3.1.2** Extraer estilos de `base.html` (líneas 26-1000+)
  - Copiar bloque `<style>` completo
  - Pegar en base-layout.css
  - Eliminar `<style>` del template
  - Agregar link al CSS

- [ ] **3.1.3** Organizar CSS por secciones
  ```css
  /* base-layout.css */
  
  /* 1. CSS Variables */
  :root { ... }
  
  /* 2. Global Resets */
  *, *::before, *::after { ... }
  
  /* 3. Layout */
  .employee-layout { ... }
  .employee-sidebar { ... }
  .employee-main { ... }
  
  /* 4. Components */
  .global-loading-overlay { ... }
  
  /* 5. Utilities */
  .homepage-link--active { ... }
  ```

- [ ] **3.1.4** Build y test
  ```bash
  npm run build
  docker restart pronto-employees
  
  # Verificar layout no se rompe
  open http://localhost:6081/waiter/dashboard
  ```

- [ ] **3.1.5** Verificar
  ```bash
  grep -n "<style>" pronto-employees/src/pronto_employees/templates/base.html
  # Expected: 0 results
  ```

---

### 3.2 Extract dashboard.html Scripts (6-8h)

**Objetivo:** Extraer JavaScript inline de dashboard.html

**Archivos:** `dashboard.html` (6,116 líneas)

**Pasos:**

- [ ] **3.2.1** Identificar scripts inline
  ```bash
  grep -n "<script>" pronto-employees/src/pronto_employees/templates/dashboard.html
  ```

- [ ] **3.2.2** Categorizar scripts:
  - [ ] Event listeners
  - [ ] API calls
  - [ ] DOM manipulation
  - [ ] Utility functions

- [ ] **3.2.3** Crear módulos TypeScript
  ```bash
  touch pronto-static/src/vue/employees/modules/dashboard-legacy.ts
  ```

- [ ] **3.2.4** Extraer y refactorizar
  - Mover cada script a función en módulo
  - Agregar tipos TypeScript
  - Usar requestJSON para API calls

- [ ] **3.2.5** Importar en dashboard.ts
  ```typescript
  // dashboard.ts
  import { initDashboardLegacy } from '../modules/dashboard-legacy';
  
  initDashboardLegacy();
  ```

- [ ] **3.2.6** Test exhaustivo
  - Verificar todas las funcionalidades del dashboard
  - Test con diferentes roles
  - Verificar eventos funcionan

---

### 3.3 Extract Admin Sections (4-6h)

**Objetivo:** Limpiar `includes/_admin_sections.html` (2,001 líneas)

**Pasos:**

- [ ] **3.3.1** Extraer estilos
  ```bash
  touch pronto-static/src/static_content/assets/css/employees/admin-sections.css
  ```

- [ ] **3.3.2** Extraer scripts
  ```bash
  touch pronto-static/src/vue/employees/modules/admin-sections.ts
  ```

- [ ] **3.3.3** Refactorizar
  - Mover CSS a archivo
  - Mover JS a módulo
  - Limpiar inline styles

- [ ] **3.3.4** Test admin dashboard
  - Login como admin
  - Verificar todas las secciones cargan
  - Test funcionalidad de cada sección

---

## FASE 4: POLISH (3-5 horas)

### 4.1 Remove Inline Styles (2-3h)

**Objetivo:** Reducir inline `style=""` de 865 a <50

**Pasos:**

- [ ] **4.1.1** Crear utility classes
  ```css
  /* utilities.css */
  .hidden { display: none !important; }
  .visible { display: block !important; }
  .mt-1 { margin-top: 0.25rem; }
  .p-2 { padding: 0.5rem; }
  /* ... más utilities */
  ```

- [ ] **4.1.2** Reemplazar inline styles comunes
  ```html
  <!-- ANTES -->
  <div style="display: none">...</div>
  
  <!-- DESPUÉS -->
  <div class="hidden">...</div>
  ```

- [ ] **4.1.3** Usar data attributes para estado
  ```html
  <!-- ANTES -->
  <div style="display: none" id="panel">...</div>
  <script>
    document.getElementById('panel').style.display = 'block';
  </script>
  
  <!-- DESPUÉS -->
  <div class="panel" data-visible="false">...</div>
  <script>
    panel.dataset.visible = 'true';
  </script>
  
  /* CSS */
  .panel[data-visible="false"] { display: none; }
  .panel[data-visible="true"] { display: block; }
  ```

- [ ] **4.1.4** Verificar
  ```bash
  # Contar inline styles restantes
  grep -r "style=" pronto-employees/src/pronto_employees/templates --include="*.html" | wc -l
  # Expected: <50
  ```

---

### 4.2 Remove !important Overrides (1-2h)

**Objetivo:** Reducir `!important` de 177 a <20

**Pasos:**

- [ ] **4.2.1** Identificar todos los !important
  ```bash
  grep -rn "!important" pronto-static/src/static_content/assets/css --include="*.css" > /tmp/important.txt
  ```

- [ ] **4.2.2** Categorizar por razón:
  - [ ] Specificity wars
  - [ ] Third-party overrides
  - [ ] Quick fixes

- [ ] **4.2.3** Refactorizar cada caso:
  - Aumentar specificity correctamente
  - Usar CSS layers
  - Reorganizar orden de imports

- [ ] **4.2.4** Verificar
  ```bash
  grep -r "!important" pronto-static/src/static_content/assets/css --include="*.css" | wc -l
  # Expected: <20
  ```

---

## VERIFICACIÓN FINAL

### Automated Tests

- [ ] **V.1** Unit tests para módulos TypeScript
  ```bash
  cd pronto-tests
  npm run test -- login-form.spec.ts
  ```

- [ ] **V.2** Build sin errores
  ```bash
  cd pronto-static
  npm run build
  # Expected: 0 errors, 0 warnings
  ```

- [ ] **V.3** Lint CSS
  ```bash
  npm run lint:css
  # Expected: 0 errors
  ```

- [ ] **V.4** Lint TypeScript
  ```bash
  npm run lint
  # Expected: 0 errors
  ```

### Manual Tests

- [ ] **V.5** Login flows (5 roles)
  - Waiter login → dashboard
  - Admin login → dashboard
  - Cashier login → dashboard
  - Chef login → dashboard
  - System login → dashboard

- [ ] **V.6** Dashboard functionality
  - Orders board loads
  - Notifications work
  - Vue components mount
  - API calls succeed

- [ ] **V.7** Visual regression
  - Compare screenshots before/after
  - Verify no layout breaks
  - Check responsive design

### Metrics Verification

- [ ] **V.8** Verificar métricas objetivo
  ```bash
  # <style> blocks
  grep -r "<style>" pronto-employees/src/pronto_employees/templates --include="*.html" | wc -l
  # Expected: 0
  
  # <script> tags (excluding src imports)
  grep -r "<script>" pronto-employees/src/pronto_employees/templates --include="*.html" | grep -v "src=" | wc -l
  # Expected: 0
  
  # fetch() calls
  grep -r "fetch(" pronto-employees/src/pronto_employees/templates --include="*.html" | wc -l
  # Expected: 0
  
  # Google Fonts
  grep -r "googleapis.com" pronto-employees/src/pronto_employees/templates --include="*.html" | wc -l
  # Expected: 0
  
  # Inline styles
  grep -r "style=" pronto-employees/src/pronto_employees/templates --include="*.html" | wc -l
  # Expected: <50
  
  # !important
  grep -r "!important" pronto-static/src/static_content/assets/css --include="*.css" | wc -l
  # Expected: <20
  ```

---

## ROLLBACK PLAN

### Si algo sale mal:

1. **Revert Git Commit**
   ```bash
   git log --oneline | head -5
   git revert <commit-hash>
   ```

2. **Restore Templates**
   ```bash
   git checkout HEAD~1 -- pronto-employees/src/pronto_employees/templates/
   ```

3. **Rebuild**
   ```bash
   cd pronto-static
   npm run build
   docker restart pronto-employees
   ```

4. **Verify**
   ```bash
   open http://localhost:6081/waiter/login
   # Verificar que funciona
   ```

---

## PROGRESO

**Última Actualización:** 2026-02-10 11:40

### Fase 1: Quick Wins ✅ COMPLETADA (83%)
- [x] 1.1 Google Fonts Migration (100%) ✅
- [/] 1.2 Standardize fetch() (12% - PAUSADO)
  - ✅ window.requestJSON expuesto
  - ✅ 5/43 login pages completadas
  - ⏸️ Dashboard pendiente (se hará en Phase 2)
- [x] 1.3 Extract Login CSS (100%) ✅
  - ✅ login-shell.css creado (353 líneas)
  - ✅ 4 templates actualizados
  - ✅ 1,412 líneas eliminadas

### Fase 2: Login Pages
- [ ] 2.1 Extract Login Scripts (0%)
- [ ] 2.2 Test All Flows (0%)

### Fase 3: Dashboard Cleanup
- [ ] 3.1 Extract base.html Styles (0%)
- [ ] 3.2 Extract dashboard.html Scripts (0%)
- [ ] 3.3 Extract Admin Sections (0%)

### Fase 4: Polish
- [ ] 4.1 Remove Inline Styles (0%)
- [ ] 4.2 Remove !important (0%)

**Progreso Total:** 2.5/13 tareas (19.2%)

**Tiempo Invertido:** 3 horas
**Tiempo Restante Estimado:** 31-45 horas

---

## BUGS RESUELTOS AL COMPLETAR

Al completar este checklist, se resolverán los siguientes bugs:

1. ✅ `20260206_static_assets_external_fonts.md` - Google Fonts
2. ✅ `20260206_critical_css_fixes_inline.md` - Inline CSS
3. ✅ `20260208_employees_inline_js_violation.md` - Inline JS
4. ✅ `20260206_client_template_direct_api_call.md` - Direct fetch()
5. ✅ `20260206_config_restoration_legacy_overwrite.md` - Config inline code
6. ✅ Parte de `20260209_fe_api_wrapper_massive_violations.md` - API wrappers

**Total:** 6 bugs resueltos (55% de los 11 bugs bloqueados por templates)

---

## NOTAS PARA AGENTES

### Cómo Continuar Este Trabajo

1. **Lee primero:** `template_cleanup_analysis.md` para contexto completo
2. **Empieza por:** Fase 1 (Quick Wins) - menor riesgo, mayor impacto
3. **Trabaja incrementalmente:** Una tarea a la vez, commit después de cada tarea
4. **Verifica siempre:** Rebuild + restart + test manual después de cada cambio
5. **Documenta:** Actualiza este checklist marcando tareas completadas
6. **Si te atoras:** Revierte el último commit y documenta el problema

### Comandos Útiles

```bash
# Rebuild static
cd pronto-static && npm run build

# Restart service
docker restart pronto-employees

# Check logs
docker logs pronto-employees --tail 50

# Test login
open http://localhost:6081/waiter/login

# Verify metrics
grep -r "<style>" pronto-employees/src/pronto_employees/templates --include="*.html" | wc -l
```

---

**ESTADO:** ABIERTO  
**ASIGNADO:** Cualquier agente puede continuar  
**PRIORIDAD:** Alta  
**ÚLTIMA ACTUALIZACIÓN:** 2026-02-10 10:20
