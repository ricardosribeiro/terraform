resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.bucket_website.id

  block_public_acls       = false
  block_public_policy     = false
  restrict_public_buckets = false
  ignore_public_acls      = false
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket_website.id
  policy = data.aws_iam_policy_document.policy_document.json
}

data "aws_iam_policy_document" "policy_document" {
  statement {
    actions   = ["s3:GetObject"]
    effect    = "Allow"
    resources = [aws_s3_bucket.bucket_website.arn, "${aws_s3_bucket.bucket_website.arn}/*"]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}

