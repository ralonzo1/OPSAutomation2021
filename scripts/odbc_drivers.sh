#!/usr/bin/env bash

if [[ "$(uname -p)" == "arm" ]]; then
    # Add MSSQL information/download
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    brew tap microsoft/mssql-release https://github.com/Microsoft/homebrew-mssql-release
    brew update

    # Pull the drivers from HomeBrew
    HOMEBREW_NO_ENV_FILTERING=1 ACCEPT_EULA=Y brew install msodbcsql17 mssql-tools unixodbc

    export LDFLAGS="-L/opt/homebrew/Cellar/unixodbc/2.3.9/lib"
    export CPPFLAGS="-I/opt/homebrew/Cellar/unixodbc/2.3.9/include"
fi

# If MacOS, ensure that the .ini file is correctly placed
if [ $(uname) == "Darwin" ]; then
    if [ -f /opt/homebrew/etc/odbcinst.ini ]; then
        if [ ! -d ~/Library/ODBC ]; then mkdir -p ~/Library/ODBC; fi # Make the directory
        cp /opt/homebrew/etc/odbcinst.ini ~/Library/ODBC/odbcinst.ini
    fi
fi
