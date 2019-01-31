FROM debian:9.6-slim as build

WORKDIR /opt

RUN apt-get update && \
    apt-get install --no-install-recommends -y git ca-certificates make g++ libvncserver-dev libnuma-dev libsdl2-dev libc6-dev

ENV COMMIT_SHA 'dcfc01a3612ebe98d48d6d5aeac1a6c76a027e88'
RUN git clone https://github.com/TobleMiner/shoreline.git -b master shoreline && \
    cd shoreline && \
    git checkout ${COMMIT_SHA} && \
    make


FROM debian:9.6-slim
MAINTAINER Poeschl@users.noreply.github.com

EXPOSE 1234
EXPOSE 5900

RUN apt-get update && \
    apt-get install --no-install-recommends -y libvncserver1 libnuma1 libsdl2-2.0-0 libc6 xfonts-terminus && \
    apt-get clean && apt-get autoremove && rm -Rf /var/lib/apt/lists/*

ENTRYPOINT ["shoreline", "-f", "vnc,port=5900", "-b", "0.0.0.0", "-p", "1234"]

COPY --from=build /opt/shoreline/shoreline /usr/local/bin/shoreline
