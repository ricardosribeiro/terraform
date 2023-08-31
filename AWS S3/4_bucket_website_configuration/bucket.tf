# Create bucket
resource "aws_s3_bucket" "bucket_website" {
  bucket        = var.bucket_name
  force_destroy = true
  tags = {
    name = var.bucket_name
  }
}