# n8n — Workflow Automation Platform

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/deploy?template=n8n)

Deploy [n8n](https://n8n.io/) — the fair-code workflow automation platform — on Railway in minutes.

n8n is a powerful automation tool with 400+ native integrations and a visual editor for building workflows. Self-host it to keep full control over your data.

## Features

- **400+ integrations** — Slack, Gmail, GitHub, PostgreSQL, OpenAI, Shopify, and more
- **Visual workflow builder** — drag-and-drop node-based editor with 200+ components
- **Node.js/TypeScript support** — run custom code inline in any workflow step
- **Self-hosted fairness-first** — source-available license, deploy on your own infrastructure
- **Community template marketplace** — reuse workflows built by the community
- **Webhooks & REST API** — trigger and control workflows programmatically

## Architecture

```
                    ┌──────────────┐
                    │   Browser    │
                    └──────┬───────┘
                           │ HTTPS
                    ┌──────▼───────┐
                    │   Railway    │
                    │  Edge Proxy  │
                    └──────┬───────┘
                           │ HTTP :5678
                    ┌──────▼───────┐
                    │     n8n      │
                    │    (node)    │
                    │ :5678        │
                    ├──────────────┤
                    │ /home/node/  │
                    │ .local/share │
                    │   /n8n       │
                    └──────────────┘
```

## Quick Start

1. Click the Deploy button above on [Railway](https://railway.com)
2. Set `N8N_ENCRYPTION_KEY` (required — generated automatically if omitted, but set it explicitly to avoid losing credentials on redeploy)
3. n8n starts at `http://your-project.railway.app:5678`
4. Create your first admin account through the setup wizard

## Environment Variables

### Required

| Variable | Default | Description |
|---|---|---|
| `N8N_ENCRYPTION_KEY` | *(auto-generated)* | Encrypts credentials stored in workflows. **Set once and never change.** |

### Optional

| Variable | Default | Description |
|---|---|---|
| `GENERIC_TIMEZONE` | `""` (UTC) | Timezone for schedule-triggered nodes, e.g. `America/New_York` |
| `N8N_BASIC_AUTH_ACTIVE` | `false` | Enable HTTP basic auth on the n8n UI |
| `N8N_BASIC_AUTH_USER` | — | Basic auth username |
| `N8N_BASIC_AUTH_PASSWORD` | — | Basic auth password |

### Database (Optional)

By default n8n uses SQLite. For PostgreSQL:

| Variable | Default | Description |
|---|---|---|
| `DB_TYPE` | `""` (sqlite) | Set to `db:type=postgresdb` or use the full connection URIs below |
| `DB_POSTGRESDB_HOST` | — | Postgres hostname via Railway service binding |
| `DB_POSTGRESDB_PORT` | `5432` | Postgres port |
| `DB_POSTGRESDB_DATABASE` | — | Database name |
| `DB_POSTGRESDB_USER` | — | Postgres user |
| `DB_POSTGRESDB_PASSWORD` | — | Postgres password |

See [n8n docs](https://docs.n8n.io/hosting/scaling/) for the full environment variable reference.

## Local Development

```bash
# Clone and configure
git clone git@github.com:YOUR_ORG/railway-n8n.git
cd railway-n8n
cp .env.example .env

# Build
podman build -t railway-n8n .

# Run (mount bind for persistent storage)
mkdir -p ~/n8n-data
podman run -d --name n8n \
  -p 5678:5678 \
  -v ~/n8n-data:/home/node/.local/share/n8n \
  --env-file .env \
  railway-n8n

# Open http://localhost:5678
```

## Troubleshooting

- **Missing env var after deploy**: n8n requires `N8N_ENCRYPTION_KEY` on first run. If not set, an auto-generated key is used — but losing it means every encrypted credential becomes unreadable. Always set it explicitly.
- **Port mismatch**: n8n listens on port 5678 by default. Railway injects its own `PORT` variable but n8n ignores it; ensure the service binds to 5678 or match your PORT env var accordingly.
- **Health check failing during startup**: n8n can take up to 30 seconds for the first workflow load. The dockerfile includes a 45s start-period to handle this.
