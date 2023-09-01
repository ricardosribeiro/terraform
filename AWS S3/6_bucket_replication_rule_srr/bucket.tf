resource "aws_s3_bucket" "bucket_source" {
  bucket        = var.bucket_source_name
  force_destroy = true
  lifecycle {
    prevent_destroy = false
  }

  tags = {
    name = var.bucket_source_name
    lab  = var.lab
  }
}

resource "aws_s3_bucket" "bucket_target" {
  bucket        = var.bucket_target_name
  force_destroy = true
  lifecycle {
    prevent_destroy = false
  }
  tags = {
    name = var.bucket_target_name
    lab  = var.lab
  }
}
