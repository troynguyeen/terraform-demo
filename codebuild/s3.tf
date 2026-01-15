resource "aws_s3_bucket" "artifacts" {
  bucket = local.bucket_name
  tags = {
    Name = local.bucket_name
  }
}

resource "aws_s3_bucket_acl" "artifacts" {
  bucket = aws_s3_bucket.artifacts.id
  acl    = "private"
}

locals {
  bucket_name = "codebuild-artifacts-s3"
}