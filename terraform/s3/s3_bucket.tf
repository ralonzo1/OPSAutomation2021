resource "aws_s3_bucket" "tfer--ops-002D-state-002D-file" {
  arn            = "arn:aws:s3:::ops-state-file"
  bucket         = "ops-state-file"
  force_destroy  = "false"
  hosted_zone_id = "Z3BJ6K6RIION7M"
  request_payer  = "BucketOwner"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning {
    enabled    = "true"
    mfa_delete = "false"
  }
}

resource "aws_s3_bucket" "tfer--webware-002D-ops-002D-database-002D-backups" {
  arn            = "arn:aws:s3:::webware-ops-database-backups"
  bucket         = "webware-ops-database-backups"
  force_destroy  = "false"
  hosted_zone_id = "Z3BJ6K6RIION7M"

  policy = <<POLICY
{
  "Id": "S3PolicyId1",
  "Statement": [
    {
      "Action": "s3:*",
      "Condition": {
        "IpAddress": {
          "aws:SourceIp": "191.236.123.131/29"
        },
        "NotIpAddress": {
          "aws:SourceIp": "0.0.0.0/0"
        }
      },
      "Effect": "Allow",
      "Principal": "*",
      "Resource": "arn:aws:s3:::webware-ops-database-backups/*",
      "Sid": "IPAllow"
    }
  ],
  "Version": "2012-10-17"
}
POLICY

  request_payer = "BucketOwner"

  tags = {
    backup = ""
  }

  versioning {
    enabled    = "true"
    mfa_delete = "false"
  }
}
