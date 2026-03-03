ID: BUG-20260215-003
FECHA: 2026-02-15
PROYECTO: pronto-client
SEVERIDAD: baja
TITULO: Archivos de backup en directorio de templates
DESCRIPCION: Se encontró archivo de backup checkout.html.backup en el directorio de templates de pronto-client. Esto viola las mejores prácticas de limpieza del proyecto.
PASOS_REPRODUCIR: Listar archivos en: ls -la pronto-client/src/pronto_clients/templates/
RESULTADO_ACTUAL: Existen archivos: checkout.html.backup, index-alt.html
RESULTADO_ESPERADO: No deben existir archivos de backup (*.backup, *.bak, ~) en el repositorio
UBICACION: pronto-client/src/pronto_clients/templates/
EVIDENCIA: checkout.html.backup (ya eliminado)
HIPOTESIS_CAUSA: Archivos temporales dejados durante desarrollo o depuración
ESTADO: RESUELTO
SOLUCION: Eliminado checkout.html.backup. Queda index-alt.html que podría ser trabajo en progreso.
COMMIT: 20260215
FECHA_RESOLUCION: 2026-02-15
