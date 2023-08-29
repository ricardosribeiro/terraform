resource "aws_s3_bucket" "bucket_website_configuration" {
  bucket        = var.bucket_name
  force_destroy = true
  tags = {
    name = var.bucket_name
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.bucket_website_configuration.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket_website_configuration.id
  policy = data.aws_iam_policy_document.policy_document.json
}

data "aws_iam_policy_document" "policy_document" {
  statement {
    actions   = ["s3:GetObject"]
    resources = [aws_s3_bucket.bucket_website_configuration.arn, "${aws_s3_bucket.bucket_website_configuration.arn}/*"]
    effect    = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket_website_configuration" "bucket_website_configuration" {
  bucket = aws_s3_bucket.bucket_website_configuration.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}
