ID: PROMPT-22
FECHA: 2026-02-17
PROYECTO: PRONTO-System
SEVERIDAD: alta
TITULO: PROMPT 22 - Reglas de Arquitectura P0

DESCRIPCION:
Falta crear prompt para implementar las reglas de arquitectura fundamentales de PRONTO.

CONTENIDO PROMPT:

```
Implementa las reglas de arquitectura fundamentales de PRONTO:

PRINCIPIOS ABSOLUTOS (P0) - BLOQUEANTES:

1. No modificar arquitectura salvo solicitud explicita del usuario.
2. No eliminar bases de datos.
3. No tocar pods PostgreSQL ni Redis.
4. No tocar pronto-postgresql ni pronto-redis (codigo, config, pods) sin orden explicita.
5. Prohibido flask.session / session en pronto-api y pronto-employees.
6. Excepcion unica de sesion (solo pronto-client):
   - allowlist: dining_session_id, customer_ref
   - PII fuera de session; Redis TTL 60m: pronto:client:customer_ref:<uuid>
   - Prohibido PII/tokens/auth en session.
7. Autenticacion empleados = JWT (inmutable).
8. Todo contenido estatico es Vue y vive exclusivamente en pronto-static.
9. Vue se compila unicamente en build.
10. Prohibido estaticos locales en pronto-client / pronto-employees.
11. No inventar roles; roles canonicos: waiter, chef, cashier, admin, system.
12. No cambiar logica de negocio actual sin orden explicita.
13. Prohibido DDL runtime en:
    - pronto-api/, pronto-employees/, pronto-client/, pronto-libs/src/
14. Fuente unica DDL: pronto-scripts/init/**
    - DROP INDEX IF EXISTS permitido solo en pronto-scripts/init/sql/migrations/
    - todo lo demas DROP* prohibido.
15. Todo flujo sin autenticacion es prohibited:
    - No debe existir ningun endpoint, ruta o pagina accesible sin autenticacion valida.
    - Excepciones: /health, /api/sessions/open (solo con table_id valido), login/register pages.
    - Todo endpoint de mutacion (POST/PUT/DELETE) requiere autenticacion.
    - Tests deben usar autenticacion real, no flujos anonimos.
16. Prohibido @csrf.exempt para "hacer funcionar" codigo (P0):
    - CSRF es proteccion obligatoria, no debe deshabilitarse para arreglar problemas.
    - Excepcion unica: /api/sessions/open (solo con table_id valido para abrir sesion de mesa).
17. Prohibido codigo legacy y patrones anticuados:
    - Prohibido flask.session para autenticacion de empleados (usar JWT).
    - Prohibido directorio legacy_mysql en pronto-scripts/init/.
    - Prohibido funciones de hash legacy (SHA256+pepper) - usar PBKDF2.
    - Prohibido callbacks en SQLAlchemy (usar eventos si es necesario).
    - Prohibido patrones deprecated de Flask/Werkzeug.
18. No se permite codigo que dependa de funcionalidad deprecated o sin mantenimiento.
19. Init/Migrations canonicos pre-boot (OBLIGATORIO):
    - ./pronto-scripts/bin/pronto-migrate --apply
    - ./pronto-scripts/bin/pronto-init --check
20. Separacion dura Init vs Migrations:
    - Init: pronto-scripts/init/sql/00_bootstrap..40_seeds (idempotente, sin ALTER/RENAME/backfills)
    - Migrations: pronto-scripts/init/sql/migrations/ (evolutivo: ALTER/RENAME/backfills/seed changes)
21. Reutilizacion: Antes de crear funcionalidad nueva, revisar pronto-libs (pronto_shared) y reutilizar ahi.
22. No cambios silenciosos en docker-compose* ni en pronto-scripts/bin.
23. Herramienta estandar de busqueda: rg.
24. Python deps: cada servicio pronto-* debe tener una sola fuente de verdad en requirements.txt en la raiz del proyecto del servicio (sin duplicados bajo src/). Excepcion: pronto-audit usa pyproject.toml (poetry) y mantiene su propio ambiente virtual (.venv) interno.
25. PostgreSQL canonico: 16-alpine
26. Root PRONTO es workspace aggregator local. No se pushea.
    - Version versionada en: pronto-scripts/pronto-root/
27. Autoridad Unica de Transiciones de Estado (Orden + Pago) (P0)
    - Constantes canonicas: pronto-libs/src/pronto_shared/constants.py
    - Servicio canonico: pronto-libs/src/pronto_shared/services/order_state_machine.py
    - Prohibido workflow_status = ... fuera del servicio canonico
    - Prohibido payment_status = ... fuera del servicio canonico
    - Estados: solo en constants.py (OrderStatus, PaymentStatus)

OTRAS REGLAS:

1. PRONTO_ROUTES_ONLY=1
   - create_app() debe soportar PRONTO_ROUTES_ONLY=1
   - En routes-only: solo registro de rutas/blueprints
   - Prohibido side-effects: No DB init, No Redis, No syncs, No schedulers

2. Versionado del Root (P0)
    - Root es workspace aggregator local no se pushea
    - Copia de seguridad versionada en: pronto-scripts/pronto-root/
    - Cada vez que se modifique un archivo en la carpeta pronto/ del root, copiar a pronto-scripts/pronto-root/

3. Control de version del sistema (P0)
    - Variable canonica: PRONTO_SYSTEM_VERSION (en .env y .env.example)
    - Formato obligatorio: 1.0000 (1 entero + 4 digitos decimales)
    - Valor inicial base: 1.0000
    - Cada modificacion aplicada por un agente AI debe incrementar +1 en los 4 digitos decimales
    - Al modificar version en root, replicar el cambio en pronto-scripts/pronto-root/.env y .env.example

4. Bitacora de version AI (P0)
    - Cada cambio aplicado por AI debe registrar evidencia en pronto-docs/versioning/AI_VERSION_LOG.md
    - Formato obligatorio por entrada:
      - FECHA (YYYY-MM-DD)
      - VERSION_ANTERIOR
      - VERSION_NUEVA
      - AGENTE
      - MODULOS
      - RESUMEN

Entrega:
- Documentacion de cada regla
- Validaciones automaticas
- Scripts de verificacion
```

