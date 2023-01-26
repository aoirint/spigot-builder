#!/bin/bash

docker buildx build -t "spigot-builder" .
docker run --rm -it -v "$PWD/work:/work" "spigot-builder" $@
