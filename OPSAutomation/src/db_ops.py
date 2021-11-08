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
from dotenv import dotenv_values
from jinja2 import Environment, PackageLoader, FileSystemLoader, select_autoescape

### Environment Variables
load_dotenv = ()

### Constants
DIR = os.path.abspath(os.path.dirname(__file__))
ENVFILE = os.path.join(DIR, "..", "..", ".env")
db_config = dotenv_values(ENVFILE)
_driver = db_config["DRIVER"]
_server = db_config["SERVER"]
_database = db_config["DATABASE"]
_user = db_config["USER"]
_pass = db_config["PASSWORD"]

### Logging
logformat = "[%(asctime)s] %(levelname)s:%(name)s:%(message)s"
logging.basicConfig(
    level=logging.INFO, stream=sys.stdout, format=logformat, datefmt="%Y-%m-%d %H:%M:%S"
)

logger = logging.getLogger(__name__)

### Code
DIR = os.path.abspath(os.path.dirname(__file__))
LOADER = FileSystemLoader(searchpath=os.path.join(DIR, "templates"))
TEMPLATES = Environment(loader=LOADER, autoescape=select_autoescape())

class ClientDatabase():
    """
    Class that creates the database object to work with.
    
    Args:
        database: The database name that is to be created or worked with
    """
    def __init__(self, database):
        self._clientdb = database

    def create_db(self) -> None:
        # We need to load the template from the templates location
        _create_template = TEMPLATES.get_template("OPS_db_template.j2")
        sqlcommand = _create_template.render(_clientdb=self._clientdb)

        # We need to set variables that will create the connection string to the MSSQL database
        #_dr = 'DRIVER={ODBC Driver 17 for SQL Server}'
        _dr = f"DRIVER={_driver}"
        _se = f"SERVER={_server}"
        _db = 'DATABASE=master'

        conn = pyodbc.connect(f"{_dr}; {_se}; {_db}", autocommit=True)
        cursor = conn.cursor()
        cursor.execute(sqlcommand)
        cursor.commit()
        conn.commit()
        conn.close() # Close the connection
