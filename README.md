# OPS Automation Project

This project is designed for Webware Solutions, LLC. It is an automation framework to begin
the DevOps culture and tooling transformation company-wide. The goal of the project is to
empower the officials of the company by automating processes for scalability and agility.

[![Repo Regression Check](https://github.com/ralonzo1/OPSAutomation2021/actions/workflows/repo_check.yml/badge.svg)](https://github.com/ralonzo1/OPSAutomation2021/actions/workflows/repo_check.yml)

## Build Status

| Pipeline | Status |
|----------|--------|

## Unit Tests

See [Test Docs](test/README.md)

## QA Acceptance Tests

See [Test Docs](test/README.md)

## Table of Contents

- [taluda](#taluda)
  - [Build Status](#build-status)
  - [Unit Tests](#unit-tests)
  - [QA Acceptance Tests](#qa-acceptance-tests)
  - [Table of Contents](#table-of-contents)
  - [Prerequisites](#prerequisites)
    - [Terraform](#terraform)
  - [Development (Local Installation)](#development-local-installation)
  - [Development Docker Container Build](#development-docker-container-build)
    - [OPS Automation Docker Image](#ops-automation-docker-image)
  - [Secrets](#secrets)

## Prerequisites

`asdf` is a tool for auto-versioning dependencies in real-time. This repository is loaded with
a `.tool-versions` file to manage versioning.

- Python 3.7.9
- Terraform 0.14.7

### Terraform

Assuming Terraform is correctly installed, run `make setup` from the command line in the repo.
This will begin setting up the infrastucture pieces for OPS Management. There are some manual steps
that will need to be taken in order for the Terraform module to successfully manage your resources
in AWS.

Navigate to the AWS config directory.

```bash
cd ~/.aws
```

There should be a `credentials` file located here. If there is not either, please re-run the `make setup`
command to ensure that this file has been created.

Please place your proper credentials on the lines that read:

```bash
aws_access_key_id = ""
aws_secret_access_key = ""
```

The Makefile currently sets the proper AWS_PROFILE environment variable, but just for posterity, ensure that it is `ops`:

```bash
echo "${AWS_PROFILE}"
```

## Development (Local Installation)

To contribute to the `OPS Automation` project, you must first setup your environment. Our DevOps Engineers have worked to make this a breeze!

Step 1:
Clone the repo, and change directories!

```bash
git clone git@github.com:ralonzo1/OPSAutomation2021.git
```

Step 2:
Add the Django username, password and email to the .env file (Located in the main directory /unity).

```bash
DJANGO_SUPERUSER_USER="Your username"
DJANGO_SUPERUSER_EMAIL="Your email"
DJANGO_SUPERUSER_PASSWORD="Your password"
```

Step 3:
Run the build command.

```bash
make dev_local
```

Voila! You can now access the Django Framework from your browser at [http://localhost:8000](http://localhost:8000)

## Development Docker Container Build

To build a localized version of the software utilizing the power of Docker, just replace step 3 with the following command...

### OPS Automation Docker Image

Note: Make sure that Python and the needed dependencies are installed prior to running this step!

```bash
make dev_docker
```

### Secrets