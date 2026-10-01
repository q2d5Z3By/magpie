FROM ghcr.io/yetone/magpie:latest AS magpie

FROM gcr.io/distroless/base-debian12:nonroot

COPY --from=magpie /magpie /magpie
COPY --from=magpie --chown=65532:65532 /config /config

ENV XDG_CONFIG_HOME=/config \
    XDG_CACHE_HOME=/config/cache \
    MAGPIE_ADDR=0.0.0.0:3425

VOLUME /config

EXPOSE 3425 3430

ENTRYPOINT ["/magpie"]
CMD ["web", "--addr", "0.0.0.0:3430", "--no-open"]
