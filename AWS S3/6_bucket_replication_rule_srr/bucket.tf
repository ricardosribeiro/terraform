# 1 - Create source bucket
resource "aws_s3_bucket" "bucket_source" {
  bucket        = var.bucket_source_name
  
  # 1.1 - Allow destroy bucket with versioning enabled
  force_destroy = true
  lifecycle {
    prevent_destroy = false
  }

  tags = {
    name = var.bucket_source_name
    lab  = var.lab
  }
}

# 2 - Create target bucket
resource "aws_s3_bucket" "bucket_target" {
  bucket        = var.bucket_target_name

  # 2.1 - Allow destroy bucket with versioning enabled
  force_destroy = true
  lifecycle {
    prevent_destroy = false
  }

  tags = {
    name = var.bucket_target_name
    lab  = var.lab
  }
}

# 3 - (Source) Enable bucket versioning
resource "aws_s3_bucket_versioning" "versioning_source" {
  bucket = aws_s3_bucket.bucket_source.id
  versioning_configuration {
    status = "Enabled"
  }
}

# 4 - (Target) Enable bucket versioning
resource "aws_s3_bucket_versioning" "versioning_target" {
  bucket = aws_s3_bucket.bucket_target.id
  versioning_configuration {
    status = "Enabled"
  }
}

# 5 - Create replication rule from source to target (Requerid bucket versioning enabled)
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

