#!/usr/bin/env bash

# Author Philip De Lorenzo
# Copyright (C) 2020 The Unity Project, LLC.
# All rights reserved
#
#
set -eou pipefail

# Set the directory of this script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
PYVER=$(python --version | awk '{print $2}')
PYVER_MAIN=$(echo ${PYVER} | awk -F . '{print $1}')
PYVER_MINOR=$(echo ${PYVER} | awk -F . '{print $2}')
PYVER_PATCH=$(echo ${PYVER} | awk -F . '{print $3}')


if [[ ${PYVER_MAIN} -ne 3 ]]; then echo "Python version must be 3.7.x, preferrably Python 3.7.9+."; exit 1; fi
if [[ ${PYVER_MINOR} -lt 7 ]]; then echo "Python version must be 3.7.5+, preferrably Python 3.7.9+."; exit 1; fi
if [[ ${PYVER_MINOR} -eq 7 ]] && [[ ${PYVER_PATCH} -lt 5 ]]; then
    echo "Python version must be 3.7.5+, preferrably Python 3.7.9+."
    exit 1
fi

# Installing pip
pip install --upgrade pip
#pip install pip==20.0.1
pip install -r ${DIR}/../requirements.txt

echo "System Python Environment ${PYVER} -- [OK]"

exit 0
