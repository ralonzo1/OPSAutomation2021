resource "aws_iam_group_policy_attachment" "tfer--Moodle_AdministratorAccess" {
  group      = "Moodle"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_group_policy_attachment" "tfer--Moodle_AdministratorAccess-002D-Amplify" {
  group      = "Moodle"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess-Amplify"
}

resource "aws_iam_group_policy_attachment" "tfer--Moodle_AlexaForBusinessDeviceSetup" {
  group      = "Moodle"
  policy_arn = "arn:aws:iam::aws:policy/AlexaForBusinessDeviceSetup"
}

resource "aws_iam_group_policy_attachment" "tfer--Moodle_AlexaForBusinessFullAccess" {
  group      = "Moodle"
  policy_arn = "arn:aws:iam::aws:policy/AlexaForBusinessFullAccess"
}

resource "aws_iam_group_policy_attachment" "tfer--Moodle_AlexaForBusinessGatewayExecution" {
  group      = "Moodle"
  policy_arn = "arn:aws:iam::aws:policy/AlexaForBusinessGatewayExecution"
}

resource "aws_iam_group_policy_attachment" "tfer--Moodle_AlexaForBusinessLifesizeDelegatedAccessPolicy" {
  group      = "Moodle"
  policy_arn = "arn:aws:iam::aws:policy/AlexaForBusinessLifesizeDelegatedAccessPolicy"
}

resource "aws_iam_group_policy_attachment" "tfer--Moodle_AlexaForBusinessPolyDelegatedAccessPolicy" {
  group      = "Moodle"
  policy_arn = "arn:aws:iam::aws:policy/AlexaForBusinessPolyDelegatedAccessPolicy"
}

resource "aws_iam_group_policy_attachment" "tfer--Moodle_AlexaForBusinessReadOnlyAccess" {
  group      = "Moodle"
  policy_arn = "arn:aws:iam::aws:policy/AlexaForBusinessReadOnlyAccess"
}

resource "aws_iam_group_policy_attachment" "tfer--Moodle_AmazonAPIGatewayAdministrator" {
  group      = "Moodle"
  policy_arn = "arn:aws:iam::aws:policy/AmazonAPIGatewayAdministrator"
}

resource "aws_iam_group_policy_attachment" "tfer--Moodle_AmazonAPIGatewayInvokeFullAccess" {
  group      = "Moodle"
  policy_arn = "arn:aws:iam::aws:policy/AmazonAPIGatewayInvokeFullAccess"
}

resource "aws_iam_group_policy_attachment" "tfer--backup_AdministratorAccess" {
  group      = "backup"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_group_policy_attachment" "tfer--backup_AmazonS3FullAccess" {
  group      = "backup"
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}
