resource "aws_s3_bucket" "bucket_website" {
  bucket = var.bucket_name
  tags = {
    name = var.bucket_name
  }
}