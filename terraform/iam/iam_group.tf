resource "aws_iam_group" "tfer--Moodle" {
  name = "Moodle"
  path = "/"
}

resource "aws_iam_group" "tfer--backup" {
  name = "backup"
  path = "/"
}
