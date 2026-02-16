ID: 20260213_api_db_hostname_postgres_unresolvable
FECHA: 2026-02-13
PROYECTO: pronto-api, pronto-scripts
SEVERIDAD: bloqueante
TITULO: API no resuelve hostname postgres y devuelve error en /api/menu
DESCRIPCION: Luego de un redeploy parcial, el contenedor `pronto-api-1` quedó en `pronto_net` sin conectividad DNS efectiva hacia `postgres`, provocando fallas de base de datos en endpoints de cliente como `/api/menu` y `/api/business-info`.
PASOS_REPRODUCIR:
1. Ejecutar `curl -sS http://localhost:6082/api/menu`.
2. Observar respuesta con error `could not translate host name "postgres" to address`.
3. Verificar dentro de API: `docker exec -i pronto-api-1 getent hosts postgres` no retorna IP.
RESULTADO_ACTUAL: Endpoints críticos de API fallan por error de resolución de host de PostgreSQL.
RESULTADO_ESPERADO: `pronto-api` debe resolver `postgres` y responder 200 en `/api/menu` con categorías e ítems.
UBICACION: pronto-scripts/bin/mac/rebuild.sh
EVIDENCIA:
- `curl -sS http://localhost:6082/api/menu` devolviendo `Error loading menu` con `OperationalError`.
- `docker network inspect pronto_net` sin `pronto-postgres-1`/`pronto-redis-1` en membresía previa al fix.
- `docker exec -i pronto-api-1 getent hosts postgres` sin salida previa al fix.
HIPOTESIS_CAUSA: El flujo de rebuild/restart de apps con `--no-deps` no garantiza recreación/reattach correcto de `postgres` y `redis` antes de reiniciar servicios que dependen de esos aliases de red.
ESTADO: RESUELTO
SOLUCION: Se corrigió `pronto-scripts/bin/mac/rebuild.sh` para recrear y validar `postgres` y `redis` antes de rebuild de apps, evitando que `api` arranque sin alias DNS de DB. Luego se ejecutó pre-boot canónico (`pronto-migrate --apply`, `pronto-init --apply`, `pronto-init --check`) dentro de `pronto-api` y se confirmó recuperación de salud en `api/client/employees/static`.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-13
