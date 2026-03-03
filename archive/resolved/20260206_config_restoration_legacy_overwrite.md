---
ID: CONFIG_RESTORATION_LEGACY_OVERWRITE
FECHA: 20260206
PROYECTO: pronto-client
SEVERIDAD: alta
TITULO: Restauración forzada de configuración debido a sobrescritura legacy en `base.html`
DESCRIPCION: El template `pronto-client/src/pronto_clients/templates/base.html` contiene JavaScript inline que realiza una "restauración forzada" (`FORCE CONFIG RESTORATION - FIX FOR LEGACY OVERWRITE`) de `window.APP_CONFIG` y `window.APP_CONFIG.restaurant_assets`. Esto indica un problema subyacente de gestión de configuración donde valores importantes de `APP_CONFIG` se pierden o se sobrescriben incorrectamente, posiblemente por código legacy o un orden de inicialización deficiente.
PASOS_REPRODUCIR:
1. Inspeccionar `pronto-client/src/pronto_clients/templates/base.html`.
2. Observar el bloque `<script>` con el comentario `// FORCE CONFIG RESTORATION - FIX FOR LEGACY OVERWRITE`.
RESULTADO_ACTUAL: La aplicación cliente depende de un script inline en el template para corregir la configuración en tiempo de ejecución, lo que sugiere un problema fundamental en cómo se inicializa o mantiene `APP_CONFIG`.
RESULTADO_ESPERADO: La configuración de `APP_CONFIG` debería ser robusta y correcta desde su inicialización, sin necesidad de "restauraciones forzadas" o "parches" en el frontend que insinúen problemas de sobrescritura legacy.
UBICACION:
- pronto-client/src/pronto_clients/templates/base.html:L1045-L1060
EVIDENCIA:
```html
// Extract from base.html
  // FORCE CONFIG RESTORATION - FIX FOR LEGACY OVERWRITE
  (function () {
    if (!window.APP_CONFIG) window.APP_CONFIG = {};

    // Restore values that might have been lost
    if (!window.APP_CONFIG.static_host_url) {
      window.APP_CONFIG.static_host_url = '{{ static_host_url }}';
    }

    // Ensure restaurant assets are correct
    if (!window.APP_CONFIG.restaurant_assets || window.APP_CONFIG.restaurant_assets.includes('undefined')) {
      window.APP_CONFIG.restaurant_assets = '{{ restaurant_assets }}';
    }

    console.log('[Config Fixer] Restored APP_CONFIG:', window.APP_CONFIG);
  })();
```
HIPOTESIS_CAUSA: Un componente legacy o un proceso de inicialización de configuración no tiene en cuenta la persistencia o el correcto flujo de valores para `APP_CONFIG`, obligando a este parche de restauración.
ESTADO: RESUELTO
---