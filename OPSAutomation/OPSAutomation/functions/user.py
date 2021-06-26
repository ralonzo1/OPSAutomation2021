#!/usr/bin/python3
#
# Copyright (C) 2021
# This file is part of NPPD
#
# NPPD can not be copied and/or distributed without the express
# permission of Smarsh, Inc.
#
# All rights reserved.
#

__name__ = "OPSAutomation User Functions"
__owner__ = ""
__author__ = "Philip De Lorenzo"
__license__ = ""

### Imports
import sys
import logging

# Django Imports
from django.contrib.auth.models import User


### Logging
logformat = "[%(asctime)s] %(levelname)s:%(name)s:%(message)s"
logging.basicConfig(
    level=logging.INFO, stream=sys.stdout, format=logformat, datefmt="%Y-%m-%d %H:%M:%S"
)

### Code
def user_check(username):
    return User.objects.filter(username=username)

def password_check(password1, password2):
    if password1 == password2:
        return True
    else:
        return False

def get_user_object(user):
    """Returns the User() model object for the request user."""
    return User.objects.get(username=user)

def get_greeting(USER):
    """Returns the first name of the user with Capitalization ensured."""
    if USER.get_short_name():
        greeting = USER.first_name.capitalize()
    else:
        greeting = str(USER)

    return greeting

def get_profile(user):
    content = (
        {}
    )  # We need to set this empty dict() to populate before sending to the view

    USER = get_user_object(user)
    content.update({"username": str(user)})
    content.update({"USER": USER})

    ### Profile section
    # If the owner hasn't entered their first and last name into the profile page, then we want to display their username in the "Hello, {{ Name }}" section
    greeting = get_greeting(USER)

    content.update({"greeting": greeting})  # We need to add to the dictionary

    return content