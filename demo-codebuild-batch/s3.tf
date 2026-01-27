resource "aws_s3_bucket" "artifacts" {
  for_each = local.troy-organization
  bucket   = lookup(each.value.artifacts, "location", null)
  tags = {
    Name = lookup(each.value.artifacts, "location", null)
  }
}

resource "aws_s3_bucket" "cache" {
  for_each = local.troy-organization
  bucket   = lookup(each.value.cache, "location", null)
  tags = {
    Name = lookup(each.value.cache, "location", null)
  }
}

# resource "aws_s3_bucket_acl" "artifacts" {
#   bucket     = aws_s3_bucket.artifacts.id
#   acl        = "private"
#   depends_on = [aws_s3_bucket_ownership_controls.artifacts]
# }

# resource "aws_s3_bucket_ownership_controls" "artifacts" {
#   bucket = aws_s3_bucket.artifacts.id

#   rule {
#     object_ownership = "ObjectWriter"
#   }
# }