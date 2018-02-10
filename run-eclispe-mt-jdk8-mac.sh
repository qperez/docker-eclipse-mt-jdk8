#!/bin/bash
CONFIG_DIR=${HOME}/eclipse-mt-jdk8-config
WORKSPACE_DIR=${HOME}/eclipse-mt-jdk8-workspace
TAG=${1:-latest}
IP_XSERVER=${2}

##########################################################################
# Before run this script please install XQuartz, see more :
# https://cntnr.io/running-guis-with-docker-on-mac-os-x-a14df6a76efc
##########################################################################

if [ -z "$2" ]
  then
    echo "You must specified the IP of the XQuartz server"
    echo "USAGE: ./run-eclipse-mt-jdk8-ma.sh [tag_name] <IP_XQUARTZ> "
    exit 1
fi

if [ ! -d $CONFIG_DIR ]; then
  echo "Eclipse directory for persistent configuration not present, creation..."
  mkdir -m 777 $CONFIG_DIR
  echo "OK : directory created, path = $CONFIG_DIR"
fi

if [ ! -d $WORKSPACE_DIR ]; then
  echo "Eclipse workspace for persistent data not present, creation..."
  mkdir -m 777 $WORKSPACE_DIR
  echo "OK : directory created, path = $WORKSPACE_DIR"
fi

docker run \
-e DISPLAY=${IP_XSERVER} \
-v  "$CONFIG_DIR /opt/eclipse/configuration" \
-v  "$CONFIG_DIR /home/developer/.eclipse" \
-v  "$WORKSPACE_DIR:/home/developer/eclipse-workspace" \
--rm -it --privileged --net=host qperez/eclipse-mt-jdk8:${TAG}
