#!/usr/bin/env bash
# Author Philip De Lorenzo
# Copyright (C) 2021 Philip De Lorenzo.
# All rights reserved
#
project="OPSAutomation"
projdir="OPSAutomation"

export APP="/src"

# Setting the relative base directory
export BASE="/root/${project}"
export PYDIR=".python"
export PYTHON="${BASE}/${PYDIR}/bin"
export MANAGE_PYTHON_FILE="${APP}/${projdir}"
APPS_FILE=${APP}/.app_list

while IFS= read -r line
do
   cd ${APP} || exit 1 && ${PYTHON}/python manage.py makemigrations $line
done < $APPS_FILE

cd ${APP} || exit 1 && ${PYTHON}/python manage.py migrate && ${PYTHON}/python manage.py shell -c "from django.contrib.auth.models import User; User.objects.create_superuser('${DJANGO_SUPERUSER_USER}', '${DJANGO_SUPERUSER_EMAIL}', '${DJANGO_SUPERUSER_PASSWORD}')"

touch ${APP}/.superuser

echo "Django SuperUser --> ${DJANGO_SUPERUSER_USER}" >> ${APP}/.superuser
echo "Django SU Password --> ${DJANGO_SUPERUSER_PASSWORD}" >> ${APP}/.superuser
echo "Django User Email --> ${DJANGO_SUPERUSER_EMAIL}" >> ${APP}/.superuser
