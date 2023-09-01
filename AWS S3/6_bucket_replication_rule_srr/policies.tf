data "aws_iam_policy_document" "replication" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetReplicationConfiguration",
      "s3:ListBucket"
    ]
    resources = [aws_s3_bucket.bucket_source.arn, "${aws_s3_bucket.bucket_source.arn}/*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:GetObjectVersionForReplication",
      "s3:GetObjectVersionAcl",
      "s3:GetObjectVersionTagging"
    ]
    resources = [aws_s3_bucket.bucket_source.arn, "${aws_s3_bucket.bucket_source.arn}/*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:ReplicateObject",
      "s3:ReplicateDelete",
      "s3:ReplicateTags",
    ]
    resources = [aws_s3_bucket.bucket_target.arn, "${aws_s3_bucket.bucket_target.arn}/*"]
  }
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_policy" "replication" {
  name   = "ricardocr-iam-policy-replication"
  policy = data.aws_iam_policy_document.replication.json
}

resource "aws_iam_role" "replication" {
  name               = "ricardocr-iam-role-replication"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "replication" {
  role       = aws_iam_role.replication.name
  policy_arn = aws_iam_policy.replication.arn
}

# resource "aws_s3_bucket_acl" "replication" {
#   bucket = aws_s3_bucket.bucket_source.id
#   acl = "private"
# }