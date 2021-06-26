from django import forms
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.models import Group
from django.contrib.auth.models import User
from django.core.validators import MaxValueValidator

class LoginForm(forms.Form):
    class Meta:
        fields = ["username", "password"]


class ChangePasswordForm(forms.Form):
    oldpass = forms.CharField(
        label="Old Password", widget=forms.PasswordInput, max_length=100
    )
    newpass = forms.CharField(
        label="New Password", widget=forms.PasswordInput, max_length=100
    )
    newpassconfirm = forms.CharField(
        label="Confirm New Password", widget=forms.PasswordInput, max_length=100
    )

    class Meta:
        fields = ["oldpass", "newpass", "newpassconfirm"]


class RegisterForm(UserCreationForm):
    """
    first_name = forms.CharField(
        label="First Name",
        required=True,
        widget=forms.TextInput(attrs={"placeholder": "First Name"}),
    )

    last_name = forms.CharField(
        label="Last Name",
        required=True,
        widget=forms.TextInput(attrs={"placeholder": "Last Name"}),
    )
    """

    email = forms.EmailField(
        label="Smarsh Email",
        required=True,
        help_text="Smarsh Email Address",
        widget=forms.TextInput(attrs={"placeholder": "Email"}),
    )

    class Meta:
        model = User
        fields = [
            "username",
            "password1",
            "password2",
        ]

class UserInformationChange(forms.ModelForm):
    class Meta:
        model = User
        fields = [
            "first_name",
            "last_name",
            "email",
            # Currently, we don't want users to change their username, as they are unique
            # "username",
        ]