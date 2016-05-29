#!/bin/bash
# set -e
set -x

echo "docker pull"
docker pull shuttleofx/shuttleofx:latest
docker stop shuttleofx_cnt
docker rm -f shuttleofx_cnt

# remove exited containers:
docker ps --filter status=dead --filter status=exited -aq | xargs -r docker rm -v
# remove unused images:
docker images --no-trunc | grep '<none>' | awk '{ print $3 }' | xargs -r docker rmi


cd /opt/shuttleofx_git
git pull

./run_docker_server.sh


