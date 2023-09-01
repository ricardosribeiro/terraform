resource "aws_s3_bucket_versioning" "versioning_source" {
  bucket = aws_s3_bucket.bucket_source.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "versioning_target" {
  bucket = aws_s3_bucket.bucket_target.id
  versioning_configuration {
    status = "Enabled"
  }
}
