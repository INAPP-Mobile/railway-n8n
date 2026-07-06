# n8n version: 2.28.7 — bump when updating
# Official n8n Docker image already has:
#   - docker-entrypoint.sh (via tini) for graceful shutdown/restart
#   - Port 5678 exposed
#   - Node.js + YAML support built in
# This template only adds configurable environment defaults and a health check.
FROM n8nio/n8n:2.28.7

# Entrypoint wrapper: forwards Railway's PORT to n8n's N8N_PORT
USER root
COPY docker-entrypoint.sh /usr/local/bin/railway-entrypoint.sh
RUN chmod +x /usr/local/bin/railway-entrypoint.sh
USER 1000

ENV GENERIC_TIMEZONE=UTC
ENV NODE_ENV=production
ENV N8N_BASIC_AUTH_ACTIVE=false
ENV N8N_BASIC_AUTH_USER=***
ENV N8N_BASIC_AUTH_PASSWORD=***

HEALTHCHECK --interval=30s --timeout=10s --start-period=45s --retries=5 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:${PORT:-5678}/ || exit 1

ENTRYPOINT ["/usr/local/bin/railway-entrypoint.sh"]