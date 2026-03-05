ID: CODE-20260303-015
FECHA: 2026-03-03
PROYECTO: pronto-libs
SEVERIDAD: media
TITULO: Desajuste de namespaces en contrato de configuración vs semilla

DESCRIPCION: |
  Existía discrepancia entre llaves del `CONFIG_CONTRACT` y llaves usadas por seed/migraciones (`legacy` sin namespace), lo que rompía validaciones de integridad.

RESULTADO_ACTUAL: |
  Fallos por llaves no reconocidas al validar configuración.

RESULTADO_ESPERADO: |
  Uso exclusivo de llaves canónicas namespaced en contrato, seeds y base de datos.

UBICACION: |
  - `pronto-libs/src/pronto_shared/config_contract.py`
  - `pronto-libs/src/pronto_shared/services/seed.py`
  - `pronto-scripts/init/sql/migrations/20260305_01__remove_legacy_config_keys.sql`

ESTADO: RESUELTO

SOLUCION: |
  Se retiraron llaves legacy del contrato/seed, se normalizaron referencias runtime a llaves canónicas y se aplicó migración de limpieza (`20260305_01__remove_legacy_config_keys.sql`). Además, el validador por scope (`validate-required-config-by-scope.sh`) bloquea reintroducción de llaves legacy.

COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-05
