#!/usr/bin/env bash

APP="ops"
MAIN="webware"
ENV=${1}

if [ -z $1 ]; then
    echo "ERROR: Please pass the environment name to the script."
else
    docker build -t ${ENV}/${MAIN}-${APP} .
fi
