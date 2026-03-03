ID: SEC-20260215-002
FECHA: 2026-02-15
PROYECTO: pronto-api
SEVERIDAD: bloqueante
TITULO: pronto-api expuesto públicamente en puerto 6082

DESCRIPCION:
El servicio pronto-api (puerto 6082) está publicado en el host mediante docker-compose ports, permitiendo acceso directo desde el navegador. Esto representa un riesgo de seguridad porque:

1. El header X-PRONTO-CUSTOMER-REF puede ser forjado por atacantes
2. La autenticación de clientes depende únicamente de este header (sin firma HMAC)
3. Un atacante puede impersonar cualquier cliente si logra su customer_ref

El BFF (pronto-client) debería ser el único punto de entrada; la API debería ser inaccesible directamente desde el browser.

PASOS_REPRODUCIR:
1. curl http://localhost:6082/health
2. La request conecta exitosamente desde el host
3. Se puede enviar X-PRONTO-CUSTOMER-REF forjado

RESULTADO_ACTUAL:
- Puerto 6082 expuesto en docker-compose.yml como "6082:6082"
- API accesible desde browser localhost:6082
- No hay validación de origen de la request

RESULTADO_ESPERADO:
- Puerto 6082 NO expuesto al host (solo interno)
- Solo servicios dentro de la red Docker pueden alcanzar la API
- Acceso desde host → connection refused

UBICACION:
- docker-compose.yml (servicio api: ports: - "6082:6082")
- No hay validación Origin/Referer en endpoints

EVIDENCIA:
- docker-compose.yml línea con:
  api:
    ports:
      - "6082:6082"

HIPOTESIS_CAUSA:
Para desarrollo local, se expuso el puerto 6082方便 debugging sin considerar el riesgo en producción. No hay diferenciación entre perfil dev y prod.

ESTADO: RESUELTO

SOLUCION:
1. Se cambió de "ports" a "expose" + "profiles" en docker-compose.yml
2. Perfil "apps" (default): API NO expuesto públicamente
3. Perfil "dev": API expuesto en puerto 6082 para desarrollo/testing

Para desarrollo:
  docker-compose --profile dev up

Para producción:
  docker-compose --profile apps up

COMMIT: N/A - docker-compose.yml modificado
FECHA_RESOLUCION: 2026-02-15
