#!/bin/bash

# Call this script to build your beanstalkd container.

# ensure running bash
if ! [ -n "$BASH_VERSION" ];then
    echo "this is not bash, calling self with bash....";
    SCRIPT=$(readlink -f "$0")
    /bin/bash $SCRIPT
    exit;
fi

# Get the path to script just in case executed from elsewhere.
SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd $SCRIPTPATH

# Load the variables from settings file.
source Settings.sh

if [ -z "$REGISTRY" ]; then
    TAG=$PROJECT_NAME
else
    TAG=$REGISTRY/$PROJECT_NAME
fi

# Ask the user if they want to use the docker cache
read -p "Do you want to use a cached build (y/n)? " -n 1 -r
echo ""   # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]; then
    docker build --tag="$TAG" .
else
    docker build --no-cache --tag="$TAG" .
fi


# If the user has defind the registry, then ask them if they
# wish to push their newly build container to it.
if [ -z "$REGISTRY" ]; then
    # Registry is not defined, do nothing...
    echo "No registry defined, skipping possible push step..."
else 
    read -p "Do you wish to push the container to your registry (y/n)? " -n 1 -r
    echo ""   # (optional) move to a new line
    
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        docker push $TAG
    fi
fi


echo "Run the container with either of the following command:"
echo "bash RunContainer.sh"
