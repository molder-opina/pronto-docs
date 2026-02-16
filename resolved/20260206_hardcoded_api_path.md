---
ID: HARDCODED_API_PATH
FECHA: 20260206
PROYECTO: pronto-employees
SEVERIDAD: media
TITULO: Ruta de API hardcodeada en templates de empleados
DESCRIPCION: Se utiliza una ruta `/api/` hardcodeada en el JavaScript dentro de los templates de `pronto-employees`, lo cual, aunque relativo, no se alinea con la expectativa de resolución de API por host (`employees.<dominio>/api/*` vs `clients.<dominio>/api/*`) como se detalla en la sección "15.1 Regla canonica por host" de `AGENTS.md`. Esto hace que el código sea frágil ante cambios en la configuración de los hosts de la API.
PASOS_REPRODUCIR:
1. Inspeccionar el código JavaScript dentro de `pronto-employees/src/pronto_employees/templates/dashboard.html` o `pronto-employees/src/pronto_employees/templates/includes/_dashboard_scripts.html`.
2. Buscar la línea donde se construye un enlace para descargar QR de una mesa.
RESULTADO_ACTUAL: La URL de la API se construye de forma relativa con `/api/`, lo que asume que la API de empleados siempre será accesible bajo la misma ruta relativa.
RESULTADO_ESPERADO: Las URLs de la API deberían construirse utilizando variables de contexto o mecanismos de configuración que permitan la flexibilidad y adaptabilidad a diferentes entornos o hosts de la API.
UBICACION:
- pronto-employees/src/pronto_employees/templates/dashboard.html:L5240
- pronto-employees/src/pronto_employees/templates/includes/_dashboard_scripts.html:L863
EVIDENCIA:
```javascript
${tableInfo.id ? `<a class="floating-panel__link" href="/api/tables/${tableInfo.id}/qr" target="_blank" rel="noopener">Descargar QR</a>` : ''}
```
HIPOTESIS_CAUSA: Conveniencia de desarrollo sin considerar la robustez de la configuración de rutas de API.
ESTADO: RESUELTO
SOLUCION: Reemplazado `/api/tables/${tableInfo.id}/qr` con `${window.API_BASE}/api/tables/${tableInfo.id}/qr` en ambos archivos para usar la variable de configuración dinámica.
FECHA_RESOLUCION: 2026-02-09
---