# Pronto Monorepo Structure

This document explains the repository structure for the Pronto system.

## Overview

Pronto uses a **monorepo** architecture where all services and components live in a single Git repository. Each `pronto-*` folder is a logical module, not a separate repository.

## Repository Structure

```
pronto/                    # Root repository
├── pronto-api/            # Python Flask API server
├── pronto-client/         # Python Flask client web app
├── pronto-employees/      # Python Flask employee portal
├── pronto-static/         # Vue.js static content (menus, dashboards)
├── pronto-shared/         # Shared Python library (pronto-libs)
├── pronto-tests/          # End-to-end tests (Playwright)
├── pronto-ai/             # AI agent configuration
├── pronto-backups/        # Backup scripts and utilities
├── pronto-docs/           # Documentation
├── pronto-redis/          # Redis configuration
├── pronto-scripts/        # Utility scripts
├── docker-compose.yml     # Service orchestration
└── CHANGELOG.md           # Version history
```

## Why Monorepo?

1. **Atomic changes** - Cross-service updates in single commits
2. **Shared dependencies** - Common library (pronto-shared) easily referenced
3. **Simplified CI/CD** - One pipeline for all services
4. **Consistent tooling** - Same linting, testing, deployment patterns

## Working with the Monorepo

### Cloning

```bash
git clone git@github.com:molder/pronto.git
cd pronto
```

### Service Development

Each service can be developed independently:

```bash
# API development
cd pronto-api
pip install -e ../pronto-shared
python run.py

# Static content development
cd pronto-static
npm install
npm run dev
```

### Docker Compose

Run all services together:

```bash
# Development
docker compose up

# Specific profile
docker compose --profile infra up
docker compose --profile web up
```

### Dependencies

- Python services depend on `pronto-shared` (installed via pip)
- Docker builds copy shared library during build phase
- Version consistency maintained in requirements.txt files

## Versioning

- All services share the same Git history
- CHANGELOG.md tracks cross-service releases
- Individual services may have internal version numbers

## Git Workflow

1. Feature branches from `main`
2. Pull requests for code review
3. Merge to `main` triggers deployment
4. Tags for production releases
