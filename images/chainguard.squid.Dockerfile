FROM cgr.dev/chainguard/squid-proxy:latest
COPY images/squid.conf /etc/squid.conf
EXPOSE 3128
CMD ["squid", "-f", "/etc/squid.conf", "-N"]
