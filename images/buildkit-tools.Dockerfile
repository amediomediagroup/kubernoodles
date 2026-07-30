FROM moby/buildkit:rootless

USER root

RUN apk add --no-cache curl tar gzip

ARG TARGETARCH
# go-containerregistry uses x86_64, not amd64
RUN ARCH_OVERRIDE="$$([ \"$TARGETARCH\" = amd64 ] && echo x86_64 || echo $TARGETARCH)" && \
  BINDIR=/usr/local/bin && \
  curl -fsSL "https://github.com/google/go-containerregistry/releases/latest/download/go-containerregistry_Linux_${ARCH_OVERRIDE}.tar.gz" | tar -xz -C $BINDIR crane && \
  curl -fsSL "https://github.com/anchore/grype/releases/download/v0.86.0/grype_0.86.0_linux_${TARGETARCH}.tar.gz" | tar -xz -C $BINDIR grype && \
  curl -fsSL "https://github.com/anchore/syft/releases/download/v1.19.0/syft_1.19.0_linux_${TARGETARCH}.tar.gz" | tar -xz -C $BINDIR syft && \
  curl -fsSLo "$BINDIR/cosign" "https://github.com/sigstore/cosign/releases/download/v2.4.3/cosign-linux-${TARGETARCH}" && \
  chmod +x $BINDIR/*

USER user
