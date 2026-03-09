## Contratos resumidos por dominio para `pronto-api`

| Dominio | Auth principal | CSRF | Cookies / contexto | Headers clave |
|---|---|---|---|---|
| `Auth` | JWT employees / sesión cliente | aplica en mutaciones browser; login scopes con excepción controlada | cookies namespaced employees o sesión SSR | `Content-Type`, `X-CSRFToken` |
| `Menu` | público o employee según ruta | sí en mutaciones operativas | contexto browser si pasa por BFF/proxy | `X-Correlation-ID`, `Authorization` |
| `Orders` | cliente autenticado o employee | sí en mutaciones browser | sesión cliente + scope employee | `X-CSRFToken`, `X-PRONTO-CUSTOMER-REF`, `Authorization` |
| `Sessions` | contexto cliente / employee | sí salvo `/api/sessions/open` | contexto de mesa y sesión activa | `X-CSRFToken`, `X-PRONTO-CUSTOMER-REF` |
| `Payments` | cliente o employee autorizado | sí en browser | depende de sesión activa | `X-CSRFToken`, `X-PRONTO-CUSTOMER-REF` |
| `Invoices` | cliente o admin | sí en mutaciones | depende de sesión/pago elegible | `X-CSRFToken`, `X-PRONTO-CUSTOMER-REF`, `X-Correlation-ID` |
| `Reports` | employee/admin | no suele aplicar en lectura pura | proxy scope-aware opcional | `Authorization`, `X-Correlation-ID` |
| `Admin / RBAC` | admin/system | sí | proxy admin/system o JWT | `Authorization`, `X-CSRFToken`, `X-Correlation-ID` |
| `Tables / Areas` | employee | sí en mutaciones | contexto operativo de piso | `Authorization`, `X-CSRFToken` |
| `Notifications / Realtime` | employee | sí en confirmaciones/mutaciones | contexto de consola | `Authorization`, `X-Correlation-ID` |
| `Branding / Config` | employee/admin | sí en mutaciones | contexto administrativo | `Authorization`, `X-CSRFToken` |