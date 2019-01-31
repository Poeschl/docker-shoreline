FROM alpine:3.9 as build

WORKDIR /opt

RUN apk -Uuv add git ca-certificates make g++ libvncserver-dev sdl2-dev libc6-compat && \
    apk -Uuv add -X http://dl-cdn.alpinelinux.org/alpine/edge/testing numactl-dev

ENV COMMIT_SHA 'dcfc01a3612ebe98d48d6d5aeac1a6c76a027e88'
RUN git clone https://github.com/TobleMiner/shoreline.git -b master shoreline && \
    cd shoreline && \
    git checkout ${COMMIT_SHA} && \
    make


FROM alpine:3.9
MAINTAINER Poeschl@users.noreply.github.com

EXPOSE 1234 5900

RUN apk -Uuv add libvncserver sdl2 libc6-compat && \
    apk -Uuv add -X http://dl-cdn.alpinelinux.org/alpine/edge/testing numactl && \
    rm /var/cache/apk/*

ENTRYPOINT ["shoreline", "-f", "vnc,port=5900", "-b", "0.0.0.0", "-p", "1234"]

COPY --from=build /opt/shoreline/shoreline /usr/local/bin/shoreline
