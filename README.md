# OPS Automation Project

This project is designed for Webware Solutions, LLC. It is an automation framework to begin
the DevOps culture and tooling transformation company-wide. The goal of the project is to
empower the officials of the company by automating processes for scalability and agility.

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

The Makefile currently sets the proper AWS_PROFILE environment variable, but just for posterity, ensure that
it is `ops`:

```bash
echo "${AWS_PROFILE}"
```
