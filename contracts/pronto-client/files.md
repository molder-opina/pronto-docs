| Path | Producer | Consumer | Purpose |
|---|---|---|---|
| `pronto-static/src/static_content/assets/pronto/menu/home-published.json` | `pronto-scripts` publish pipeline | `pronto-client` Vue | Artefacto real publicado que el cliente consume vía static host |
| `pronto-static/src/static_content/assets/pronto/menu/home-published.json.revision` | `pronto-scripts` publish pipeline | CDN/cliente | Marcador de revisión para invalidación de cache |
