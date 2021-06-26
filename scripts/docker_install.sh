#!/usr/bin/env bash
# Author Philip De Lorenzo
# Copyright (C) 2020 The Unity Project, LLC.
# All rights reserved
#
source .env

# If not Linux, then exit
if [[ "${PYDIR}/bin/python -c \"import platform; print(platform.system())\"" != "Linux" ]]
then
    echo "This script must be run in a Linux environment only"
    exit 0
fi

if [[ "$(whoami)" != "root" ]]
then
    echo "Script must be run as root"
    exit 0
else
    yum install docker-engine -y
    service docker start
fi
