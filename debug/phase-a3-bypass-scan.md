# Phase A.3 bypass scan

Generated: 2026-03-18 19:17:29 UTC

## Productive code scope
Command: `rg -n "mark_order_paid" pronto-libs/src pronto-api/src pronto-client/src pronto-employees/src pronto-static/src pronto-scripts`
0 matches

Command: `rg -n "order\\.mark_status\\(OrderStatus\\.PAID" pronto-libs/src pronto-api/src pronto-client/src pronto-employees/src pronto-static/src pronto-scripts`
0 matches

## Full repository scope (including docs/history)
Command: `rg -n "mark_order_paid" .`
./pronto-docs/audits/AUDIT-20260318-inconsistencies.md:174:mark_order_paid()  # Escritura directa sin pasar por state machine
./pronto-docs/audits/AUDIT-20260318-inconsistencies.md:177:confirm_partial_payment() llama mark_order_paid()
./pronto-docs/audits/AUDIT-20260318-inconsistencies.md:245:4. Corregir `mark_order_paid()` para pasar por state machine
./pronto-docs/audits/AUDIT-20260318-inconsistencies.md:295:2. **Bypass state machine** (`mark_order_paid()`) - integridad de negocio
./openclaw-features/audits/audit_audit PRONTO 16:07_20260228_160727_analysis.md:277:- Only `mark_order_paid` is imported from `order_state_machine` (payments.py:24)
./pronto-docs/versioning/AI_VERSION_LOG.md:459:... smoke import (`OrderStateMachine`, `mark_order_paid`) ...
./pronto-docs/errors/20260315_pronto_states_audit.md:65:   - Funciones canónicas: mark_order_paid, mark_order_unpaid, mark_order_awaiting_tip, mark_order_cancelled
./pronto-libs/tests/order/test_payment_domain.py:217:    assert "def mark_order_paid(" not in source
