ARG BUILD_VERSION
ARG BUILD_ARCH

FROM ghcr.io/openai/tunnel-client:v0.0.12

ARG BUILD_VERSION
ARG BUILD_ARCH

RUN apk add --no-cache jq ca-certificates

COPY run.sh /run.sh
RUN chmod 0755 /run.sh

LABEL \
  io.hass.version="${BUILD_VERSION}" \
  io.hass.type="app" \
  io.hass.arch="${BUILD_ARCH}"

ENTRYPOINT ["/run.sh"]
