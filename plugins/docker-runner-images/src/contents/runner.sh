#!/bin/bash


set -eu

export DOCKER_HOST=$RD_CONFIG_DOCKER_HOST
export DOCKER_TLS_VERIFY=0
if [[ $RD_CONFIG_DOCKER_TLS_VERIFY == "true" ]]
then
        DOCKER_TLS_VERIFY=1
fi
export DOCKER_CERT_PATH=$RD_CONFIG_DOCKER_CERT_PATH


image="$1"
shift

set -- $@
docker run --name=test "${image}" $@
