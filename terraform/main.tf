terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "ops-state-file"
    key            = "webware_ops.tfstate"
    region         = "us-west-2"
    # Replace this with your DynamoDB table name!
    encrypt        = true
  }
}

resource "aws_dynamodb_table" "dynamodb-terraform-state-locks" {
  name         = "ops-state-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
