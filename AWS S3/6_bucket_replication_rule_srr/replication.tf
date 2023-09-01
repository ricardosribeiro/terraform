resource "aws_s3_bucket_replication_configuration" "replication_rule" {
  depends_on = [aws_s3_bucket_versioning.versioning_source]

  role   = aws_iam_role.replication.arn
  bucket = aws_s3_bucket.bucket_source.id

  rule {
    status = "Enabled"
    destination {
      bucket        = aws_s3_bucket.bucket_target.arn
      storage_class = "STANDARD"
    }
  }
}
