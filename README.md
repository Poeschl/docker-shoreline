# shoreline (Dockerized)

[![](https://img.shields.io/microbadger/layers/poeschl/shoreline.svg)](https://microbadger.com/images/poeschl/shoreline)
[![](https://img.shields.io/microbadger/image-size/poeschl/shoreline.svg)](https://microbadger.com/images/poeschl/shoreline)
[![](https://img.shields.io/docker/pulls/poeschl/shoreline.svg)](https://hub.docker.com/r/poeschl/shoreline)
[![](https://img.shields.io/badge/hadolint-passed-green)](https://github.com/hadolint/hadolint)
[![](https://img.shields.io/github/license/poeschl/docker-shoreline.svg?maxAge=3600)](https://github.com/poeschl/docker-shoreline/blob/master/LICENCE)

A docker container wih the [shoreline PixelFlut server](https://github.com/TobleMiner/shoreline) inside.

# Usage

Start it up with the default parameters:

`docker run -p 5900:5900 -p 1234:1234 -p 1235:1235 poeschl/shoreline`

and connect via a vnc client to `localhost` to get the pixelflut display.
All pixelflut clients needs to connect to your ip on port `1234`.

Following options are set on default a running container `-f vnc,port=5900 -b 0.0.0.0 -p 1234`. 
Additional parameters can be specified over the docker container commands like:

`docker run -p 5900:5900 -p 1234:1234 poeschl/shoreline -w 1920 -h 1080`

To use the build-in statistics (available on port `1235`):

`docker run -p 5900:5900 -p 1234:1234 -p 1235:1235 poeschl/shoreline -f statistics`

# Licence

The included shoreline application is under [MIT Licence](https://raw.githubusercontent.com/TobleMiner/shoreline/master/LICENSE)
