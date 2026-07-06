#!/bin/sh
# Entrypoint wrapper: forwards Railway's PORT to n8n's N8N_PORT
# n8n v2 ignores the generic PORT env var — it only respects N8N_PORT
export N8N_PORT="${PORT:-5678}"
exec /docker-entrypoint.sh "$@"