PASOS_REPRODUCIR:
1. Verificar ausencia de session en `pronto-api` y `pronto-employees`:
   - `rg -n --hidden "\\b(flask\\.session|from flask import session|\\bsession\\[)" pronto-api/src pronto-employees/src`
2. Verificar soporte routes-only:
   - `rg -n "PRONTO_ROUTES_ONLY" pronto-client/src pronto-employees/src`
3. Verificar checks pre-boot con DB:
   - `DATABASE_URL='postgresql://pronto:pronto123@localhost:5432/pronto' ./pronto-scripts/bin/pronto-migrate --check`
   - `DATABASE_URL='postgresql://pronto:pronto123@localhost:5432/pronto' ./pronto-scripts/bin/pronto-init --check`
4. Verificar versionado root:
   - existencia de `pronto-scripts/pronto-root/.env` y `.env.example`
   - sincronía de `PRONTO_SYSTEM_VERSION` en root y copia versionada.

RESULTADO_ACTUAL:
- Sin hallazgos de `session` prohibida en `pronto-api`/`pronto-employees`.
- `PRONTO_ROUTES_ONLY` presente en `app.py` de client/employees.
- `pronto-migrate --check`: `pending=0 drift=0`.
- `pronto-init --check`: `ok: true`.
- Versionado de root y bitácora AI activos y sincronizados.

RESULTADO_ESPERADO:
Cumplimiento operativo de guardrails de arquitectura P0 y validaciones pre-boot canónicas.

UBICACION:
- pronto-api/src/
- pronto-employees/src/
- pronto-client/src/
- pronto-scripts/bin/pronto-migrate
- pronto-scripts/bin/pronto-init
- pronto-scripts/pronto-root/

EVIDENCIA:
Validaciones ejecutadas el 2026-02-18 con resultados en verde para session guard, routes-only y checks pre-boot.

HIPOTESIS_CAUSA:
Pendiente documental de cierre; los mecanismos base de enforcement ya estaban implementados en el repositorio.

ESTADO: RESUELTO
SOLUCION:
Se validaron y documentaron los controles de arquitectura P0 aplicables (session guard, routes-only, pre-boot checks y versionado root), cerrando formalmente el prompt 22.

COMMIT: pendiente
FECHA_RESOLUCION: 2026-02-18
