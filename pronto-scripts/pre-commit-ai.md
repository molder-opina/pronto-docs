# Pre-commit AI Hook

## Propósito

`pre-commit-ai` es el gate único determinístico de PRONTO (núcleo + perfiles por repo).

## Flags principales

```bash
pronto-scripts/bin/pre-commit-ai \
  --repo pronto-api \
  --staged|--changed|--files "a.py,b.py" \
  --mode warn|enforce \
  --timeout-seconds 30 \
  --report tmp/precommit-report.md \
  --self-test
```

## Perfiles y checks

Configuración versionada en:

- `pronto-scripts/config/gate-profiles.yml`

Checks implementados:

- `staged_artifacts` (bloquea `node_modules/`, `dist/`, `build/`)
- `api_auth_policy`
- `assets_policy`
- `mypy` (faseado, controlado con `PRONTO_ENABLE_TYPES=1`)
- `tsc_no_emit` (faseado, requiere `tsconfig.json`)

## Códigos de salida

| Exit Code | Significado |
|-----------|-------------|
| 0 | APPROVED |
| 1 | REJECTED |
| 2 | WARNINGS |

## Política local/CI

- Local (`PRONTO_GATE_CONTEXT=local`): timeout => warning (exit 2).
- CI (`PRONTO_GATE_CONTEXT=ci`): timeout => failure (exit 1).

## Hook local recomendado

Para instalar hooks en repos núcleo:

```bash
bash pronto-scripts/bin/install-guardrails-hooks.sh
```

Esto instala:

- `pre-commit` local (`pre-commit-ai --staged --mode warn`)
- `pre-push` local (`pre-commit-ai --changed --mode enforce`)

Para activar también smoke E2E local en `pre-push`:

```bash
bash pronto-scripts/bin/install-guardrails-hooks.sh --with-smoke
```

## Required checks en GitHub (Modelo B)

Para fijar branch protection con checks requeridos:

```bash
# Dry-run (no aplica cambios)
bash pronto-scripts/bin/pronto-configure-required-checks --repo <owner/repo> --branch main

# Aplicar cambios (crea branch protection si no existe)
# Requiere: gh auth login + permisos admin del repo
bash pronto-scripts/bin/pronto-configure-required-checks --repo <owner/repo> --branch main --apply

# Opcional: desactivar bootstrap automático
bash pronto-scripts/bin/pronto-configure-required-checks --repo <owner/repo> --branch main --apply --no-bootstrap
```

Checks que configura:

- `guardrails-static`
- `smoke-critical`

Notas operativas:

- Si GitHub responde `HTTP 403` con `Upgrade to GitHub Pro or make this repository public`, no es un bug del script: la cuenta/plan no permite branch protection en ese repo privado.
- Si operas en modo solo-local, puedes omitir esta sección y depender solo de hooks locales.
