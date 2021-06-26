from django.contrib.auth import views as auth_views
from django.urls import include
from django.urls import path

from . import views

app_name = "registration"

urlpatterns = [
    path(
        "login/",
        auth_views.LoginView.as_view(template_name="registration/login.html"),
        name="login",
    ),
    path(
        "logout/",
        auth_views.LogoutView.as_view(template_name="registration/logout.html"),
        name="logout",
    ),
    path("profile/", views.profile, name="profile"),
    path("register/", views.register, name="register"),
    path("change_info/", views.change_info, name="change_info"),
    path("change_password/", views.change_password, name="change_password"),
]
