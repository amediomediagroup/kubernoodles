FROM moby/buildkit:rootless

USER root

RUN apk add --no-cache curl tar gzip

RUN ARCH=x86_64 && \
    BINDIR=/usr/local/bin && \
    curl -fsSL "https://github.com/google/go-containerregistry/releases/latest/download/go-containerregistry_Linux_${ARCH}.tar.gz" | tar -xz -C $BINDIR crane && \
    curl -fsSL "https://github.com/anchore/grype/releases/download/v0.86.0/grype_0.86.0_linux_amd64.tar.gz" | tar -xz -C $BINDIR grype && \
    curl -fsSL "https://github.com/anchore/syft/releases/download/v1.19.0/syft_1.19.0_linux_amd64.tar.gz" | tar -xz -C $BINDIR syft && \
    curl -fsSLo "$BINDIR/cosign" "https://github.com/sigstore/cosign/releases/download/v2.4.3/cosign-linux-amd64" && \
    chmod +x $BINDIR/*

USER user
