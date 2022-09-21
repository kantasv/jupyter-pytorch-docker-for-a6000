#!/bin/bash
# Stops docker container (clean up)
set -ue
conf_compiled="docker-compose.compiled.yaml"
docker-compose -f $conf_compiled down