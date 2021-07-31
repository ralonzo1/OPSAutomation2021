resource "aws_iam_user_group_membership" "tfer--backup-002F-backup" {
  groups = ["backup"]
  user   = "backup"
}

resource "aws_iam_user_group_membership" "tfer--github_automation-002F-Moodle" {
  groups = ["Moodle"]
  user   = "github_automation"
}

resource "aws_iam_user_group_membership" "tfer--phildelorenzo-002F-Moodle" {
  groups = ["Moodle"]
  user   = "phildelorenzo"
}
