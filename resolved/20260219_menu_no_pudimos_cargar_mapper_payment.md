ID: ERR-20260219-MENU-MAPPER-PAYMENT
FECHA: 2026-02-19
PROYECTO: pronto-libs, pronto-client
SEVERIDAD: bloqueante
TITULO: /api/menu retorna 500 por mapper SQLAlchemy (Payment no resuelto)
DESCRIPCION: El frontend muestra "No pudimos cargar el menú". El endpoint `GET /api/menu` responde 500 por fallo de mapeo ORM: `DiningSession` no puede resolver la relación `Payment`.
PASOS_REPRODUCIR:
1. Abrir cliente y solicitar menú.
2. Ejecutar `curl -i http://localhost:6080/api/menu`.
3. Revisar logs de `pronto-client-1`.
RESULTADO_ACTUAL: HTTP 500 con `{"error":"Error de base de datos"}` y stacktrace `expression 'Payment' failed to locate a name`.
RESULTADO_ESPERADO: HTTP 200 con payload de menú.
UBICACION: pronto-libs/src/pronto_shared/models.py
EVIDENCIA: Logs de `pronto-client-1` muestran `InvalidRequestError` al inicializar mapper `DiningSession` por relación `Payment` no resuelta.
HIPOTESIS_CAUSA: Orden/configuración de relaciones ORM entre `Payment` y `DiningSession` no robusta en runtime del paquete instalado.
ESTADO: RESUELTO
SOLUCION: Se reforzó el binding bidireccional de relación ORM entre `Payment` y `DiningSession` en `pronto_shared.models` definiendo la relación explícita después de declarar ambas clases y reconstruyendo el servicio client para cargar la nueva versión de `pronto-libs`.
COMMIT: N/A
FECHA_RESOLUCION: 2026-02-19
