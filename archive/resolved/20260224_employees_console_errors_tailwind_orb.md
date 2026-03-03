ID: ERR-20260224-EMPLOYEES-CONSOLE-TAILWIND-ORB
FECHA: 2026-02-24
PROYECTO: pronto-static (employees)
SEVERIDAD: media
TITULO: Errores de consola en dashboard employees por directivas Tailwind runtime y carga de imágenes con ORB
DESCRIPCION: En `http://localhost:6081/waiter/dashboard` aparecían errores CSS (`@tailwind`, `@apply`) y warnings de recurso bloqueado (OpaqueResponseBlocking) en imágenes de menú.
PASOS_REPRODUCIR:
1. Abrir dashboard de empleados.
2. Revisar consola del navegador.
3. Observar errores de parseo CSS en `main-*.css` y advertencias ORB para imágenes.
RESULTADO_ACTUAL: Consola con errores de parseo CSS y recursos de imagen bloqueados.
RESULTADO_ESPERADO: CSS válido en runtime sin directivas de preprocesador y carga de imágenes sin bloqueo ORB.
UBICACION: pronto-static/src/vue/employees/index.css; pronto-static/src/vue/employees/store/config.ts; pronto-static/src/vue/employees/components/menu/AdminProductCard.vue
EVIDENCIA: Build de employees generado con `main-hQ2uKYbD.css` sin `@tailwind/@apply`, y normalización de URLs absolutas a rutas same-origin `/assets/...`.
HIPOTESIS_CAUSA: Archivo base de employees mezclaba directivas de compilación Tailwind en runtime y se propagaban rutas absolutas de assets cruzando host para imágenes.
ESTADO: RESUELTO
SOLUCION: Se reemplazaron directivas Tailwind por CSS estándar en `index.css`, se normalizó `restaurant_assets` absoluto a path same-origin en store de config, y se añadió fallback defensivo de imagen en `AdminProductCard` con handler `@error`.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-24
