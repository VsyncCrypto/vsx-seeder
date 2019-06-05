FROM alpine:3.3
MAINTAINER VSync <support@vsync.io>

RUN mkdir -p /app/bin /app/src /var/lib/vsync-seeder

WORKDIR /app/src

ADD . /app/src

RUN apk --no-cache add --virtual build_deps    \
      boost-dev                                \
      gcc                                      \
      git                                      \
      g++                                      \
      libc-dev                                 \
      make                                     \
      openssl-dev                           && \

    make                                    && \
    mv /app/src/dnsseed /app/bin/dnsseed    && \
    rm -rf /app/src                         && \

    apk --purge del build_deps

RUN apk --no-cache add    \
      libgcc              \
      libstdc++

WORKDIR /var/lib/vsync-seeder
VOLUME /var/lib/vsync-seeder

EXPOSE 53/udp

ENTRYPOINT ["/app/bin/dnsseed"]
