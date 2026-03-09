# Pronto-Backups Documentation

## Overview

`pronto-backups` documenta y resguarda artefactos de respaldo del workspace PRONTO.

### Alcance actual del repo
- `archive/` - respaldos archivados históricos
- `pronto-app-backup-20260201/` - snapshot agregado actualmente presente

## Canon operativo

La convención vigente para respaldos por cambio es la descrita en:

- `../contracts/pronto-backups/files.md`
- `../contracts/pronto-backups/events.md`
- `../contracts/pronto-scripts/files.md`

### Scripts canónicos
- `pronto-scripts/bin/pronto-backup-change`
- `pronto-scripts/bin/pronto-restore-change`
- `pronto-scripts/bin/pronto-backups-gc`

## Reglas importantes

- El respaldo por defecto de base de datos debe ser **schema-only** salvo autorización explícita.
- Los dumps de datos y restores manuales son acciones sensibles.
- Los respaldos son **evidencia operativa**, no sustituyen al código versionado ni a `pronto-docs/contracts/`.
- No se deben subir dumps sensibles ni artefactos ad-hoc fuera de la convención documentada.

## Estructura contractual de cambios

La estructura canónica es:

- `changes/CHG-*/meta/`
- `changes/CHG-*/patch/`
- `changes/CHG-*/files/`
- `changes/CHG-*/db/`
- `changes/CHG-*/logs/`

## Uso recomendado

### Antes de un cambio sensible
1. Crear snapshot con `pronto-backup-change`
2. Registrar razón/agent de forma explícita
3. Mantener el dump de DB en modo schema-only si no hay autorización adicional

### Si se requiere recuperación
- Usar `pronto-restore-change` sobre un `CHANGE_ID` conocido
- Tratar restores como operación controlada y no como rutina documental

## Anti-reglas

- No documentar ni fomentar borrados masivos ad-hoc de backups desde README
- No asumir `.tar.gz` o formatos legacy como canon actual si no están respaldados por scripts vigentes
- No tratar este módulo como fuente de verdad de datos runtime

## Referencias

- `../../pronto-backups/README.md`
- `../pronto-backups.md`
- `../contracts/pronto-backups/README.md`
- `../contracts/pronto-scripts/README.md`

