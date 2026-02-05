# pronto-docs
Version-Reglas: 1.0
Ultima-Revision: 2026-02-03
Owner: equipo-platform
SLO-Docs: actualizar en el mismo PR

## Resumen Operativo
Documentación del monorepo. Reglas y contratos por módulo.

## Reglas Clave
### Reglas
- Docs deben actualizarse en el mismo PR.
- Formato de módulos obligatorio.

### Hechos verificados
- [✅] pronto-docs/README.md:1 → cd "/Users/molder/projects/github - molder/pronto" && sed -n '1,80p' pronto-docs/README.md

### Pendiente de verificación
- [❓] Completar índice de módulos.

## Contratos Públicos
- Docs format: `pronto-docs/contracts/pronto-docs/files.md`.

## Matriz de Dependencias
```yaml
deps:
  depende_de: []
  consume: []
  produce: [docs_format]
  produce_para: [pronto-scripts]
  consumido_por: [pronto-scripts]
```

## Operación / Ejecución
- Actualizar docs en PRs.

## Validaciones / Tests
- `pronto-rules-check`.

## Anti-reglas
- NO: docs desalineados con código
  PORQUE: rompe control de cambios

## Referencias
- `pronto-docs/README.md`
