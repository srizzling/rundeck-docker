#!/bin/bash

set -eu

export DOCKER_HOST=$RD_CONFIG_DOCKER_HOST
export DOCKER_TLS_VERIFY=0
if [[ $RD_CONFIG_DOCKER_TLS_VERIFY == "true" ]]
then
	DOCKER_TLS_VERIFY=1
fi
export DOCKER_CERT_PATH=$RD_CONFIG_DOCKER_CERT_PATH

echo "<project>"
docker images | cut -f1 -d" " | grep -v "REPOSITORY" while read images
do
        Created=$(docker inspect -f '{{.Created}}' $image)
        imageId=$(docker inspect -f '{{.Id}}' $image)

        hostname=$(docker inspect -f '{{.Config.Hostname}}' $image)
        username=$(docker inspect -f '{{.Config.User}}' $image)
        exposed_ports=$(docker inspect -f '{{.Config.ExposedPorts}}' $image)
        image=$(docker inspect -f '{{.Config.Image}}' $image)
        WorkingDir=$(docker inspect -f '{{.Config.WorkingDir}}' $image)
        name=$(docker inspect -f '{{.Name}}' $image)

        Running=$(docker inspect -f '{{.State.Running}}' $image)
        Paused=$(docker inspect -f '{{.State.Paused}}' $image)

        IPAddress=$(docker inspect -f '{{.NetworkSettings.IPAddress}}' $image)


cat <<EOF
<node  name='$image' description='$name' imageId='$imageId' username='$username' tags='image,$image' hostname='$hostname' >
<attribute name="ExposedPorts" value='$exposed_ports'/>
<attribute name="WorkingDir" value='$WorkingDir'/>
<attribute name="Running" value='$Running'/>
<attribute name="Paused" value='$Paused'/>
<attribute name="Name" value='$name'/>
<attribute name="Image" value='$image'/>
<attribute name="Created" value='$Created'/>
<attribute name="NetworkSettings:IPAddress" value='$IPAddress'/>
</node>
EOF
done

echo "</project>"