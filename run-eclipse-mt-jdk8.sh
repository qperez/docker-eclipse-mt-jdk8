#!/bin/bash
CONFIG_DIR=${HOME}/eclipse-mt-jdk8-config
WORKSPACE_DIR=${HOME}/eclipse-mt-jdk8-workspace
TAG=${1:-latest}

##########################################################################
# Before run this script please run this command : $ xhost +local:docker #
##########################################################################

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
-e DISPLAY \
-v  "$CONFIG_DIR /opt/eclipse/configuration" \
-v  "$CONFIG_DIR /home/developer/.eclipse" \
-v  "${HOME}/.Xauthority:/home/developer/.Xauthority" \
-v  "$WORKSPACE_DIR:/home/developer/eclipse-workspace" \
--rm -it --net=host qperez/eclipse-mt-jdk8:${TAG}
