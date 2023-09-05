# 5 - Create IAM policy document as data source
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

