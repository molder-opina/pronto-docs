---
ID: CONFIG_RESTORATION_LEGACY_OVERWRITE
FECHA: 20260211
PROYECTO: pronto-client
SEVERIDAD: alta
TITULO: Restauración forzada de configuración debido a sobrescritura legacy en `base.html` [RESUELTO]
DESCRIPCION: Se ha implementado una solución robusta para proteger el objeto global `window.APP_CONFIG` contra sobrescrituras accidentales o malintencionadas por parte de scripts legacy. Mediante el uso de `Object.freeze` y `Object.defineProperty`, el objeto de configuración ahora es inmutable y de solo lectura desde su inicialización. Esto elimina la necesidad del parche de restauración forzada al final del archivo `base.html`.
ESTADO: RESUELTO
---
SOLUCION:
1.  **Backend (Jinja2)**: Actualizada la inicialización de `window.APP_CONFIG` en `pronto-client/src/pronto_clients/templates/base.html` para envolver la definición en una IIFE que utiliza `Object.defineProperty` con `writable: false` y `configurable: false`, además de `Object.freeze` para el contenido del objeto.
2.  **Limpieza**: Eliminado el bloque de script inline `FORCE CONFIG RESTORATION - FIX FOR LEGACY OVERWRITE` al final de `base.html`, reduciendo la deuda técnica y mejorando la claridad del template.
3.  **Verificación**: Verificado build exitoso de la aplicación cliente.
---
