from django.contrib import messages
from django.shortcuts import redirect
from django.shortcuts import render
from .forms import UserRegisterForm
from django.shortcuts import render

# Create your views here.
def home(request):
    """Renders the home page."""
    content = {}
    return render(request, "home.html", {"content": content})

def about(request):
    """Renders the about page."""
    content = {}
    return render(request, "about.html", {"content": content})

def register(request):
    if request.method == "POST":
        form = UserRegisterForm(request.POST)

        if form.is_valid():
            first_name = form.cleaned_data.get("first_name").lower()
            last_name = form.cleaned_data.get("last_name").lower()
            username = form.cleaned_data.get("username")
            email = form.cleaned_data.get("email")

            User.objects.create(
                first_name=first_name.capitalize(),
                last_name=last_name.capitalize(),
                username=username,
                email=email
            )

            messages.success(
                request,
                "You have been registered, you can now login!",
            )

            return redirect("login")

        else:
            form = UserRegisterForm()
    else:
        form = UserRegisterForm()

    return render(request, "users/register.html", {"form": form})
