FROM alpine:3.11 as build

WORKDIR /opt

RUN apk add --no-cache \
  'git=2.24.1-r0' \
  'ca-certificates=20191127-r0' \
  'make=4.2.1-r2' \
  'g++=9.2.0-r3' \
  'libvncserver-dev=0.9.12-r1' \
  'sdl2-dev=2.0.10-r0' \
  'libc6-compat=1.1.24-r0' \
  'freetype-dev=2.10.1-r0' \
  'numactl-dev=2.0.13-r0'

ENV COMMIT_SHA 'bd33837dcf0a2d1fe9412ec4119b0af4088bdbaa'
RUN git clone https://github.com/TobleMiner/shoreline.git -b master shoreline && \
  cd shoreline && \
  git checkout ${COMMIT_SHA} && \
  make


FROM alpine:3.11

EXPOSE 1234 1235 5900

RUN apk add --no-cache \
'libvncserver=0.9.12-r1' \
'sdl2=2.0.10-r0' \
'libc6-compat=1.1.24-r0' \
'freetype=2.10.1-r0'  \
'numactl=2.0.13-r0'

ENTRYPOINT ["shoreline", "-f", "vnc,port=5900", "-b", "0.0.0.0", "-p", "1234"]

COPY --from=build /opt/shoreline/shoreline /usr/local/bin/shoreline
