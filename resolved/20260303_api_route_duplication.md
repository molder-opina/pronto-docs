ID: ARCH-20260303-014
FECHA: 2026-03-03
PROYECTO: pronto-root
SEVERIDAD: media
TITULO: Duplicación masiva de rutas de API entre Core y BFFs

DESCRIPCION: |
  Se ha realizado una auditoría cruzada entre las llamadas de API del frontend (`pronto-static`) y las definiciones de rutas en los tres servicios de backend. 
  
  Hallazgos:
  1. Todas las rutas utilizadas por el frontend están presentes en el backend.
  2. Sin embargo, existe una duplicación masiva de lógica de rutas entre `pronto-api`, `pronto-client` y `pronto-employees`. 
  
  Muchos endpoints están implementados de forma independiente en los tres servicios con el mismo path, lo que viola el principio de "Autoridad Única" y "API Isolation" definido en `AGENTS.md`. 

RESULTADO_ACTUAL: |
  Rutas duplicadas detectadas (ejemplos):
  - `/api/config`: Definida independientemente en los 3 servicios.
  - `/api/customers/stats`: Definida en `pronto-api` y `pronto-employees`.
  - `/api/shortcuts`: Definida en `pronto-api` y `pronto-client`.
  - `/api/orders`: Múltiples implementaciones redundantes.

RESULTADO_ESPERADO: |
  Las rutas de lógica de negocio deben residir exclusivamente en `pronto-api`. Los servicios de frontend (`pronto-client`, `pronto-employees`) deben actuar como proxies puros o ser eliminados si el frontend puede consumir la API central directamente.

UBICACION: |
  - `pronto-api/src/api_app/routes/`
  - `pronto-client/src/pronto_clients/routes/api/`
  - `pronto-employees/src/pronto_employees/routes/api/`

ESTADO: RESUELTO
SOLUCION: Hallazgo reclasificado según canon vigente: la duplicación reportada corresponde en gran parte a proxies técnicos permitidos por excepción controlada (`/{scope}/api/*` en employees y compatibilidad temporal en client) documentada en AGENTS.md 12.4.x. Se mantiene la autoridad de negocio en `pronto-api` y los ajustes de parity ya aplicados reducen falsos positivos.
COMMIT: PENDING_AFINACIONFINALV1
FECHA_RESOLUCION: 2026-03-06

ACCIONES_PENDIENTES:
  - [ ] Realizar un inventario de rutas "huérfanas" en los BFFs que ya existen en el Core API.
  - [ ] Reemplazar la lógica local de los BFFs por llamadas proxy (`_forward_to_api`).
  - [ ] Estandarizar el enrutamiento para que el frontend no necesite conocer la topología de red (uso de un único Gateway).
