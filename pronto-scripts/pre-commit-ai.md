# Pre-commit AI Hook

## Proposito

Validar cambios en staging contra el contexto completo del monorepo PRONTO antes de permitir un commit.

## Instalacion

El hook se instala automaticamente al symlinkear:

```bash
ln -sf pronto-scripts/bin/pre-commit-ai .git/hooks/pre-commit
```

## Proyectos cubiertos

- pronto-static
- pronto-api
- pronto-employees
- pronto-client

## Que valida

### BLOCKER (rechaza commit)
- `flask.session` en api/employees
- Roles no canónicos (admin_roles, etc.)
- Static local fuera de pronto-static
- Código duplicado de pronto-libs
- Version PostgreSQL no canonica referenciada (canonico: 16-alpine)
- Secrets hardcodeados
- docker-compose modificado
- Contratos rotos (openapi, redis, db_schema)

### WARN (permite pero alerta)
- Docs desfasadas sin romper contrato
- JS duplicado funcional
- Refactors menores

## Uso manual

```bash
# Verificar sin hacer commit
pronto-scripts/bin/pre-commit-ai

# Forzar skip (no recomendado)
git commit --no-verify -m "..."
```

## Salida

| Exit Code | Significado |
|-----------|-------------|
| 0 | OK, commit permitido |
| 1 | BLOCKER detectado, corregir antes de commit |
| 0 | Sin archivos staged, skip |

Logs en: `docs/change-logs/PRECOMMIT-<timestamp>/`
