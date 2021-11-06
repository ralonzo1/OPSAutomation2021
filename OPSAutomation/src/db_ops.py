#!/usr/bin/python3
#
# Copyright (C) 2020 The Unity Project, LLC
# This file is part of {{ PROJECT }}
#
# {{ PROJECT }} can not be copied and/or distributed without the express
# permission of The Unity Project, LLC.
# All rights reserved.
#

__name__ = "db_ops"
__owner__ = "The Unity Project, LLC"
__author__ = "Philip De Lorenzo"
__license__ = ""

### Imports
import os
import sys
import logging
import pyodbc
from dotenv import load_dotenv, dotenv_values

### Environment Variables
load_dotenv = ()

### Constants
DIR = os.path.abspath(os.path.dirname(__file__))
ENVFILE = os.path.join(DIR, "..", "..", ".env")
db_config = dotenv_values(ENVFILE)
_driver = db_config["DRIVER"]
_server = db_config["SERVER"]
_database = db_config["DATABASE"]
_user = db_config["UID"]
_pass = db_config["PWD"]

### Logging
logformat = "[%(asctime)s] %(levelname)s:%(name)s:%(message)s"
logging.basicConfig(
    level=logging.INFO, stream=sys.stdout, format=logformat, datefmt="%Y-%m-%d %H:%M:%S"
)

logger = logging.getLogger(__name__)

### Code
DRIVER={ODBC Driver 17 for SQL Server};SERVER=_server;DATABASE=_database;UID=_user;PWD=_pass
