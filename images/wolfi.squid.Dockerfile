FROM cgr.dev/chainguard/wolfi-base:latest
RUN apk add --no-cache squid
RUN adduser -D -S -H squid 2>/dev/null || true && \
    mkdir -p /etc/squid /var/cache/squid /var/log/squid && \
    chown -R squid:squid /var/cache/squid /var/log/squid 2>/dev/null || true && \
    echo 'http_port 3128' > /etc/squid/squid.conf && \
    echo 'http_access allow all' >> /etc/squid/squid.conf && \
    echo 'cache_mem 16 MB' >> /etc/squid/squid.conf && \
    echo 'maximum_object_size_in_memory 8 KB' >> /etc/squid/squid.conf && \
    echo 'cache_effective_user root' >> /etc/squid/squid.conf
EXPOSE 3128
CMD ["squid", "-f", "/etc/squid/squid.conf", "-N"]
