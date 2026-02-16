---
ID: CRITICAL_CSS_FIXES_INLINE
FECHA: 20260206
PROYECTO: pronto-client
SEVERIDAD: alta
TITULO: Uso de CSS crítico y `!important` para corregir problemas visuales en `base.html`
DESCRIPCION: El template `pronto-client/src/pronto_clients/templates/base.html` contiene un bloque de `<style id="critical-visual-fixes">` con CSS que utiliza `!important` y comentarios como "CRITICAL CSS FIXES - NUCLEAR OPTION" y "FIX ERROR #1", "FIX ERROR #2". Esto indica la existencia de problemas visuales profundos o inconsistencias de estilo que requieren soluciones de "último recurso", afectando negativamente la mantenibilidad y la coherencia visual del frontend.
PASOS_REPRODUCIR:
1. Inspeccionar `pronto-client/src/pronto_clients/templates/base.html`.
2. Observar el bloque `<style id="critical-visual-fixes">` y sus comentarios.
RESULTADO_ACTUAL: El frontend depende de inyecciones de CSS con `!important` para corregir problemas visuales fundamentales, lo que anula la cascada de estilos y hace que el depurado y el mantenimiento sean extremadamente difíciles.
RESULTADO_ESPERADO: Los problemas de estilo deberían resolverse en los archivos CSS base (`assets_css_clients/main-ux.css` o `shared/base.css`), evitando el uso de `!important` a menos que sea estrictamente necesario y justificado, y eliminando la necesidad de "soluciones nucleares".
UBICACION:
- pronto-client/src/pronto_clients/templates/base.html:L35-L157
- pronto-client/src/pronto_clients/templates/base.html:L299-L382
- pronto-client/src/pronto_clients/templates/base.html:L968-L1039
EVIDENCIA:
```html
<!-- Extract from base.html -->
  <!-- CRITICAL CSS FIXES - NUCLEAR OPTION -->
  <style id="critical-visual-fixes">
    /* FORCE WHITE BACKGROUND EVERYWHERE */
    html,
    body,
    .menu-page,
    .app-container,
    .main-layout,
    #app,
    .menu-flow {
      background: #ffffff !important;
      background-image: none !important;
      background-color: #ffffff !important;
    }
    /* ... más overrides con !important ... */
```
HIPOTESIS_CAUSA: La evolución del diseño o la introducción de nuevos componentes generó conflictos de estilo que se resolvieron con overrides forzados en lugar de una refactorización de CSS más profunda.
ESTADO: ABIERTO
---