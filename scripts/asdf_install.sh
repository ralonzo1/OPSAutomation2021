#!/usr/bin/env bash
# Author Philip De Lorenzo
# Copyright (C) 2020 The Unity Project, LLC.
# All rights reserved
#
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
BASE=${DIR}/..
packages=( build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl git )

password()
{
    if [ "$(whoami)" != "root" ]; then
        echo "This requires root to install."
        read -s -p "Password: " password
    fi
}

prerequisites()
{
    if [ "$(uname)" == "Linux" ];then
        for i in "${packages[@]}"; do
            if [[ -n $(dpkg -s ${i} | grep -n 'Status:') && $(dpkg -s ${i} | grep -n 'Status:' | awk '{print $3}') == "ok" ]]; then
                echo "Package: ${i} installed --> OK!"
            else
                password # Getting the password from the password function above
                echo $password | sudo apt-get install -y ${i}
            fi
        done
    fi
}

prequisite_check()
{
    # Check the system - asdf currently only supports Linux/Mac
    if [[ "$(uname)" == "Darwin" ]] || [[ "$(uname)" == "Linux" ]]; then
        : # Continue
    else
        echo "ERROR: asdf can only install on Linux/Mac systems."
        echo "CRITICAL: Please ensure that you are attempting to install on this system platform."
        exit 1
    fi

    # Ensure needed binaries are installed
    if [ -n "$(command -v git)" ]; then
        : # Continue
    else
        if [ "$(uname)" == "Linux" ];then
            prerequisites
        else
            echo "ERROR: Git must be installed."
            echo "CRITICAL: Refer to the Git installation for your OS Platform."
            exit 1
        fi
    fi
}


bash_install()
{
    # This installs needed data into the .bash_profile file
    if [ -f ~/.bash_profile ]; then
        grep -Fxq '. $HOME/.asdf/asdf.sh' ~/.bash_profile || sed -i -e '$a\. $HOME/.asdf/asdf.sh' ~/.bash_profile
        grep -Fxq '. $HOME/.asdf/completions/asdf.bash' ~/.bash_profile || sed -i -e '$a\. $HOME/.asdf/completions/asdf.bash' ~/.bash_profile
    else
        echo '#!/usr/bin/env bash' > ~/.bash_profile
        echo '' >> ~/.bash_profile
        echo 'export PATH=$PATH' >> ~/.bash_profile
        echo '' >> ~/.bash_profile
        echo '. $HOME/.asdf/asdf.sh' >> ~/.bash_profile
        echo '. $HOME/.asdf/completions/asdf.bash' >> ~/.bash_profile
        echo '' >> ~/.bash_profile
    fi
}


zsh_install()
{
    # This installs needed data into the .zshrc file
    if [ -f ~/.zshrc ]; then
        grep -Fxq '. $HOME/.asdf/asdf.sh' ~/.zshrc || sed -i -e '$a\ $HOME/.asdf/asdf.sh' ~/.zshrc
        grep -Fxq 'fpath=(${ASDF_DIR}/completions $fpath)' ~/.zshrc || sed -i -e '$afpath=(${ASDF_DIR}/completions $fpath)' ~/.zshrc
        grep -Fxq 'autoload -Uz compinit' ~/.zshrc || sed -i -e '$aautoload -Uz compinit' ~/.zshrc
        grep -Fxq 'compinit' ~/.zshrc || sed -i -e '$acompinit' ~/.zshrc
    else
        echo '#!/bin/zsh' > ~/.zshrc
        echo '' >> ~/.zshrc
        echo 'export PATH=$PATH' >> ~/.zshrc
        echo '' >> ~/.zshrc
        echo '. $HOME/.asdf/asdf.sh' >> ~/.zshrc
        echo '' >> ~/.zshrc
        echo 'fpath=(${ASDF_DIR}/completions $fpath)' >> ~/.zshrc
        echo 'autoload -Uz compinit' >> ~/.zshrc
        echo 'compinit' >> ~/.zshrc
        echo '' >> ~/.zshrc
    fi

    . ~/.zshrc
}


asdf_check()
{
    # Checks if asdf is installed
    if [ -d ~/.asdf ]; then
        echo "WARNING: It appears that asdf has already been installed, please check ~/.asdf."
        echo "INFO: Ensuring ${SHELL} is correct..."
        install_to_default_shell
        exit 0
    fi
}


asdf_install_plugin()
{
    # Adds a plugin
    asdf plugin add ${1}
}


asdf_plugin_check_and_install()
{
    # Adds any of the plugins that are intended for installation
    if [ -f ${BASE}/.tool-versions ]; then
        while IFS= read -r line; do
            if [[ -n $(echo ${line} | grep -v '^#') ]]; then
                PLUGIN=$(echo ${line} | cut -d" " -f1)
                asdf_install_plugin ${PLUGIN} # If the line is NOT commented out, we want to install it
            fi
        done < ${BASE}/.tool-versions
    fi
}


install_to_default_shell()
{
    # Finds your SHELL and installs accordingly
    if [[ "${SHELL}" == *"zsh"* ]]; then
        echo "INFO: Installing asdf for Zsh..."
        zsh_install
        echo "INFO: Checking for tooling installs..."
        asdf_plugin_check_and_install
    elif [[ "${SHELL}" == *"bash"* ]]; then
        echo "INFO: Installing asdf for Bash..."
        bash_install
        echo "INFO: Checking for tooling installs..."
        asdf_plugin_check_and_install
    fi
}


asdf_install()
{
    # Installs asdf
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0
    install_to_default_shell
    asdf_plugin_check_and_install

    # Running the installation of the needed tools from this repo
    asdf install
}

# Install asdf
prequisite_check
asdf_check
asdf_install
