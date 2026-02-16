---
ID: HARDCODED_SYSTEM_STATUS_PATH
FECHA: 20260206
PROYECTO: pronto-employees
SEVERIDAD: alta
TITULO: Ruta hardcodeada a /SYSTEM_STATUS.html en template de empleados
DESCRIPCION: Se ha encontrado una ruta hardcodeada `/SYSTEM_STATUS.html` en el template `includes/_dashboard_base.html` de `pronto-employees`. Esto viola el principio de no hardcodear URLs de assets y la directriz de que todos los assets deben ser gestionados por `pronto-static` y referenciados mediante variables de contexto.
PASOS_REPRODUCIR:
1. Abrir `pronto-employees/src/pronto_employees/templates/includes/_dashboard_base.html`.
2. Observar la línea 23.
RESULTADO_ACTUAL: Enlace a una página estática con una ruta hardcodeada que no utiliza las variables de contexto provistas para assets, como `static_host_url`.
RESULTADO_ESPERADO: Si `SYSTEM_STATUS.html` es un asset estático, debería ser servido por `pronto-static` y su URL construida dinámicamente usando las variables de contexto apropiadas. Si es una ruta interna de Flask, debería usar `url_for()`.
UBICACION:
- pronto-employees/src/pronto_employees/templates/includes/_dashboard_base.html:L23
EVIDENCIA:
```html
<a href="/SYSTEM_STATUS.html" style="color: #3b82f6; text-decoration: underline"
```
HIPOTESIS_CAUSA: Uso de una ruta estática sin considerar el esquema de gestión de assets centralizado ni la forma correcta de referenciar recursos.
ESTADO: RESUELTO
SOLUCION: El enlace a `/SYSTEM_STATUS.html` ya estaba comentado en el bloque de código (líneas 16-27 de _dashboard_base.html). El archivo SYSTEM_STATUS.html no existe en el proyecto. No se requiere acción adicional.
FECHA_RESOLUCION: 2026-02-09
---