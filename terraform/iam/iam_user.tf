resource "aws_iam_user" "tfer--AIDAS7ZSTIRRIGGPEBVGO" {
  force_destroy = "false"
  name          = "phildelorenzo"
  path          = "/"
}

resource "aws_iam_user" "tfer--AIDAS7ZSTIRRIKZ3RSQFN" {
  force_destroy = "false"
  name          = "github_automation"
  path          = "/"

  tags = {
    DESCRIPTION = "Programmatic access key for Terraform use within Github"
  }
}

resource "aws_iam_user" "tfer--AIDAS7ZSTIRRIOVRMUVJK" {
  force_destroy = "false"
  name          = "backup"
  path          = "/"

  tags = {
    backup = ""
  }
}
