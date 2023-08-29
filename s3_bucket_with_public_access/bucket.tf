resource "aws_s3_bucket" "bucket_with_public_access" {
  bucket        = var.bucket_name
  force_destroy = true
  tags = {
    name = var.bucket_name
  }
}

# 1 - Disable options from "Block Public Access"
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.bucket_with_public_access.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# 2 - Create Bucket policy to associate
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket_with_public_access.id
  policy = data.aws_iam_policy_document.policy_document.json
}

# 3- Data Source to generate policy document
data "aws_iam_policy_document" "policy_document" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions   = ["s3:GetObject"]
    resources = [aws_s3_bucket.bucket_with_public_access.arn, "${aws_s3_bucket.bucket_with_public_access.arn}/*",]
    effect    = "Allow"
  }
}