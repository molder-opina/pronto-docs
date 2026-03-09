## CSRF employees

- Flask-WTF global en la capa web/proxy.
- Mutaciones a `/<scope>/api/*` deben enviar `X-CSRFToken`.
- Los logins por scope permitidos son excepción controlada definida por guardrails.
- El proxy debe propagar `X-CSRFToken` hacia `pronto-api` cuando corresponda.
