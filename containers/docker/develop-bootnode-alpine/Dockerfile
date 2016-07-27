# Docker container spec for building the swarm branch of go-ethereum.
#
# The build process it potentially longer running but every effort was made to
# produce a very minimalistic container that can be reused many times without
# needing to constantly rebuild.
FROM alpine:3.3

# Build go-ethereum on the fly and delete all build tools afterwards
RUN \
  apk add --update go git make gcc musl-dev                                     && \
  git clone https://github.com/arachnid/go-ethereum                             && \
  (cd go-ethereum && git checkout discover-enode)                               && \
  (cd go-ethereum && build/env.sh go run build/ci.go install ./cmd/bootnode)    && \
  cp go-ethereum/build/bin/bootnode /bootnode                                   && \
  apk del go git make gcc musl-dev                                              && \
  rm -rf /go-ethereum && rm -rf /var/cache/apk/*

# Make sure bash and jq is available for easier wrapper implementation
RUN apk add --update bash jq

# Export the usual networking ports to allow outside access to the node
EXPOSE 30301/udp

ADD index.html /www/index.html

# Inject the startup script
ADD bootnode.sh /bootnode.sh
RUN chmod +x /bootnode.sh

ENTRYPOINT ["/bootnode.sh"]
