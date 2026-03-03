---
ID: INCONSISTENT_RESTAURANT_ASSETS_PROTOCOL
FECHA: 20260206
PROYECTO: pronto-employees
SEVERIDAD: media
TITULO: Protocolo inconsistente en `restaurant_assets` forzado por `replace` en templates
DESCRIPCION: Se ha detectado el uso de `{{ restaurant_assets | replace('http://', 'https://') }}` en varios templates de `pronto-employees`. Esto indica que la variable de contexto `restaurant_assets` se está generando con un protocolo `http://` incluso cuando se espera `https://`, forzando una manipulación en el template. `restaurant_assets` debería generarse con el protocolo correcto desde el inicio para mantener la coherencia.
PASOS_REPRODUCIR:
1. Inspeccionar `pronto-employees/src/pronto_employees/templates/dashboard.html` o `pronto-employees/src/pronto_employees/templates/includes/_menu_chef.html`.
2. Buscar referencias a `restaurant_assets` que incluyan el filtro `| replace('http://', 'https://')`.
RESULTADO_ACTUAL: La variable `restaurant_assets` contiene `http://` y requiere una manipulación en el template para asegurar `https://`.
RESULTADO_ESPERADO: La variable `restaurant_assets` debería generarse con el protocolo `https://` si es el deseado para el entorno de producción, eliminando la necesidad del filtro `replace` en los templates. La configuración de `PRONTO_STATIC_PUBLIC_HOST` o `PRONTO_STATIC_CONTAINER_HOST` (en `app.py`) debería reflejar el protocolo correcto.
UBICACION:
- pronto-employees/src/pronto_employees/templates/dashboard.html:L2165
- pronto-employees/src/pronto_employees/templates/includes/_menu_chef.html:L841
- pronto-employees/src/pronto_employees/templates/base.html:L1456
EVIDENCIA:
```html
src="{{ restaurant_assets | replace('http://', 'https://') }}/icons/placeholder.png"
```
HIPOTESIS_CAUSA: La configuración del host estático público (`PRONTO_STATIC_PUBLIC_HOST`) o la lógica de su construcción en `app.py` no está generando el protocolo `https://` consistentemente, o se asume un `http://` por defecto.
ESTADO: RESUELTO
SOLUCION: Eliminado el filtro `| replace('http://', 'https://')` de las referencias a `restaurant_assets` en 2 archivos. El protocolo debe configurarse correctamente en `PRONTO_STATIC_PUBLIC_HOST` según el entorno (http:// para desarrollo local, https:// para producción). No se debe forzar el protocolo en los templates.
FECHA_RESOLUCION: 2026-02-09
---