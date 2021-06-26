import django.contrib.auth as auth
from django.views.generic.edit import FormView
from django.contrib import messages
from django.contrib.auth.models import Group
from django.contrib.auth.models import User
from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required

from .forms import (
    LoginForm,
    ChangePasswordForm,
    RegisterForm,
)

from OPSAutomation.functions.content import base_content
from OPSAutomation.functions import user
from .forms import UserInformationChange

def register(request):
    """Register view.

    This module first gets a list of all of the current companies in the database.
    It passes the data to the UI, to be filtered when a user selects their state.

    Args:
        request (Any): The request object sent to the server from the end-point.

    Returns:
        A success/fail message and renders a new account for usage.

    """

    if request.method == "GET":
        form = RegisterForm()

    elif request.method == "POST":
        form = RegisterForm(request.POST)
        if form.is_valid():
            # We need to check if the company is already registered in the database for this conditional
            _user = user.user_check(form.cleaned_data.get("username"))

            # We want companies to be unique, so we check for that here and render proper messaging
            if _user.exists():
                messages.error(
                    request,
                    "The user is already registered in the database.",
                )
                return redirect("registration:register")
            else:
                # Email
                email = form.cleaned_data.get("email")
                username = form.cleaned_data.get("username")
                password1 = form.cleaned_data.get("password1")
                password2 = form.cleaned_data.get("password2")

                # We want to create the user account
                if user.password_check(password1, password2):
                    User.objects.create_user(username, email, password1)
                    messages.success(
                        request, "Your account has been created, you may now login."
                    )
                    return redirect("registration:login")

                else:
                    messages.error(
                        request,
                        "The passwords entered do not match. Please try again!.",
                    )

        else:
            messages.error(
                request, "The form is not valid. Please contact administrator."
            )

    else:
        form = RegisterForm()

    return render(request, "registration/register.html", {"form": form})


def login(request):
    if request.method == "POST":
        form = LoginForm(request.POST)
        if form.is_valid():
            username = request.POST["username"]
            password = request.POST["password"]
            user = auth.authenticate(username, password)
            auth.login(request, user)
            return redirect(request, "overview")
        else:
            messages.error(request, "The form was not valid, please try again.")
            form = LoginForm()
    else:
        form = LoginForm()

    return render(request, "registration/login.html", {"form": form})


@login_required(login_url="registration:login")
def logout(request):
    auth.logout(request)
    return redirect("registration:login")


@login_required(login_url="registration:login")
def change_password(request):
    """View to allow the user to change their password from the profile.

    Args:
        request (Any): The request from the client end-point.

    Returns:
        message (Any): Returns a message if the change request was successfull.

    """
    password_items = ["oldpass", "newpass", "newpassconfirm"]
    if request.method == "POST":
        for i in password_items:
            if i not in request.POST:
                messages.error(request, "The form is not working correctly.")
                return redirect("user:profile")
            elif request.user.check_password(request.POST["oldpass"]) is False:
                messages.error(
                    request, "The current password does not match our records."
                )
                return redirect("user:profile")
            elif request.POST["newpass"] != request.POST["newpassconfirm"]:
                messages.error(
                    request, "The new password does not match, please try again."
                )
                return redirect("user:profile")
            else:
                request.user.set_password(request.POST["newpass"])
                request.user.save()
                messages.success(request, "Your password was changed successfully.")
                return redirect("user:profile")

    else:
        return redirect("user:profile")


@login_required(login_url="registration:login")
def profile(request):
    title = "Profile"

    content = base_content(request)
    if request.method == "POST" and request.POST["submit_pass"]:
        if changePasswordForm.is_valid():
            changePasswordForm = ChangePasswordForm(request.POST)
        else:
            messages.error(request, "The form is not valid, please try again.")
            changePasswordForm = ChangePasswordForm()
    elif request.method == "POST" and request.POST["submit_info"]:

        if changeUserInfoForm.is_valid():
            changeUserInfoForm = UserInformationChange(
                request.POST, instance=request.user
            )
        else:
            messages.error(request, "The form is not valid, please try again.")
            changeUserInfoForm = UserInformationChange(instance=request.user)
    else:
        changePasswordForm = ChangePasswordForm()
        changeUserInfoForm = UserInformationChange(instance=request.user)

    return render(
        request,
        "registration/profile.html",
        {
            "content": content,
            "user": User.objects.get(id=request.session["user_id"]),
            "changePasswordForm": changePasswordForm,
            "changeUserInfoForm": changeUserInfoForm,
        },
    )


@login_required(login_url="registration:login")
def change_info(request):
    """View to allow the user to change some personal data in their profile.

    Args:
        request (Any): The request from the client end-point.

    Returns:
        message (Any): Returns a message if the change request was successfull.

    """

    if request.method == "POST" and "submit" in request.POST:
        user = request.user
        user.first_name = request.POST["first_name"]
        user.last_name = request.POST["last_name"]
        user.email = request.POST["email"]
        user.save()
        messages.success(request, "Successfully updated your profile.")
        return redirect("owner:profile")
    else:
        return redirect("owner:profile")
