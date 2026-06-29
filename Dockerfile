# Pinned image version — update when major/minor version changes
ARG N8N_VERSION=1.56.0

# Official n8n Docker image already has:
#   - docker-entrypoint.sh (via tini) for graceful shutdown/restart
#   - Port 5678 exposed
#   - Node.js + YAML support built in
# This template only adds configurable environment defaults and a health check.
FROM n8nio/n8n:${N8N_VERSION}

ENV GENERIC_TIMEZONE=UTC
ENV NODE_ENV=production
ENV N8N_BASIC_AUTH_ACTIVE=false

HEALTHCHECK --interval=30s --timeout=10s --start-period=45s --retries=5 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:5678/ || exit 1