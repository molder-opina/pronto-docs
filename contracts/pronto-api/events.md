| Event | Producer | Consumers | Payload Schema | Version |
|---|---|---|---|---|
| `orders.changed` | `pronto-api` | `pronto-client` | JSON (order tracker) | v1 |
| `menu_home_draft_saved` | `pronto-api` | Audit/Logs | `placement,module_id,draft_version,published_version` | v1 |
| `menu_home_reordered` | `pronto-api` | Audit/Logs | `placement,draft_version,published_version` | v1 |
| `menu_home_publish_requested` | `pronto-api` | Audit/Logs | `placement,draft_version,published_version` | v1 |
| `menu_home_publish_started` | `pronto-api` | Audit/Logs | `placement,draft_version` | v1 |
| `menu_home_publish_succeeded` | `pronto-api` | Audit/Logs | `placement,published_version,snapshot_revision` | v1 |
| `menu_home_publish_failed` | `pronto-api` | Audit/Logs | `placement,error,published_version` | v1 |
| `menu_home_publish_rollback_executed` | `pronto-api` | Audit/Logs | `placement,published_version` | v1 |
