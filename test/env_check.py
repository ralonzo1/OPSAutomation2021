### 
# Env file check

import os
import configparser

config = configparser.ConfigParser()
config.read(
    "config.ini"
)

DIR = os.path.abspath(os.path.dirname(__file__))
BASE = os.path.join(DIR, "..")
ENV = os.path.join(BASE, ".config", ".env")

with open(ENV, "r") as _file:
    for line in _file.readlines():
        if ("AWS_" in line) and ("_KEY" in line):
            assert line.split("=")[1].strip() == '""', "Passwords deteced, please remove and re-commit!"
