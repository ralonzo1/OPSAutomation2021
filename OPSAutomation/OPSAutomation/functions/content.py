import os
from typing import Any
from django.contrib import messages
from django.contrib.auth.models import Group
from django.contrib.auth.models import User
from django.shortcuts import redirect
from django.shortcuts import render
from django.apps import apps

# from registration import urls
from OPSAutomation import settings
from OPSAutomation.functions.user import get_greeting

def base_content(request):
    """This function pre-loads and populates a much needed dictionary for
    the templates.

    Args:
        request (object): The request object from the POST.

    Returns:
        content (dict): The initialized content dictionary for template rendering.
        context_unit (int): The current context unit by id#.

    """
    content = {}
    content.update({"greeting": get_greeting(request.user)})
    return content
