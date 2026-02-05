# pronto-backups
Version-Reglas: 1.0
Ultima-Revision: 2026-02-03
Owner: equipo-platform
SLO-Docs: actualizar en el mismo PR

## Resumen Operativo
Backups por cambio con estructura estándar y scripts de restore/GC.

## Reglas Clave
### Reglas
- Antes de cambios: `pronto-backup-change`.
- DB dump por defecto schema-only.

### Hechos verificados
- [✅] pronto-backups/README.md:1 → cd "/Users/molder/projects/github - molder/pronto" && sed -n '1,80p' pronto-backups/README.md

### Pendiente de verificación
- [❓] Migrar backups legacy a la estructura changes/.

## Contratos Públicos
- Backup format: `pronto-docs/contracts/pronto-backups/files.md`.

## Matriz de Dependencias
```yaml
deps:
  depende_de: [pronto-scripts]
  consume: [cli_contracts]
  produce: [backup_format]
  produce_para: [pronto-scripts]
  consumido_por: [pronto-scripts]
```

## Operación / Ejecución
- `pronto-scripts/bin/pronto-backup-change`.
- `pronto-scripts/bin/pronto-restore-change`.

## Validaciones / Tests
- `pronto-rules-check` valida estructura.

## Anti-reglas
- NO: subir dumps a git
  PORQUE: riesgo de datos sensibles

## Referencias
- `pronto-backups/README.md`
