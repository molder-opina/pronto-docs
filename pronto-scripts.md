# pronto-scripts
Version-Reglas: 1.0
Ultima-Revision: 2026-02-03
Owner: equipo-platform
SLO-Docs: actualizar en el mismo PR

## Resumen Operativo
Scripts operativos y de automatización. Binarios en `pronto-scripts/bin`.

## Reglas Clave
### Reglas
- Scripts operativos en `bin/`.
- Idempotentes y parametrizables.

### Hechos verificados
- [✅] pronto-scripts/README.md:1 → cd "/Users/molder/projects/github - molder/pronto" && sed -n '1,80p' pronto-scripts/README.md
- [✅] pronto-scripts/INCONSISTENCIAS.md:1 → cd "/Users/molder/projects/github - molder/pronto" && sed -n '1,120p' pronto-scripts/INCONSISTENCIAS.md

### Pendiente de verificación
- [❓] Revisar scripts legacy para compatibilidad.

## Contratos Públicos
- CLI: `pronto-docs/contracts/pronto-scripts/files.md`.
- Modules schema: `pronto-docs/contracts/pronto-scripts/modules.schema.json`.

## Matriz de Dependencias
```yaml
deps:
  depende_de: [pronto-docs]
  consume: [docs_format]
  produce: [cli_contracts]
  produce_para: [pronto-docs]
  consumido_por: [pronto-docs]
```

## Operación / Ejecución
- Ejecutar desde raíz: `./pronto-scripts/bin/<script>`.

## Validaciones / Tests
- Scripts deben ser idempotentes.

## Anti-reglas
- NO: rutas absolutas locales
  PORQUE: rompe portabilidad

## Referencias
- `pronto-scripts/README.md`
- `pronto-scripts/INCONSISTENCIAS.md`
