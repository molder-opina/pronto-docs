# pronto-static
Version-Reglas: 1.0
Ultima-Revision: 2026-02-03
Owner: equipo-frontend
SLO-Docs: actualizar en el mismo PR

## Resumen Operativo
Nginx para assets estáticos. Build Vue/Vite. Assets servidos desde `/assets`.

## Reglas Clave
### Reglas
- Nuevo UI en Vue/Vite.
- Legacy vanilla permitido solo si ya existe.
- Produces: `http_assets`, `asset_manifest`.

### Hechos verificados
- [✅] pronto-static/README.md:1 → cd "/Users/molder/projects/github - molder/pronto" && sed -n '1,120p' pronto-static/README.md
- [⚠️] rg -n "assets" pronto-static/src/static_content

### Pendiente de verificación
- [❓] Generar manifest de assets si aplica.

## Contratos Públicos
- Files: `pronto-docs/contracts/pronto-static/files.md`.

## Matriz de Dependencias
```yaml
deps:
  depende_de: []
  consume: []
  produce: [http_assets, asset_manifest]
  produce_para: [pronto-client, pronto-employees]
  consumido_por: [pronto-client, pronto-employees]
```

## Operación / Ejecución
- Compose canónico: `docker-compose.yml`.
- Build: `pronto-static/src/static_content/Dockerfile`.

## Validaciones / Tests
- Build Vue/Vite (pnpm build).

## Anti-reglas
- NO: inline handlers nuevos
  PORQUE: rompe CSP/seguridad

## Referencias
- `pronto-static/README.md`
- `pronto-static/ESTRUCTURA.md`
