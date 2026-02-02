# Pronto Documentation

Project documentation for the Pronto restaurant management system.

## Contents

This folder contains:
- Architecture documentation
- API specifications
- Development guides
- Deployment procedures
- User manuals

## Quick Links

- [Docker Compose Guide](../DOCKER_COMPOSE.md)
- [Changelog](../CHANGELOG.md)

## Building Documentation

If using a documentation generator:

```bash
# MkDocs
mkdocs build
mkdocs serve

# Sphinx
make html
```

## Structure

```
pronto-docs/
├── architecture/     # System architecture docs
├── api/              # API documentation
├── guides/           # Development guides
├── deployment/       # Deployment procedures
└── user/             # End-user documentation
```

## Contributing

When adding documentation:
1. Use Markdown format
2. Include code examples where relevant
3. Keep documentation up-to-date with code changes
4. Add diagrams for complex flows
