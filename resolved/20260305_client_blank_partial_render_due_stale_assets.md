ID: ERR-CLIENT-BLANK-PARTIAL-RENDER-20260305
FECHA: 2026-03-05
PROYECTO: pronto-client
SEVERIDAD: alta
TITULO: Render parcial en cliente 6080 con cuerpo gris y componentes sin estilo
DESCRIPCION: En `http://localhost:6080/?view=profile&tab=login` la vista puede quedar parcialmente renderizada (header visible, cuerpo gris, texto sin estilo y sin cards de menú), consistente con carga de assets stale/incompletos del navegador.
PASOS_REPRODUCIR:
1. Abrir `http://localhost:6080/?view=profile&tab=login`
2. Navegar entre tabs y recargar varias veces
3. Ocasionalmente se observa vista parcial sin render completo de menú
RESULTADO_ACTUAL: Se muestra interfaz incompleta con secciones flotantes básicas y sin render de contenido principal.
RESULTADO_ESPERADO: Carga consistente de CSS/JS y render completo del menú/tabs en cada refresh.
UBICACION: pronto-client/src/pronto_clients/templates/base.html, pronto-client/src/pronto_clients/templates/index.html
EVIDENCIA: Captura de usuario con layout parcial + diagnóstico de inconsistencia de cache en assets versionados por `rev` antiguos.
HIPOTESIS_CAUSA: Caché del navegador mantiene bundles CSS/JS viejos y mezcla estados de template/asset durante cambios iterativos.
ESTADO: RESUELTO
SOLUCION: Se invalidó caché de frontend actualizando `rev` en CSS/JS críticos del cliente (`base.html` e `index.html`) para forzar recarga limpia de bundles y evitar mezcla de assets stale.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-05
