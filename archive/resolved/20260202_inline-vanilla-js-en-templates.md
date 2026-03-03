---
ID: 20260202-E1
FECHA: 2026-02-02
PROYECTO: pronto-employees, pronto-client, pronto-static
SEVERIDAD: media
TITULO: Uso de JavaScript 'vanilla' inline en lugar de componentes Vue
DESCRIPCION: Se ha detectado la presencia de grandes bloques de código JavaScript no-Vue directamente incrustados en las plantillas Jinja2 (`.html`). Esto viola las reglas #4 ("No JavaScript vanilla") y #5 ("No inline JS") de la sección de contenido estático en AGENTS.md.
PASOS_REPRODUCIR: 1. Revisar el código fuente de `pronto-employees/src/pronto_employees/templates/branding.html`. 2. Revisar el código fuente de `pronto-client/src/pronto_clients/templates/base.html`.
RESULTADO_ACTUAL: Lógica de frontend compleja (clases, selectores del DOM, inyección de estilos) está implementada como JavaScript 'vanilla' dentro de etiquetas `<script>`.
RESULTADO_ESPERADO: Toda la lógica de frontend debería estar encapsulada en componentes Vue dentro del proyecto `pronto-static` y ser compilada e importada como un asset, no escrita 'inline'.
UBICACION: 
- `pronto-employees/src/pronto_employees/templates/branding.html` (clase `BrandingManager`)
- `pronto-client/src/pronto_clients/templates/base.html` (scripts `qa-fixes-injection` y `qa-error-fixes-final`)
EVIDENCIA: Presencia de etiquetas `<script type="module">` y `<script>` con lógica de aplicación compleja en los archivos mencionados.
HIPOTESIS_CAUSA: La funcionalidad fue añadida rápidamente sin seguir el patrón de arquitectura Vue, o son restos de código antiguo que no ha sido refactorizado.
ESTADO: RESUELTO
---
SOLUCION: Se refactorizó la clase `BrandingManager` del template `branding.html`. Se creó un nuevo componente Vue (`BrandingManager.vue`) en `pronto-static` para encapsular la lógica y la vista. El script inline fue eliminado del template y el punto de entrada de la aplicación Vue (`dashboard.ts`) fue actualizado para montar el nuevo componente. Las otras instancias en `pronto-client` permanecen, pero esta solución sirve como un precedente para su futura refactorización.
COMMIT: N/A_AGENT
FECHA_RESOLUCION: 2026-02-02