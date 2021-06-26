#!/usr/bin/env bash
# Author Philip De Lorenzo
# Copyright (C) 2021 Philip De Lorenzo.
# All rights reserved
#
#
set -eou pipefail

LOC="$(pwd)"
DN=$(echo ${LOC} | awk -F "/" '{print $NF}')

project="OPSAutomation"
projdir="OPSAutomation"

# Check the current directory
if [ "${DN}" != "dev" ]; then echo "ERROR! Must be in the build_scripts/dev directory when executing the script..."; fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
BASE="${DIR}/../.."
APP="${BASE}/${project}"
QA="${BASE}/qa"


# Setting config
if [ -f ${BASE}/.env ]; then :; else cd ${BASE}/config || exit 1 && cp .env ..; fi # Creates the .env if it is not already there.

if [ -f "${APP}/.superuser" ]; then
    echo "Removing SuperUser..."
    rm -rf "${APP}"/.superuser
fi

while read -r app; do
    if [[ -d "${APP}/${app}/migrations" ]]; then echo "Removing ${APP}/${app}/migrations"; rm -rf ${APP}/${app}/migrations; fi

    if [[ -d "${APP}/${app}/__pycache__" ]]; then echo "Removing ${APP}/${app}/__pycache__"; rm -rf ${APP}/${app}/__pycache__; fi
done < "${APP}"/.app_list

if [ -f "${APP}/db.sqlite3" ]; then
    echo "Removing ${APP}/db.sqlite3"
    rm -rf "${APP}/db.sqlite3"
fi

# shellcheck disable=SC1090
source "${BASE}"/.env

remove_files ()
{
    rm .tool-versions
    rm .app_list
    rm requirements.txt
    rm -rf scripts
    rm -rf ${projdir}
    rm -rf ${projdir}_requirements.txt
    rm -rf Dockerfile
}

install ()
{
    # Run the installation
    cd ${BASE}/docker/${projdir} || exit 1 \
        && cp ${APP}/requirements.txt ./${projdir}_requirements.txt \
        && cp -r ${BASE}/scripts . \
        && cp ${APP}/.app_list . \
        && cp ${BASE}/requirements.txt . \
        && cp ${BASE}/.tool-versions . \
        && cp -r ${BASE}/qa . \
        && docker build . -t ${project}/${projdir}:latest \
        && remove_files # Remove the files now, to keep things clean

    # Runs as Daemon if this is a Github Action Runner
    if [ "${HOME}" == "/home/runner" ]; then
        cd ${DIR} || exit 1 && docker run -td -v ${APP}:/src -v ${QA}:/qa -p 8000:8000 ${project}/${projdir}:latest /bin/bash -c "/root/${projdir}/super_user.sh"
    else
        # Runs interactive
        cd ${DIR} || exit 1 && docker run -it -v ${APP}:/src -v ${QA}:/qa -p 8000:8000 ${project}/${projdir}:latest /bin/bash -c "/root/${projdir}/super_user.sh"
    fi
}

cd ${BASE}/docker/${projdir} \
    && if [ -f ${APP}/.superuser ]; then rm -rf ${APP}/.superuser; fi \
    && if [ -f .tool-versions ]; then rm -rf .tool-versions; fi \
    && if [ -f Dockerfile ]; then rm -rf Dockerfile; fi \
    && if [ -f .app_list ]; then rm -rf .app_list; fi \
    && if [ -f requirements.txt ]; then rm -rf requirements.txt; fi \
    && if [ -f ${projdir}_requirements.txt ]; then rm -rf ${projdir}_requirements.txt; fi \
    && if [ -d ${projdir} ]; then rm -rf ${projdir}; fi \
    & if [ -d qa ]; then rm -rf qa; fi \
    && if [ -d scripts ]; then rm -rf scripts; fi

# Run
cd ${BASE}/build_scripts/dev || exit 1 && python3 build_dockerfile.py
install

# Remove the files for cleanliness
if [ -d "${BASE}/docker/${projdir}/reqs" ]; then cd ${BASE}/docker/${projdir} || exit 1 && remove_files; else echo "Complete!"; fi
