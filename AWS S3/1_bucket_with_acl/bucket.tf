resource "aws_s3_bucket" "s3_bucket_with_acl" {
  bucket        = "ricardo-bucket-with-acl"
  force_destroy = true
  tags = {
    name = "ricardo-bucket-with-acl"
  }
}

resource "aws_s3_bucket_ownership_controls" "s3_bucket_with_controls" {
  bucket = aws_s3_bucket.s3_bucket_with_acl.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "img_s3_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.s3_bucket_with_controls]
  
  bucket = aws_s3_bucket.s3_bucket_with_acl.id
  acl    = "private"
}