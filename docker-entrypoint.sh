#!/bin/sh
# Entrypoint wrapper: forwards Railway's PORT to n8n's N8N_PORT
# n8n v2 ignores the generic PORT env var — it only respects N8N_PORT
export N8N_PORT="${PORT:-5678}"

# Ensure the data directory is writable by UID 1000 (node user)
# The mounted volume may have wrong permissions on first deploy
if [ -d "/home/node/.n8n" ]; then
    chown -R 1000:1000 /home/node/.n8n 2>/dev/null || true
fi

exec /docker-entrypoint.sh "$@"
