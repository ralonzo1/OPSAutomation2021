#!/usr/bin/env bash
# Author Philip De Lorenzo
# Copyright (C) 2021 Philip De Lorenzo.
# All rights reserved
#

export APP="/src"

project="OPSAutomation"

# Setting the relative base directory
export BASE="/root/${project}"
export QA="/qa"
export PYDIR=".python"
export PYTHON="${BASE}/${PYDIR}/bin"

/bin/bash -c "source /root/.bash_profile"

# Installing QA requirements
/bin/bash -c "${PYTHON}/pip install -r ${QA}/requirements.txt"

cd ${QA} || exit 1 && /bin/bash -c "${PYTHON}/python ${QA}/data/.data_init.py"
