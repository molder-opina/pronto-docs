# PRONTO Validation System

## Overview

The PRONTO Validation System is an **agent-independent**, **evidence-based** validation toolkit that enforces architectural guardrails, database invariants, and code quality standards.

**Key Principle:** No results without raw evidence. All validations must provide stdout, stderr, counts, and concrete proof.

---

## Critical Rules

### 1. No Results Without Raw Output

Every validation MUST include:
- stdout (actual command output)
- stderr (errors if any)
- Concrete counts (matches, rows, files)
- Raw output (full diff or query results)

**Valid:**
```text
rg "idempotency_service"
→ 0 matches
```

**Invalid:**
```text
No se encontraron resultados
```

### 2. Negative Validation

Not enough to say "no errors". Must prove WHY something is NOT broken:
- Show DB row counts
- Show payload diff before/after
- Show actual log output

### 3. Dependency Drift Control

All new imports/dependencies must be tracked:
```bash
# Before changes
rg "import .*" | sort > imports_before.txt

# After changes
rg "import .*" | sort > imports_after.txt

# Compare
diff imports_before.txt imports_after.txt
```

If new dependencies appear → manual review required.

### 4. Complexity Limits

Per file modification:
- Max +30% lines
- No new layers without justification
- No new concepts without documentation

### 5. Final Isolation Test (P9-002)

```bash
mv services services_backup
pytest
```

If tests still pass → hidden dependency detected.

### 6. Quick-Fix Detector

If a change:
- Avoids an error
- But doesn't explain root cause

→ **INVALID**

### 7. Explicit Invariants

For payments:
- 1 idempotency_key → max 1 payment
- Paid session → no new payments
- Outbox → always consistent with DB

---

## CLI Tools

### pronto-validate (Master Orchestrator)

```bash
# Validate staged files
pronto-validate --staged

# Validate changed files
pronto-validate --changed

# Validate specific files
pronto-validate --files file1.py,file2.py

# Save current state as baseline
pronto-validate --save-baseline

# List all checks
pronto-validate --list-checks

# Self-test
pronto-validate --self-test
```

**Exit codes:**
- `0` = All checks passed
- `1` = Validation failed
- `2` = Warnings (passed with warnings)

### pronto-layering-check (AST-based)

```bash
# Check staged files
pronto-layering-check --staged

# Check entire project
pronto-layering-check --full

# Self-test
pronto-layering-check --self-test
```

**Enforces:**
- No cross-layer imports
- Console isolation (waiter/chef/cashier/admin/system)
- Forbidden imports (flask.session, legacy_mysql, etc.)

### pronto-invariant-check (SQL validation)

```bash
# Check all invariants
pronto-invariant-check

# Check specific invariant
pronto-invariant-check --check idempotency_uniqueness

# List all invariants
pronto-invariant-check --list

# Self-test
pronto-invariant-check --self-test
```

**Enforces:**
- Idempotency uniqueness
- Payment consistency
- Order workflow validity
- Session status validity

### pronto-drift-detect (Import tracking)

```bash
# Check staged files
pronto-drift-detect --staged

# Save baseline
pronto-drift-detect --save-baseline

# Show baseline
pronto-drift-detect --show-baseline

# Allow specific new deps
pronto-drift-detect --allow-new-deps requests,numpy
```

**Enforces:**
- No unexpected new dependencies
- Import tracking before/after
- Baseline comparison

---

## Architecture

```
pronto-scripts/
├── bin/
│   ├── pronto-validate           # Master orchestrator
│   ├── pronto-layering-check     # AST-based layering
│   ├── pronto-invariant-check    # SQL invariants
│   └── pronto-drift-detect       # Import drift
├── lib/
│   └── validation/
│       ├── __init__.py
│       ├── core.py               # Core primitives
│       ├── layering.py           # AST layering checker
│       ├── invariants.py         # SQL invariant checker
│       ├── drift.py              # Import drift detector
│       └── complexity.py         # Complexity checker
└── .validation-baseline/         # Baseline storage
```

---

## Integration

### Pre-commit Hook

Add to `.git/hooks/pre-commit`:

