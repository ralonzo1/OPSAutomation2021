#!/usr/bin/env bash
# Author Philip De Lorenzo
# Copyright (C) 2021
# All rights reserved
#

set -euo pipefail
project="OPSAutomation"
projdir="OPSAutomation"

# Setting the relative base directory
BASEDIR=$(realpath "$(dirname "$0")")
BASE="${BASEDIR}/.."
DEV="${BASE}/dev/local"
PYDIR=".python"
APPDIR="${BASE}/${project}/${projdir}"

if [[ -f "${BASE}/${project}/.app_list" ]]; then
    APPS_FILE="${BASE}/${project}/.app_list"
elif [[ -f "${APPDIR}/.app_list" ]]; then
    APPS_FILE="${APPDIR}/.app_list"
fi

# Creates the superuser for Django
superuser ()
{
    source ${BASE}/.env
    cd ${BASE}/${project} || exit 1 && ${DEV}/${PYDIR}/bin/python manage.py shell -c "from django.contrib.auth.models import User; User.objects.create_superuser('${DJANGO_SUPERUSER_USER}', '${DJANGO_SUPERUSER_EMAIL}', '${DJANGO_SUPERUSER_PASSWORD}')"
}

# Runs the installation of Python and packages
install ()
{
    # Setting config
    if [ -f ${BASE}/.env ]; then
        : # Do nothing here if the conditional matches
    else
        if [ -z "${GITHUB_ACTION+x}" ]; then
            cd ${BASE}/config || exit 1 && cp .env ..
            echo "Please add environment configs to the .env file."
            exit 1 # Creates the .env if it is not already there.
        else
            cd ${BASE}/config || exit 1 && cp .env .. # Creates the .env if it is not already there.
        fi
    fi

    if [[ -d "${DEV}/${PYDIR}" ]]; then
        rm -rf ${DEV}/${PYDIR}
    fi

    # Runs the setup and installs the application for use
    python3 -m virtualenv ${DEV}/${PYDIR}

    # Pip packagesss
    cd ${APPDIR} || exit 1 && ${DEV}/${PYDIR}/bin/pip install --upgrade pip && ${DEV}/${PYDIR}/bin/pip install -r ../requirements.txt

    # Run the migrations
    while IFS= read -r line
    do
        cd ${BASE}/${project} || exit 1 && ${DEV}/${PYDIR}/bin/python manage.py makemigrations $line
    done < $APPS_FILE

    cd ${BASE}/${project} || exit 1 && ${DEV}/${PYDIR}/bin/python manage.py migrate # Commit migrations

    # Create the Super User from .env
    source ${BASE}/.env

    echo "Create the super user for the application..."
    echo "Change directories to the \'${projdir}\' directory, and \'$> run ${DEV}/${PYDIR}/bin/python manage.py createsuperuser\'"
    echo ""
    echo ""
    echo "Exporting DJANGO_SETTINGS_MODULE"
    export DJANGO_SETTINGS_MODULE=${projdir}.settings
}

clean ()
{
    echo "Cleaning the project of cached files and migrations."
    if [[ -f "${APPDIR}/db.sqlite3" ]]; then rm -rf ${APPDIR}/db.*; fi
    if [[ -d "${APPDIR}/__pycache__" ]]; then rm -rf ${APPDIR}/__pycache__; fi
    if [[ -d "${APPDIR}/${projdir}/__pycache__" ]]; then rm -rf ${APPDIR}/${projdir}/__pycache__; fi

    # Cleaning apps
    while IFS= read -r line
    do
        echo "Removing ${APPDIR}/${line}/migrations"
        if [[ -d "${APPDIR}/${line}/migrations" ]]; then rm -rf ${APPDIR}/${line}/migrations; fi

        echo "Removing ${APPDIR}/${line}/__pycache__"
        if [[ -d "${APPDIR}/${line}/__pycache__" ]]; then rm -rf ${APPDIR}/${line}/__pycache__; fi

        echo "Removing ${APPDIR}/db.sqlite3"
        if [[ -f "${APPDIR}/db.sqlite3" ]]; then
            rm -rf ${APPDIR}/db.sqlite3
        fi

        echo "Removing ${APPDIR}/${line}/db.sqlite3"
        if [[ -f "${APPDIR}/${line}/db.sqlite3" ]]; then
            rm -rf ${APPDIR}/${line}/db.sqlite3
        fi

        echo "Removing ${BASE}/${project}/db.sqlite3"
        if [[ -f "${BASE}/${project}/db.sqlite3" ]]; then
            rm -rf ${BASE}/${project}/db.sqlite3
        fi

        echo "Removing ${BASE}/${project}/${line}/db.sqlite3"
        if [[ -f "${BASE}/${project}/${line}/db.sqlite3" ]]; then
            rm -rf ${BASE}/${project}/${line}/db.sqlite3
        fi

    done < $APPS_FILE

    echo "Removing Python Virtual Environment"

    if [[ -d "${DEV}/${PYDIR}" ]]; then echo "Removing local development Python installation..."; rm -rf ${DEV}/${PYDIR}; fi # Removes the local .python installation folder

    # Remove the .superuser file
    if [ -f ${BASE}/${project}/.superuser ]; then rm ${BASE}/${project}/.superuser; fi
}

database_init ()
{
    ${DEV}/${PYDIR}/bin/python ${BASEDIR}/${project}/.groups_init.py
}

usage() { echo "Usage: $0 -c (clean) -i (install) -d (database_init) -s (create_superuser)"; exit 0; }
[ $# -eq 0 ] && usage
while getopts ":icds" o; do
    case "${o}" in
        c)
            clean
            ;;
        i)
            install
            ;;
        d)
            database_init
            ;;
        s)
            superuser
            ;;
        *)
            usage
            ;;
    esac
done
