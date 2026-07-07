# n8n — Workflow Automation Platform

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.com/deploy/railway-n8n)

Deploy [n8n](https://n8n.io/) — the fair-code workflow automation platform — on Railway with automatic volume persistence.

n8n is a powerful automation tool with 400+ native integrations and a visual editor for building workflows. Self-host it to keep full control over your data.

## Features

- **400+ integrations** — Slack, Gmail, GitHub, PostgreSQL, OpenAI, Shopify, and more
- **Visual workflow builder** — drag-and-drop node-based editor with 200+ components
- **Self-hosted** — source-available license, deploy on your own infrastructure
- **Webhooks & REST API** — trigger and control workflows programmatically

## Quick Start

1. Click the Deploy button above
2. Set `N8N_ENCRYPTION_KEY` (or use auto-generated one — but set it explicitly to avoid losing credentials on redeploy)
3. n8n starts at `http://your-project.railway.app`
4. Create your first admin account through the setup wizard

## Environment Variables

### Required

| Variable | Default | Description |
|---|---|---|
| `N8N_ENCRYPTION_KEY` | *(auto-generated)* | Encrypts credentials. **Set once and never change.** |

### Optional

| Variable | Default | Description |
|---|---|---|
| `N8N_PORT` | `5678` | Port n8n listens on |
| `GENERIC_TIMEZONE` | `UTC` | Timezone for schedule-triggered nodes |
| `N8N_BASIC_AUTH_ACTIVE` | `false` | Enable HTTP basic auth on the UI |

### PostgreSQL (optional)

By default n8n uses SQLite with a persistent volume. For production, add PostgreSQL:

| Variable | Default | Description |
|---|---|---|
| `DB_TYPE` | `sqlite` | Set to `postgresdb` |
| `DB_POSTGRESDB_HOST` | — | Postgres hostname |
| `DB_POSTGRESDB_PORT` | `5432` | Postgres port |
| `DB_POSTGRESDB_DATABASE` | — | Database name |
| `DB_POSTGRESDB_USER` | — | Postgres user |
| `DB_POSTGRESDB_PASSWORD` | — | Postgres password |

## Deployment Details

| Setting | Value |
|---|---|
| Base Image | `n8nio/n8n:2.28.7` |
| Port | `5678` (HTTP) |
| Health Check Path | `/` |
| Restart Policy | On Failure (max 5 retries) |
| Startup Timeout | 300 seconds |
| Volume Mount | `/home/node/.n8n` |
| Required Env Var | `N8N_ENCRYPTION_KEY` |

## Volumes

This template provisions a persistent volume at `/home/node/.n8n` to store workflows, credentials, and the SQLite database. Data persists across redeployments.

## Local Development

```bash
git clone git@github.com:INAPP-Mobile/railway-n8n.git
cd railway-n8n
cp .env.example .env
docker build -t railway-n8n .
docker run -d --name n8n -p 5678:5678 -v ~/n8n-data:/home/node/.n8n --env-file .env railway-n8n
```

Open http://localhost:5678.
