#!/usr/bin/env bash
# Author Philip De Lorenzo
# Copyright (C) 2021 Philip De Lorenzo.
# All rights reserved
#
project="OPSAutomation"
projdir="OPSAutomation"
projTitle="${project^^} ${projdir}"

export APP="/src"
# Setting the relative base directory
export BASE="/root/${project}"
export PYDIR=".python"
export PYTHON="${BASE}/${PYDIR}/bin"
export MANAGE_PYTHON_FILE="${APP}/${projdir}"

source ${BASE}/docker_taluda.sh

if [ -f "${APP}/.superuser" ]; then
    migrate
    cd ${APP} || exit 1 && ${PYTHON}/python manage.py runserver 0.0.0.0:8000
fi

if [ ! -f "${APP}/.superuser" ]; then
    echo "Cleaning ${projTitle} Applicaton..."
    clean

    echo "Installing SuperUser..."
    cd ${BASE} || exit 1 && ./super_user.sh

    echo "Running Database Migrations..."
    migrate
    touch ${BASE}/.superuser

    echo "Setting ${projTitle} Tree Group Permissions..."
    echo "No groups to set..."
    #cd ${APP} || exit 1 && ${PYTHON}/python ${project}/.groups_init.py

    echo "Running QA Data..."
    echo "Currently NO QA Data..."
    #cd ${BASE} || exit 1 && ./qa_data.sh

    echo "Starting Server..."
    cd ${APP} || exit 1 && ${PYTHON}/python manage.py runserver 0.0.0.0:8000

fi
