---
ID: ERR-20260208-015
FECHA: 2026-02-08
PROYECTO: pronto-employees
SEVERIDAD: media
TITULO: Violación de reglas de contenido estático (Inline Vanilla JS)
DESCRIPCION: El archivo `dashboard.html` contiene bloques masivos de JavaScript "vanilla" incrustados directamente en el template de Jinja2. Esto viola las reglas duras #4 ("Prohibido JavaScript vanilla") y #5 ("No inline JS") del proyecto, dificultando la modularización y el mantenimiento del frontend.
PASOS_REPRODUCIR:
1) Abrir pronto-employees/src/pronto_employees/templates/dashboard.html.
2) Navegar a la línea 630 en adelante.
RESULTADO_ACTUAL: Cientos de líneas de lógica de negocio (BrandingManager, Session Management) en scripts inline.
RESULTADO_ESPERADO: Toda la lógica de interacción debe residir en componentes Vue dentro de `pronto-static`.
UBICACION: pronto-employees/src/pronto_employees/templates/dashboard.html
EVIDENCIA: Presencia de etiquetas `<script>` con lógica compleja de `fetch` y manipulación de DOM manual.
HIPOTESIS_CAUSA: Acumulación de deuda técnica durante la prototipación rápida de funcionalidades administrativas.
ESTADO: PENDIENTE
---
PLAN DE SOLUCION:
1. Extraer la lógica de `BrandingManager` a un nuevo componente Vue en `pronto-static`.
2. Mover la lógica de `loadSessions` y `closeSession` al módulo `sessions-manager.ts` existente en Vue.
3. Limpiar `dashboard.html` dejando únicamente los puntos de montaje (`id="vue-..."`) y la inyección de variables globales mínimas.
