#!/usr/bin/env bash
# Author Philip De Lorenzo
# Copyright (C) 2020 The Unity Project, LLC.
# All rights reserved
#
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

install_plugins ()
{
    # Credit to https://github.com/micke/asdf-docker

    echo "Installing asdf plugins..."
    if [ ! -f "${DIR}"/.tool-versions ]; then
        echo ".tool-versions file not found!"
        exit 1
    fi

    while read -r _line; do
        plugin="$(echo "${_line}" | awk '{print $1}')"
        ret="$(asdf plugin list | grep "${plugin}")"

        if [ "${ret}" == "${plugin}" ]; then
            echo "${plugin} is already installed. Skipping"
        else
            echo "Installing ${plugin} Plugin"
            asdf plugin-add "${plugin}" > /dev/null 2>&1
            ex=$?

            if [ $ex -eq 2 ] || [ $ex -eq 0 ]; then
                echo "Successfully installed ${plugin} Plugin"
            else
                echo "Error installing ${plugin} Plugin"
                exit $ex
            fi

            if [ "${plugin}" = "nodejs" ]; then
                bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
            fi
        fi
    done < "${DIR}"/.tool-versions
}

install_versions ()
{
    # Credit to https://github.com/micke/asdf-docker

    echo "Installing asdf package versions..."
    if [ ! -f "${DIR}"/.tool-versions ]; then
        echo ".tool-versions file not found!"
        exit 1
    fi

    while read -r _line; do
        plugin="$(echo "${_line}" | awk '{print $1}')"
        version="$(echo "${_line}" | awk '{print $2}')"

        if [[ "$(asdf where "${plugin} ${version}")" != "Version not installed" ]]; then
            echo "${plugin} --version ${version} is already installed. Reshimming"
            asdf reshim "${plugin} ${version}"
        else
            echo "${plugin} --version ${version} is not installed. Trying to install..."
            asdf install "${plugin}" "${version}"
            echo "\n\nPATH=\"/root/.asdf/installs/${plugin}/${version}/bin:$PATH\"" >> /root/.bash_profile

            if [ $? == 1 ]; then
                echo "Error installing ${plugin} version ${version}"
                exit 1
            fi
        fi
    done < "${DIR}"/.tool-versions
}

install_pip_requirements ()
{
    source /root/.bash_profile
    python -m ensurepip --upgrade
    cd /usr/local/bin || exit 1 && pip install --upgrade pip
    cd /usr/local/bin || exit 1 && pip install -r requirements.txt
}

install_plugins
install_versions
install_pip_requirements
