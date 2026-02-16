---
ID: BUG-MISSING-PII-REDIS-TTL-002
FECHA: 2026-02-09
PROYECTO: pronto-libs
SEVERIDAD: media
TITULO: TTL de 60m para PII en Redis no está implementado ni verificado
DESCRIPCION: El contrato en pronto-docs/contracts/pronto-client/redis_keys.md especifica que la key pronto:client:customer_ref:<uuid> debe tener TTL de 3600 segundos (60 minutos) y contiene PII (name, email, phone). Sin embargo, no existe código visible que implemente ni verifique este TTL. El archivo dining_session_service.py y customer_service.py no muestran implementación de Redis con TTL.
PASOS_REPRODUCIR: 1. Revisar pronto-docs/contracts/pronto-client/redis_keys.md 2. Buscar implementación de TTL en código
RESULTADO_ACTUAL: Contrato especifica TTL 60m pero código no muestra implementación
RESULTADO_ESPERADO: Código debe setear explícitamente TTL=3600 al guardar PII en Redis
UBICACION: pronto-libs/src/pronto_shared/services/
EVIDENCIA: redis_keys.md dice TTL 3600 para pronto:client:customer_ref pero código no muestra esta implementación
HIPOTESIS_CAUSA: El TTL fue definido en contrato pero nunca se implementó en el código de servicio de clientes
ESTADO: ABIERTO
