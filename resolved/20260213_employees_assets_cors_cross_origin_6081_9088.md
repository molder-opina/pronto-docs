ID: 20260213_employees_assets_cors_cross_origin_6081_9088
FECHA: 2026-02-13
PROYECTO: pronto-employees, pronto-static
SEVERIDAD: alta
TITULO: Employees SPA falla por CORS al cargar JS estático en 9088 desde host 6081
DESCRIPCION: La SPA de empleados intenta cargar `main.js` y librerías desde `http://localhost:9088/assets/*` mientras la app corre en `http://localhost:6081`, provocando fallo de carga por política de origen cruzado.
PASOS_REPRODUCIR: 1) Abrir `http://localhost:6081`. 2) Observar carga de `script type="module"` hacia `http://localhost:9088/assets/js/employees/main.js?...`. 3) Ver error CORS y fallo de carga de `chart.umd.min.js`.
RESULTADO_ACTUAL: El bundle principal de empleados no carga y la app queda inoperante.
RESULTADO_ESPERADO: Los assets de empleados deben cargarse por mismo origen (`/assets/*`) para evitar bloqueos CORS en browser.
UBICACION: pronto-employees/src/pronto_employees/app.py, pronto-employees/src/pronto_employees/templates/index.html
EVIDENCIA: Consola del navegador reporta "Solicitud de origen cruzado bloqueada" para `main.js` y fallo de carga para `chart.umd.min.js`.
HIPOTESIS_CAUSA: El context processor genera URLs absolutas con `PRONTO_STATIC_PUBLIC_HOST` (9088) en lugar de usar el passthrough `/assets/*` ya implementado en `pronto-employees`.
ESTADO: RESUELTO
