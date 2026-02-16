---
ID: ERR-20260205-CLIENT-STATIC-HARDCODE
FECHA: 2026-02-05
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: Cliente usa fallback hardcodeado http://localhost:9088 si falta APP_CONFIG.static_host_url
DESCRIPCION: En el módulo client-profile, si window.APP_CONFIG.static_host_url no existe, se usa 'http://localhost:9088' como fallback para construir URL de default avatar. En producción esto puede romper assets y filtrar configuración de dev.
PASOS_REPRODUCIR: 1) Forzar APP_CONFIG.static_host_url undefined (por error de template/config). 2) Abrir vista que renderiza avatar default. 3) Ver que intenta cargar desde http://localhost:9088.
RESULTADO_ACTUAL: Request a localhost en producción; avatar puede fallar y se ve rota la UI.
RESULTADO_ESPERADO: No usar localhost hardcodeado; si falta config, usar ruta relativa servida por pronto-static o manejar error explícito.
UBICACION: pronto-static/src/vue/clients/modules/client-profile.ts:386-390
EVIDENCIA: const staticHost = window.APP_CONFIG?.static_host_url || 'http://localhost:9088';
HIPOTESIS_CAUSA: Fallback agregado para desarrollo sin gate de entorno.
ESTADO: RESUELTO
---
SOLUCION: Se modificó `client-profile.ts` para reemplazar el fallback harcodeado `'http://localhost:9088'` por una cadena vacía (`''`). Esto asegura que si la configuración falta, la URL del asset se resuelve como una ruta relativa (`/assets/...`), lo cual es un comportamiento seguro en cualquier entorno.
COMMIT: 11b6a5b
FECHA_RESOLUCION: 2026-02-06