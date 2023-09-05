# 1 - Create policy document with requerid actions to replication
data "aws_iam_policy_document" "replication" {
  # 1.1 - Allow source bucket to replicate
  statement {
    effect = "Allow"
    actions = [
      "s3:GetReplicationConfiguration",
      "s3:ListBucket",
      "s3:GetObjectVersionForReplication",
      "s3:GetObjectVersionAcl",
      "s3:GetObjectVersionTagging"
    ]
    resources = [aws_s3_bucket.bucket_source.arn, "${aws_s3_bucket.bucket_source.arn}/*"]
  }

  # 1.2 - Allow target bucket to replicate
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

# 2 - Create AssumeRole policy document
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

# 3 - Create IAM policy with replication permissions
resource "aws_iam_policy" "replication" {
  name   = "ricardocr-iam-policy-replication"
  policy = data.aws_iam_policy_document.replication.json
}

# 4 - Create role with AssumeRole permissions
resource "aws_iam_role" "replication" {
  name               = "ricardocr-iam-role-replication"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# 5 - Attach policy replication permissions to role
resource "aws_iam_role_policy_attachment" "replication" {
  role       = aws_iam_role.replication.name
  policy_arn = aws_iam_policy.replication.arn
}

