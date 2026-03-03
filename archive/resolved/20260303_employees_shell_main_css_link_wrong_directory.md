ID: ERR-20260303-EMPLOYEES-SHELL-MAIN-CSS-LINK-WRONG-DIRECTORY
FECHA: 2026-03-03
PROYECTO: pronto-employees
SEVERIDAD: alta
TITULO: Shell SSR de employees enlaza la hoja principal desde assets_js_employees en lugar de assets_css_employees
DESCRIPCION: El template base `index.html` del shell SPA de employees construye el `link rel="stylesheet"` usando `assets_js_employees`, lo que produce una URL con prefijo `/assets/js/employees/...css`. Esa URL responde HTML y genera error de MIME en navegador, dejando el shell dependiente de estilos parciales o cacheados.
PASOS_REPRODUCIR:
1. Abrir cualquier ruta del SPA de employees, por ejemplo `/admin/dashboard/roles`.
2. Revisar la consola del navegador.
3. Observar error de MIME al cargar `main-*.css` desde `/assets/js/employees/...`.
RESULTADO_ACTUAL: La hoja principal del bundle no se carga desde la carpeta correcta.
RESULTADO_ESPERADO: El shell debe enlazar `employees_main_css` usando `assets_css_employees`.
UBICACION: pronto-employees/src/pronto_employees/templates/index.html
EVIDENCIA: Inspección Playwright en sesión mostró `Refused to apply style from 'http://localhost:6081/assets/js/employees/assets/main-*.css?...' because its MIME type ('text/html') is not a supported stylesheet MIME type`.
HIPOTESIS_CAUSA: El template fue cableado con la variable de assets JS en lugar de la de assets CSS.
ESTADO: RESUELTO
SOLUCION: Se actualizó `pronto-employees/src/pronto_employees/templates/index.html` para enlazar `employees_main_css` con `assets_css_employees` en lugar de `assets_js_employees`, eliminando el error de MIME del shell SSR y asegurando la carga correcta de la hoja principal del bundle.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03
