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
from typing import Any

### Environment Variables
load_dotenv = ()

### Constants
DIR = os.path.abspath(os.path.dirname(__file__))
ENVFILE = os.path.join(DIR, "..", "..", ".env")

### Logging
logformat = "[%(asctime)s] %(levelname)s:%(name)s:%(message)s"
logging.basicConfig(
    level=logging.INFO, stream=sys.stdout, format=logformat, datefmt="%Y-%m-%d %H:%M:%S"
)

logger = logging.getLogger(__name__)

### Code
LOADER = FileSystemLoader(searchpath=os.path.join(DIR, "templates"))
TEMPLATES = Environment(loader=LOADER, autoescape=select_autoescape())

class WebWareDb():
    """
    Starts the initial connection to the WebWare database as an admin. This
    gives the ability to create new users, databases, etc.

    Args:
        None

    Returns:
        None
    """
    def __init__(self):
        """Initialize the database object."""
        self.db_config = dotenv_values(ENVFILE)
        self._driver = self.db_config["DRIVER"]
        self._server = self.db_config["SERVER"]
        self._database = self.db_config["DATABASE"] # Main database -- usually '[master]'
        self._sa_user = self.db_config["SA_USER"] # SQL Admin User/Pass
        self._sa_pass = self.db_config["SA_PASSWORD"]
        self._trust = 'Trusted_connection=yes'
        self.webware_database = f"DRIVER={self._driver}; SERVER={self._server}; DATABASE={self._database}; UID={self._sa_user}; PWD={self._sa_pass}; {self._trust}"

class DBOps(WebWareDb):
    """This is the DbOps class that is used for main WebWare Database Operations."""

    def run_query(self, query: str) -> None:
        self.conn = pyodbc.connect(self.webware_database, autocommit=True)
        self.csr = self.conn.cursor()
        self.csr.execute(query)
        self.csr.commit()
        self.csr.close()
        self.conn.close()

    def create_new_client_database(self, database) -> None:
        """Creates a new client database."""
        # We need to load the template from the templates location
        _create_template = TEMPLATES.get_template("OPS_db_template.j2")
        query = _create_template.render(_clientdb=database)

        # We need to set variables that will create the connection string to the MSSQL database
        self.run_query(query=query)


class ClientDatabase(WebWareDb):
    """Class that creates the database object to work with."""

    def __init__(self, db: str, db_user: str, db_pass: str) -> None:
        """
        This class returns an object that has an established connection to the respective database.

        Args:
            db (str): The client database to connect to.
            db_user (str): The user account for working in the database.
            db_pass (str): The password for the database user account.

        Returns:
            None
        """
        self.db = db
        self.db_user = db_user
        self.db_pass = db_pass
        self.conn = f"DRIVER={self._driver}; SERVER={self._server}; DATABASE={self.db}; UID={self.db_user}; PWD={self.db_pass}; {self._trust}"

    def run_query(self, query: str) -> None:
        self.conn = pyodbc.connect(self.conn, autocommit=True)
        self.csr = self.conn.cursor()
        self.csr.execute(query)
        self.csr.commit()
        self.csr.close()
        self.conn.close()

    def backup(self):
        """Runs a backup function to export the database."""
        pass
