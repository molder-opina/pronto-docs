ID: ERR-20260213-AUTH-ERROR-404
FECHA: 2026-02-13
PROYECTO: pronto-employees / pronto-static
SEVERIDAD: media
TITULO: Redirección a /authorization-error retorna 404 en employees
DESCRIPCION: Cuando frontend dispara redirect por 403, la ruta /authorization-error no existía en employees y producía 404. Además /favicon.ico también daba 404.
PASOS_REPRODUCIR:
1. Provocar 403 desde login/flujo employees.
2. Navegador intenta abrir /authorization-error.
RESULTADO_ACTUAL: 404 en /authorization-error y en /favicon.ico.
RESULTADO_ESPERADO: Ruta de error disponible y favicon servido sin 404.
UBICACION: pronto-employees/src/pronto_employees/app.py, pronto-static/src/vue/employees/core/http.ts
EVIDENCIA: consola navegador reportando GET /authorization-error 404 y GET /favicon.ico 404.
HIPOTESIS_CAUSA: falta de rutas SSR para errores/ícono y detección de login path demasiado estricta.
ESTADO: RESUELTO
SOLUCION: Se agregó ruta `/authorization-error` renderizando shell SPA; se agregó `/favicon.ico` con redirect al host estático; y se robusteció `isLoginPath()` para normalizar trailing slash y evitar redirects erróneos desde login.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-13
