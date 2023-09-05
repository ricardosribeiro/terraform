# 1 - Create bucket
resource "aws_s3_bucket" "bucket_with_lifecycle" {
  bucket = var.bucket_name

  force_destroy = true

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    lab = var.lab
  }
}

# 2 - Create Lifecycle rule with transition configurations
# # 2.1 - Storage Classes: [GLACIER, STANDARD_IA, ONEZONE_IA, INTELLIGENT_TIERING, DEEP_ARCHIVE, GLACIER_IR]
resource "aws_s3_bucket_lifecycle_configuration" "lifecycle_config_it" {
  bucket = aws_s3_bucket.bucket_with_lifecycle.id

  rule {
    id     = "example-rule"
    status = "Enabled"

    # 2.2 - Move objects to Standard Infrequent Access after 30 days
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    # 2.3 - Move objects to Glacier after 90 days
    transition {
      days          = 90
      storage_class = "GLACIER"
    }

    # 2.4 - Move objects to Glacier Deep Archive after 180 days
    transition {
      days          = 180
      storage_class = "DEEP_ARCHIVE"
    }

    # 2.5 - Objects expires after 360 days
    expiration {
      days                         = 360
      expired_object_delete_marker = true
    }
  }
}
