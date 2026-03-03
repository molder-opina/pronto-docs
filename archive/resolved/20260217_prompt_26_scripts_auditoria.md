ID: PROMPT-26
FECHA: 2026-02-17
PROYECTO: PRONTO-System
SEVERIDAD: alta
TITULO: PROMPT 26 - Scripts de Mantenimiento y Auditoria

DESCRIPCION:
Falta crear prompt para implementar los scripts de mantenimiento y auditoria.

CONTENIDO PROMPT:

```
Implementa los scripts de mantenimiento y auditoria para PRONTO:

SCRIPTS DE MANTENIMIENTO:

1. pronto-full-audit.sh
   - Ejecuta auditorias LLM integrales por proyecto enfocadas en:
     * Integridad de Negocio: Validacion de flujos (orden, pago, entrega).
     * Pureza Arquitectonica: Prohibicion absoluta de estaticos locales fuera de pronto-static.
     * Calidad de Codigo: Deteccion de imports rotos, codigo legacy, deduplicacion y fallbacks peligrosos.
     * Seguridad: Aislamiento de sesiones y proteccion de PII.
     * Integridad de Estructuras: Consistencia DDL (SQL) vs Modelos (Python) vs Interfaces (TypeScript).

2. pronto-inconsistency-check
   - Verifica invariantes locales y roles.
   - Valida consistencia de version
   - Verifica configuraciones

3. pronto-api-parity-check
   - Valida consistencia frontend/backend
   - Compara rutas implementadas con specs

4. pronto-sql-safety
   - Valida SQL migrations
   - Previene DROP TABLE fuera de migrations/
   - Previene SQL destructivo

5. pronto-migrate
   - Gestion de migrations
   - Soporta --apply, --check, --dry-run
   - Registra en tabla pronto_schema_migrations

6. pronto-init
   - Gestion de init (bootstrap + seeds)
   - Soporta --apply, --check
   - Verifica esquema antes de iniciar

7. pronto-git-all.sh
   - Sincroniza cambios en todos los repos
   - Commands: status, sync, pull

SCRIPTS DE AUDITORIA:

1. pronto-audit/bin/run-audit.sh
   - Interfaz de ejecucion para el agente basado en CrewAI
   - Requiere .venv interno con Python 3.12
   - Genera reportes en pronto-audit/reports/
   - Crea GitHub Issues

2. pre-commit-ai
   - Hook de pre-commit
   - Analiza archivos cambiados
   - Exit 1 si BLOCKER

ESTRUCTURA DE SCRIPTS:

pronto-scripts/bin/
├── pronto-migrate           # Gestion migrations
├── pronto-init              # Gestion init
├── pronto-sql-safety       # Validacion SQL
├── pronto-full-audit.sh    # Auditoria completa
├── pronto-inconsistency-check
├── pronto-api-parity-check
├── pronto-git-all.sh
├── pre-commit-ai
└── bin/lib/                # Funciones compartidas

pronto-scripts/init/
├── sql/
│   ├── 00_bootstrap/       # Schema base (idempotente)
│   ├── 10_schema/         # Tablas
│   ├── 20_migrations/     # No se usa
│   ├── 30_views/          # Vistas
│   ├── 40_seeds/           # Datos iniciales
│   └── migrations/         # Migrations (evolutivo)

REGLAS DE SCRIPTS:

1. Parametrizable: acepta flags para diferentes modos
2. Idempotente: puede ejecutarse multiples veces
3. No side-effects peligrosos
4. Logs claros
5. Exit codes apropiados
6. Ubicacion correcta en bin/

Entrega:
- Todos los scripts listados
- Documentacion de uso
- Tests de validacion
- Validaciones de idempotencia
```

PASOS_REPRODUCIR:
1. Verificar existencia en `pronto-scripts/bin/` y `pronto-audit/bin/`.
2. Verificar ejecutables:
   - `pronto-scripts/bin/pronto-full-audit.sh`
   - `pronto-scripts/bin/pronto-inconsistency-check`
   - `pronto-scripts/bin/pronto-api-parity-check`
   - `pronto-scripts/bin/pronto-sql-safety`
   - `pronto-scripts/bin/pronto-migrate`
   - `pronto-scripts/bin/pronto-init`
   - `pronto-scripts/bin/pronto-git-all.sh`
   - `pronto-scripts/bin/pre-commit-ai`
   - `pronto-audit/bin/run-audit.sh`

RESULTADO_ACTUAL:
Los scripts requeridos existen y están marcados como ejecutables.

RESULTADO_ESPERADO:
Disponibilidad operativa de scripts de mantenimiento y auditoría en ubicaciones canónicas.

UBICACION:
- pronto-scripts/bin/
- pronto-audit/bin/run-audit.sh
- .git/hooks/pre-commit

EVIDENCIA:
Verificación ejecutada el 2026-02-18: `test -x` exitoso para todos los scripts críticos listados.

HIPOTESIS_CAUSA:
Pendiente documental de cierre del prompt pese a que el tooling ya estaba implementado en el repositorio.

ESTADO: RESUELTO
SOLUCION:
Se validó inventario de scripts canónicos y su ejecutabilidad, y se cerró formalmente el incidente documental asociado al prompt 26.

COMMIT: pendiente
FECHA_RESOLUCION: 2026-02-18
