resource "aws_iam_user_policy_attachment" "tfer--phildelorenzo_IAMUserChangePassword" {
  policy_arn = "arn:aws:iam::aws:policy/IAMUserChangePassword"
  user       = "phildelorenzo"
}
