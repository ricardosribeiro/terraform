resource "aws_s3_bucket" "bucket_with_folders" {
  bucket = var.bucket_name
  force_destroy = true
  tags = {
    name = var.bucket_name
  }
}

resource "aws_s3_object" "bucket_folder" {
  bucket = aws_s3_bucket.bucket_with_folders.id
  key = "folder/subfolder"
  acl = "private"
}