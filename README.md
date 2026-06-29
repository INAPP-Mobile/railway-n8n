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

## Deploy and Host

Click the "Deploy on Railway" button above to spin up your own n8n instance in minutes. No configuration required — n8n will start automatically with a managed SQLite database and auto-generated encryption key.

### Hosting Options

- **Railway (recommended)**: One-click deploy, automatic HTTPS, scaling, and managed infrastructure. Follow the Quick Start for step-by-step instructions.
- **Docker/Podman**: Self-host on your own server or VPS with Docker Compose or podman. See Local Development for setup instructions.
- **Kubernetes**: Deploy n8n as a container in any Kubernetes cluster using the official Docker image (`n8nio/n8n:1.56.0`).

### Deployment Details

| Setting | Value |
|---|---|
| Base Image | `n8nio/n8n:1.56.0` |
| Port | `5678` (HTTP) |
| Health Check Path | `/` |
| Restart Policy | On Failure (max 5 retries) |
| Startup Timeout | 180 seconds |
| Required Env Var | `N8N_ENCRYPTION_KEY` |

## About Hosting

The n8n Docker image runs a Node.js application that listens on port `5678`. The persistent storage path is `/home/node/.local/share/n8n`, which stores workflows, credentials, and the SQLite database. On Railway, volumes persist across deployments unless explicitly removed — your data stays safe through redeployments and environment changes.

Key considerations:
- **Encryption key**: `N8N_ENCRYPTION_KEY` encrypts all stored credentials in your workflows. Set this once on first deploy and never change it — losing it means every encrypted credential becomes unreadable.
- **Port configuration**: Railway may inject a different `PORT` variable; always explicitly configure n8n to listen on port `5678` via the `N8N_PORT` environment variable or Docker build config.
- **Scaling**: For production workloads beyond single-instance capacity, connect a PostgreSQL database via `DB_TYPE=postgresdb` and use service bindings for secure database access.

## Why Deploy

n8n is the most popular self-hosted workflow automation platform with over 61K GitHub stars. Self-hosting gives you:

- **Full privacy and data control**: All workflows, credentials, and data stay on your infrastructure.
- **Unlimited integrations**: Use all 400+ native nodes without vendor restrictions or pricing tiers.
- **Cost efficiency**: No per-workflow fees — unlimited workflows for the cost of hosting alone.
- **Customizability**: Extend with custom Node.js/TypeScript code, self-hosted marketplaces, and custom integrations.
- **Compliance**: Meet GDPR, HIPAA, and SOC requirements by controlling where your automation data lives.

## Common Use Cases

n8n supports automation across many domains:

| Category | Example Workflows |
|---|---|
| **Communication** | Slack notifications, email digests, Teams alerts, SMS reminders |
| **CRM & Sales** | Lead capture, Salesforce/HubSpot sync, customer segmentation |
| **Data Pipeline** | CSV/JSON transforms, API aggregation, ETL jobs |
| **AI & LLMs** | OpenAI chat completions, document processing, AI agent orchestration |
| **DevOps** | CI/CD notifications, log monitoring, infrastructure alerts |
| **Marketing** | Email campaign automation, social media posting, lead scoring |

## Dependencies for

### Database (Optional)

By default n8n uses SQLite. For PostgreSQL:

|| Variable | Default | Description |
||---|---|---|
|| `DB_TYPE` | `""` (sqlite) | Set to `db:type=postgresdb` or use the full connection URIs below |
|| `DB_POSTGRESDB_HOST` | — | Postgres hostname via Railway service binding |
|| `DB_POSTGRESDB_PORT` | `5432` | Postgres port |
|| `DB_POSTGRESDB_DATABASE` | — | Database name |
|| `DB_POSTGRESDB_USER` | — | Postgres user |
|| `DB_POSTGRESDB_PASSWORD` | — | Postgres password |

### Deployment Dependencies

This template requires:
- **Railway account** with billing enabled for Docker container hosting
- **One environment variable**: `N8N_ENCRYPTION_KEY` (recommended but not required — auto-generated if omitted)
- **Optional**: PostgreSQL service binding for production-scale data storage and backup

| Dependency | Type | Required | Note |
|---|---|---|---|
| Storage volume | Auto-provisioned | Yes | Persisted across deployments |
| `N8N_ENCRYPTION_KEY` | Env var | Recommended | Lost on redeploy if auto-generated |
| PostgreSQL (optional) | Service binding | No | Add via the "Add" menu for production workloads |

- **Missing env var after deploy**: n8n requires `N8N_ENCRYPTION_KEY` on first run. If not set, an auto-generated key is used — but losing it means every encrypted credential becomes unreadable. Always set it explicitly.
- **Port mismatch**: n8n listens on port 5678 by default. Railway injects its own `PORT` variable but n8n ignores it; ensure the service binds to 5678 or match your PORT env var accordingly.
- **Health check failing during startup**: n8n can take up to 30 seconds for the first workflow load. The dockerfile includes a 45s start-period to handle this.
