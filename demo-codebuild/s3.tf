resource "aws_s3_bucket" "artifacts" {
  bucket = local.bucket_name
  tags = {
    Name = local.bucket_name
  }
}

resource "aws_s3_bucket_acl" "artifacts" {
  bucket     = aws_s3_bucket.artifacts.id
  acl        = "private"
  depends_on = [aws_s3_bucket_ownership_controls.artifacts]
}

resource "aws_s3_bucket_ownership_controls" "artifacts" {
  bucket = aws_s3_bucket.artifacts.id

  rule {
    object_ownership = "ObjectWriter"
  }
}

locals {
  bucket_name = "demo-codebuild-artifacts-s3"
}