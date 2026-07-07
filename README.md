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

By default n8n uses SQLite on a persistent volume. For production workloads,
add a PostgreSQL service binding:

```
┌─────────────────────────────────────┐
│          Railway Edge               │
│     (TLS termination, routing)      │
└────────────┬────────────────────────┘
             │                         
┌────────────▼────────────────────────┐
│     n8n Container (port 5678)       │
│  Workflow engine, webhooks, REST    │
│  400+ integrations, visual editor   │
└────────────┬────────────────────────┘
             │                         
┌────────────▼────────────────────────┐
│  Data Layer                         │
│                                     │
│  SQLite (default on volume):        │
│  └─ /home/node/.n8n/                │
│     ├─ workflows & credentials      │
│     └─ config & cache               │
│                                     │
│  PostgreSQL (optional):             │
│  └─ Add Railway service binding     │
│     └─ Production workloads         │
└─────────────────────────────────────┘
```

To connect n8n to PostgreSQL, set these environment variables:

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

## Deploy and Host

Click the Deploy button above to deploy on Railway with automatic HTTPS, scaling, and a persistent volume. No configuration required — n8n starts with a managed SQLite database and auto-generated encryption key.

### Hosting Options

- **Railway (recommended)**: One-click deploy, automatic HTTPS, persistent volume, and scaling
- **Docker/Podman**: Self-host on your own server with Docker Compose
- **Kubernetes**: Deploy using the official Docker image (`n8nio/n8n:2.28.7`)

## About Hosting

The n8n Docker image runs on port 5678. The volume at `/home/node/.n8n` persists workflows, credentials, and the SQLite database across deployments.

Key considerations:
- **Encryption key**: `N8N_ENCRYPTION_KEY` encrypts stored credentials. Set once and never change it.
- **Port**: Use `N8N_PORT` to configure the listen port.
- **Scaling**: For production workloads, add a PostgreSQL database via service bindings.

## Why Deploy

n8n is the most popular self-hosted workflow automation platform with 61K+ GitHub stars. Self-hosting gives you full privacy, unlimited integrations, no per-workflow fees, and compliance control.

## Common Use Cases

- **Communication** — Slack notifications, email digests, Teams alerts
- **CRM & Sales** — Lead capture, Salesforce sync, customer segmentation
- **Data Pipeline** — CSV/JSON transforms, API aggregation, ETL jobs
- **AI & LLMs** — OpenAI chat completions, document processing, AI agents
- **DevOps** — CI/CD notifications, log monitoring, infrastructure alerts
- **Marketing** — Email campaigns, social media posting, lead scoring

## Dependencies for Running This Template

| Dependency | Type | Required | Notes |
|---|---|---|---|
| Storage volume | Auto-provisioned | Yes | Persists SQLite data, workflows, and credentials across deployments |
| `N8N_ENCRYPTION_KEY` | Env var | Recommended | Set once and never change — lost on redeploy if auto-generated |
| PostgreSQL (optional) | Service binding | No | Add via Railway for production workloads instead of SQLite |

### Deployment Dependencies

No additional infrastructure needed — the volume auto-provisions on first deploy. For production, add a PostgreSQL service binding.
