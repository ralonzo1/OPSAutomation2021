from django.views.generic.edit import FormView
from django.contrib import messages
from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required

from OPSAutomation.functions import user

@login_required(login_url="registration:login")
def overview(request):
    title = "Overview"
    content = user.get_profile(request.user)

    request.session["user_id"] = request.user.id
    return render(request, "overview/overview.html", {"content": content})
