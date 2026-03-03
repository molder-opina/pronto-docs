ID: ERR-20260303-EMPLOYEES-SHELL-MAIN-CSS-LINK-WRONG-DIRECTORY-REOPEN-01
FECHA: 2026-03-03
PROYECTO: pronto-employees
SEVERIDAD: alta
TITULO: Reapertura: shell SSR de employees sigue resolviendo el CSS principal desde base incorrecta
DESCRIPCION: Durante la validación de `/admin/dashboard/employees` se detectó que el shell SSR continúa construyendo la URL del CSS principal con `assets_css_employees`, aunque el manifest de Vite entrega `employees_main_css` relativo a `assets/js/employees/assets/...`. Esto vuelve a disparar MIME/type errors y deja pantallas del dashboard sin estilos aplicados.
PASOS_REPRODUCIR:
1. Abrir cualquier vista de employees, por ejemplo `http://localhost:6081/admin/dashboard/employees`.
2. Inspeccionar la consola y la red.
3. Ver la solicitud del CSS principal generado por Vite.
RESULTADO_ACTUAL: El HTML solicita `/assets/css/employees/assets/main-*.css`, ruta que responde HTML/404 en lugar del stylesheet real.
RESULTADO_ESPERADO: El shell SSR debe solicitar la hoja compilada en la ruta real expuesta por el manifest y el proxy de assets.
UBICACION: pronto-employees/src/pronto_employees/templates/index.html; pronto-employees/src/pronto_employees/app.py
EVIDENCIA: Validación Playwright en esta sesión con error `Refused to apply style ... MIME type ('text/html')` para `/assets/css/employees/assets/main-B2ekelMR.css`.
HIPOTESIS_CAUSA: `employees_main_css` ya incluye una ruta relativa perteneciente al árbol `assets/js/employees/assets`, por lo que concatenarla con `assets_css_employees` reintroduce el directorio incorrecto.
ESTADO: RESUELTO
SOLUCION: Se corrigió `templates/index.html` para concatenar `employees_main_css` con `assets_js_employees`, que es la base real donde Vite publica el CSS asociado al bundle de employees. Tras reiniciar `pronto-employees-1`, el MIME error desapareció y la consola quedó limpia.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03

