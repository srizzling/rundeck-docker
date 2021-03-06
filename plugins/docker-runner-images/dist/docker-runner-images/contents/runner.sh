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
docker-compose -f /var/lib/rundeck/docker-nodes/docker-compose.yml run --rm --name="${RD_JOB_PROJECT}-${RD_JOB_NAME}-${RD_JOB_ID}" "${image}" $@

