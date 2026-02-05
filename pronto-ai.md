# pronto-ai
Version-Reglas: 1.0
Ultima-Revision: 2026-02-03
Owner: equipo-platform
SLO-Docs: actualizar en el mismo PR

## Resumen Operativo
Políticas y configuración para agentes/skills.

## Reglas Clave
### Reglas
- No modificar sin orden explícita.
- Router semántico vive en `pronto-ai/router.yml`.

### Hechos verificados
- [✅] pronto-ai/README.md:1 → cd "/Users/molder/projects/github - molder/pronto" && sed -n '1,80p' pronto-ai/README.md
- [✅] pronto-ai/router.yml:1 → cd "/Users/molder/projects/github - molder/pronto" && sed -n '1,80p' pronto-ai/router.yml

### Pendiente de verificación
- [❓] Completar políticas en `pronto-ai/policies/`.

## Contratos Públicos
- AI policies: `pronto-docs/contracts/pronto-ai/files.md`.

## Matriz de Dependencias
```yaml
deps:
  depende_de: [pronto-docs]
  consume: [docs_format]
  produce: [ai_policies]
  produce_para: [pronto-docs]
  consumido_por: [pronto-docs]
```

## Operación / Ejecución
- `pronto-rules-check` valida router.

## Validaciones / Tests
- Validación de hash router.

## Anti-reglas
- NO: cambios sin actualizar policies
  PORQUE: rompe control de agentes

## Referencias
- `pronto-ai/README.md`
- `pronto-ai/router.yml`
