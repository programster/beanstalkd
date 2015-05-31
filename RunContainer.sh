#!/bin/bash

# ensure running bash
if ! [ -n "$BASH_VERSION" ];then
    echo "this is not bash, calling self with bash....";
    SCRIPT=$(readlink -f "$0")
    /bin/bash $SCRIPT
    exit;
fi

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT") 
cd $SCRIPTPATH

# load the variables
source Settings.sh

if [ -z "$REGISTRY" ]; then
    TAG="`echo $PROJECT_NAME`"
else 
    TAG="`echo $REGISTRY`/`echo $PROJECT_NAME`"
fi

CONTAINER_NAME="`echo $PROJECT_NAME`_container"
docker kill $CONTAINER_NAME
docker rm $CONTAINER_NAME

docker run -d \
-v $SCRIPTPATH/data:/data \
-p $PORT:11300 \
--name="$CONTAINER_NAME" \
$TAG

