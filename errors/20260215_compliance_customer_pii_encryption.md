---
ID: 20260215_compliance_customer_pii_encryption
DATE: 2026-02-15
PROJECT: pronto-libs
SEVERITY: Critical
TITLE: Customer PII not using encrypted columns in ORM
DESCRIPTION: |
  The `Customer` model in `pronto_shared/models.py` maps `email` and `phone` fields directly to plain text columns, violating the strict security mandate in `AGENTS.md`.
  
  `AGENTS.md` states: "PII (email, phone, name) must be stored in `_encrypted` columns. Raw SQL must use these columns, not ORM properties."
  
  While the database schema contains `email_encrypted` and `name_encrypted` columns, the ORM model is configured to use the legacy/plain `email` and `phone` columns. This leaves PII vulnerable and unencrypted in the database if the application uses the ORM for persistence.
LOCATION: `pronto-libs/src/pronto_shared/models.py`
REPRODUCTION:
  1. Inspect `pronto_shared/models.py`.
  2. Verify `Customer` class defines `email` as `Mapped[str]`.
EXPECTED: `Customer` model should map `email_encrypted` and use hybrid properties to handle encryption/decryption transparently, accessing `email` as a property, not a column.
ACTUAL: `Customer` model uses plain text columns.
---
