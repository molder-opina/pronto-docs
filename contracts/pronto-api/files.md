| Path | Producer | Consumer | Purpose |
|---|---|---|---|
| `pronto-static/src/static_content/assets/pronto/menu/home-published.json` | `pronto-scripts/bin/python/generate_menu_home_artifact.py` | `pronto-client` | Snapshot estático publicado para homepage cliente |
| `pronto-static/src/static_content/assets/pronto/menu/home-published.json.revision` | `pronto-scripts/bin/python/generate_menu_home_artifact.py` | Ops/CDN | Invalidación de cache por `snapshot_revision` |
| `pronto-logs/api/*.log` | `pronto-api` | Observabilidad | Logs estructurados con `X-Correlation-ID` |
