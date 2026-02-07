# Features Documentation

This directory contains detailed documentation for major features implemented in the PRONTO monorepo.

## Index of Features

| Feature | Status | Date | PR/Branch |
|---------|--------|------|-----------|
| [JWT Dual Mode](jwt-dual-mode/README.md) | Implemented | 2026-02-06 | feat/fase2-jwt-dual-mode |

## Adding New Features

When implementing a new major feature:

1. Create a new folder: `features/<feature-name>/`
2. Create `README.md` with feature overview
3. Create `PLAN.md` with implementation details
4. Create `APPLIED.md` with final changes applied
5. Link from this file in the table above

## Feature Structure

```
features/
├── <feature-name>/
│   ├── README.md          # Feature overview and architecture
│   ├── PLAN.md            # Original plan and requirements
│   ├── APPLIED.md        # Final changes applied
│   └── references/       # Additional docs, diagrams, etc.
```

## Current Features

### JWT Dual Mode (jwt-dual-mode)

Implementation of JWT-based authentication with dual mode support:
- **Anonymous mode**: For guest users (8h TTL)
- **Client mode**: For authenticated customers (4h TTL)
- Cross-subdomain cookie sharing
- CORS configuration for API access

See [jwt-dual-mode/README.md](jwt-dual-mode/README.md) for details.
