FROM alpine:3.15 as build

WORKDIR /opt

RUN apk add --no-cache \
  'git=2.34.6-r0' \
  'ca-certificates=20220614-r0' \
  'make=4.3-r0' \
  'g++=10.3.1_git20211027-r0' \
  'libvncserver-dev=0.9.13-r2' \
  'sdl2-dev=2.0.16-r4' \
  'libc6-compat=1.2.2-r7' \
  'freetype-dev=2.11.1-r2' \
  'numactl-dev=2.0.14-r0'

ENV COMMIT_SHA '05a2bbfb4559090727c51673e1fb47d20eac5672'
# hadolint ignore=DL3003
RUN git clone https://github.com/TobleMiner/shoreline.git -b master shoreline && \
  cd shoreline && \
  git checkout ${COMMIT_SHA} && \
  make


FROM alpine:3.15

EXPOSE 1234 1235 5900

RUN apk add --no-cache \
'libvncserver=0.9.13-r2' \
'sdl2=2.0.16-r4' \
'libc6-compat=1.2.2-r7' \
'freetype=2.11.1-r2'  \
'numactl=2.0.14-r0'

ENTRYPOINT ["shoreline", "-f", "vnc,port=5900", "-b", "0.0.0.0", "-p", "1234", "-t", "arial.ttf"]

COPY --from=build /opt/shoreline/shoreline /usr/local/bin/shoreline
COPY arial.ttf /
