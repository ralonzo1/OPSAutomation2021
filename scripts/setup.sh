#!/bin/bash

set -euo pipefail

create_creds () {
    cat <<CREDS
    [ops]
    aws_access_key_id = ""
    aws_secret_access_key = ""

CREDS
}

terraform () {
    # Setup the terraform settings if not exists
    if [ ! ~/.aws ]; then
        mkdir ~/.aws
        touch ~/.aws/credentials
        create_creds
    else
        if [ -f ~/.aws/credentials ]; then
            echo "There is already a credentials file. Fill out the needed data fields provided in the README."
        fi
    fi
}

terraform
export AWS_PROFILE=ops
