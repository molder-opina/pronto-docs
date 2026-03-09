# File Naming Standard

Estandar operativo del monorepo PRONTO para nombres de archivos propios del proyecto.

## Objetivo

- Reducir drift entre repos.
- Evitar nombres mixtos por tecnología.
- Permitir enforcement automático con `./pronto-scripts/bin/pronto-file-naming-check`.

## Regla general

Todo archivo propio del proyecto debe cumplir un patrón por categoría o estar cubierto por una excepción canónica explícita.

## Matriz por tipo

- Directorios funcionales: `kebab-case/`
- Paquetes Python: `snake_case/`
- Python: `snake_case.py`
- Vue SFC: `PascalCase.vue`
- TS/JS modules, composables, utils, helpers, tests: `kebab-case.ts|js`
- Declaration files: `global.d.ts`, `shims-vue.d.ts`, `<kebab-case>.d.ts`
- Shell scripts: `kebab-case.sh`
- Templates SSR/Jinja: `snake_case.html`
- Partials/includes SSR: `_snake_case.html`
- CSS no generado: `kebab-case.css`
- Markdown general: `kebab-case.md`
- Incidentes/resolved/errors: `YYYYMMDD_slug.md`

## Excepciones canónicas permitidas

- Ecosistema/tooling: `Dockerfile`, `Makefile`, `package.json`, `package-lock.json`, `pyproject.toml`, `poetry.lock`, `requirements.txt`, `tsconfig.json`, `pytest.ini`, `.env`, `.env.example`, `.gitignore`, `.dockerignore`, `.prettierrc`, `.eslintrc.cjs`
- Python: `__init__.py`, `conftest.py`
- Vue: `App.vue`
- Entrypoints/config TS/JS: `main.ts`, `main.js`, `index.ts`, `index.js`, `vite.config.ts`, `playwright.config.ts`, `vitest.config.ts`
- Documentos de autoridad: `README.md`, `AGENTS.md`, `CHANGELOG.md`, `CLAUDE.md`, `GEMINI.md`, `DOCKER_COMPOSE.md`
- Changelogs generados: `CHG-*`, `PRECOMMIT-*`, `inconsistencies.<provider>.md`
- SQL de init/migrations: respetan sus prefijos contractuales existentes

## Fuera de enforcement directo

- `node_modules/`, `build/`, `dist/`, `vendor/`
- `archive/`, `archived/`, backups y mirrors versionados
- artefactos generados en assets compilados
- logs, reportes y snapshots generados

## Reglas de migración

1. Renombrar por lotes pequeños y homogéneos.
2. Actualizar imports, referencias y docs en el mismo lote.
3. Validar con build/test/check focalizado.
4. No introducir excepciones ad hoc locales.

## Validación manual

```bash
./pronto-scripts/bin/pronto-file-naming-check --report --repo pronto-static
./pronto-scripts/bin/pronto-file-naming-check --report --repo pronto-scripts
./pronto-scripts/bin/pronto-file-naming-check --report --repo pronto-tests
```

