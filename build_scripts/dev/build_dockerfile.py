#!/usr/bin/python3
import os

from dotenv import load_dotenv
from jinja2 import Environment
from jinja2 import FileSystemLoader

project = "OPSAutomation"
projdir = "OPSAutomation"

MAIN = os.path.join(os.getcwd(), "..", "..")

templates = Environment(
    loader=FileSystemLoader(os.path.join(MAIN, "docker", f"{projdir}", "template"))
)
template_dockerfile = templates.get_template("Dockerfile")
dockerfile = os.path.join(MAIN, "docker", f"{projdir}", "Dockerfile")

envfile = os.path.join(MAIN, ".env")

load_dotenv(dotenv_path=envfile)

django_user = os.getenv("DJANGO_SUPERUSER_USER")
django_pass = os.getenv("DJANGO_SUPERUSER_PASSWORD")
django_email = os.getenv("DJANGO_SUPERUSER_EMAIL")

# Output Dockerfile
w_dockerfile = template_dockerfile.render(
    django_user=django_user,
    django_pass=django_pass,
    django_email=django_email,
    project=project,
    projdir=projdir,
)

with open(dockerfile, "w") as _df:
    _df.write(w_dockerfile)
