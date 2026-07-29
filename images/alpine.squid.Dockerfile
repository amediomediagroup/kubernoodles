FROM alpine:3.19
RUN apk add --no-cache squid
RUN echo 'http_port 3128' > /etc/squid/squid.conf && \
    echo 'http_access allow all' >> /etc/squid/squid.conf && \
    echo 'cache_mem 16 MB' >> /etc/squid/squid.conf && \
    echo 'maximum_object_size_in_memory 8 KB' >> /etc/squid/squid.conf
EXPOSE 3128
CMD ["squid", "-f", "/etc/squid/squid.conf", "-N"]
