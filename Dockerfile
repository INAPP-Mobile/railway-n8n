ARG N8N_VERSION=1.56.0

# Use docker format (not OCI) for HEALTHCHECK support — remove line above if switching to docker build
FROM n8nio/n8n:${N8N_VERSION}

EXPOSE 5678

ENV GENERIC_TIMEZONE=UTC

HEALTHCHECK --interval=30s --timeout=10s --start-period=45s --retries=5 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:5678/ || exit 1

CMD ["n8n", "start"]
