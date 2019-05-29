FROM alpine:3.3
MAINTAINER Monetaryunit <support@monetaryunit.org>

RUN mkdir -p /app/bin /app/src /var/lib/monetaryunit-seeder

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

WORKDIR /var/lib/monetaryunit-seeder
VOLUME /var/lib/monetaryunit-seeder

EXPOSE 53/udp

ENTRYPOINT ["/app/bin/dnsseed"]