```bash
#!/bin/bash
set -euo pipefail

# Run validation on staged files
./pronto-scripts/bin/pronto-validate --staged --mode enforce

exit_code=$?

if [ $exit_code -ne 0 ]; then
  echo "✗ Validation failed"
  exit 1
fi

echo "✓ Validation passed"
exit 0
```

### CI Pipeline

```yaml
# .github/workflows/validation.yml
name: Validation

on: [push, pull_request]

jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.12'
      
      - name: Install dependencies
        run: |
          pip install psycopg2-binary
      
      - name: Run validation
        run: |
          ./pronto-scripts/bin/pronto-validate --changed
      
      - name: Run layering check
        run: |
          ./pronto-scripts/bin/pronto-layering-check --changed
      
      - name: Run invariant check
        run: |
          ./pronto-scripts/bin/pronto-invariant-check
        env:
          POSTGRES_HOST: ${{ secrets.DB_HOST }}
          POSTGRES_PORT: 5432
          POSTGRES_DB: ${{ secrets.DB_NAME }}
          POSTGRES_USER: ${{ secrets.DB_USER }}
          POSTGRES_PASSWORD: ${{ secrets.DB_PASSWORD }}
```

---

## Validation Checks

### Layering Check

| Check | Description | Severity |
|-------|-------------|----------|
| cross_layer | Import from unauthorized layer | Error |
| cross_console | Import from another console | Error |
| forbidden | Forbidden import (flask.session, etc.) | Critical |

### Invariant Check

| Invariant | Description | Severity |
|-----------|-------------|----------|
| idempotency_uniqueness | 1 idempotency_key → 1 payment | Critical |
| paid_session_no_new_payments | Paid sessions reject new payments | Critical |
| payment_status_consistency | Payment status matches transaction | High |
| order_workflow_validity | Order status is valid | High |
| session_status_validity | Session status is valid | High |

### Drift Check

| Check | Description | Severity |
|-------|-------------|----------|
| new_imports | New imports detected | Warning |
| new_dependencies | New top-level dependencies | Error (if unapproved) |
| removed_imports | Imports removed | Info |

### Complexity Check

| Check | Description | Threshold |
|-------|-------------|-----------|
| line_growth | Line count increase | Max +30% |
| new_layers | New top-level directories | Warning |

---

## Evidence Format

All validations produce evidence in this format:

```json
{
  "name": "layering-check",
  "status": "PASSED|FAILED|WARNING",
  "message": "Human-readable message",
  "evidence": {
    "stdout": "Command output",
    "stderr": "Error output",
    "return_code": 0,
    "match_count": 0,
    "row_count": 0,
    "file_count": 10,
    "raw_output": "Full raw output",
    "diff_output": "Diff if applicable"
  },
  "suggestions": ["Fix suggestion 1", "Fix suggestion 2"]
}
```

---

## Best Practices

1. **Always run before commit:**
   ```bash
   pronto-validate --staged
   ```

2. **Save baseline after major changes:**
   ```bash
   pronto-validate --save-baseline
   ```

3. **Check invariants after payment changes:**
   ```bash
   pronto-invariant-check
   ```

4. **Review drift before merging:**
   ```bash
   pronto-drift-detect --changed
   ```

5. **Full project audit monthly:**
   ```bash
   pronto-layering-check --full
   pronto-invariant-check
   ```

---

## Troubleshooting

### "No baseline exists"

Run with `--save-baseline` to create initial baseline:
```bash
pronto-drift-detect --save-baseline
```

### "Database connection failed"

Set environment variables:
```bash
export POSTGRES_HOST=localhost
export POSTGRES_PORT=5432
export POSTGRES_DB=pronto
export POSTGRES_USER=pronto
export POSTGRES_PASSWORD=***
```

### "Too many violations"

Review violations and fix systematically:
```bash
pronto-layering-check --staged --json > violations.json
```

### "False positive"

Add to allowed list or update baseline:
```bash
pronto-drift-detect --allow-new-deps new_dependency
pronto-validate --save-baseline
```

---

## Version

- **Version:** 1.0.0
- **Last Updated:** 2026-03-20
- **Author:** PRONTO Team
