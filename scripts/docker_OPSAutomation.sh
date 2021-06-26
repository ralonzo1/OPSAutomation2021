#!/usr/bin/env bash
# Author Philip De Lorenzo
# Copyright (C) 2021 Philip De Lorenzo
# All rights reserved
#
project="OPSAutomation"
projdir="OPSAutomation"

# Setting the relative base directory
export APP="/src"
export BASE="/root/${project}"
export PYDIR=".python"
export PYTHON="${BASE}/${PYDIR}/bin"

# Runs the installation of Python and packages
install ()
{
    if [[ -d "${BASE}/${PYDIR}" ]]; then
        rm -rf ${BASE}/${PYDIR}
    fi

    # Upgrade pip
    pip3 install --upgrade pip
    pip3 install --no-cache-dir -r /root/${project}/requirements.txt

    # Install the Virtual Environment
    python3 -m virtualenv ${BASE}/${PYDIR}

    # Pip packages
    ${PYTHON}/pip3 install --upgrade pip
    ${PYTHON}/pip3 install --no-cache-dir -r ${BASE}/${projdir}_requirements.txt
}

qa_data ()
{
    # Prep and installation of the QA data for development
    ${PYTHON}/pip3 install -r ${BASE}/qa/requirements.txt
    /bin/bash -c "${PYTHON}/python ${BASE}/qa/data/.data_init.py"
}

clean ()
{
    echo "Cleaning the project of cached files and migrations."
    while read -r app; do
        if [[ -d "/src/${app}/migrations" ]]; then echo "Removing /src/${projdir}/${app}/migrations"; rm -rf /src/${projdir}/${app}/migrations; fi

        if [[ -d "/src/${projdir}/${app}/__pycache__" ]]; then echo "Removing /src/${projdir}/${app}/__pycache__"; rm -rf /src/${projdir}/${app}/__pycache__; fi
    done < /root/${project}/.app_list

    if [[ -f "/src/${projdir}/db.sqlite3" ]]; then
        echo "Removing /src/${projdir}/${app}/db.sqlite3"
        rm -rf /src/${projdir}/db.sqlite3
    fi

    if [ -f ${APP}/.superuser ]; then rm ${APP}/.superuser; fi
}

migrate ()
{
    echo "Migrating the project's application database migrations."
    ${PYTHON}/python ${APP}/manage.py makemigrations
    ${PYTHON}/python ${APP}/manage.py migrate

    while read -r app; do
        ${PYTHON}/python ${APP}/manage.py migrate ${app}

    done < /root/${project}/.app_list
}
