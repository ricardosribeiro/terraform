resource "aws_s3_bucket" "bucket_with_folders" {
  bucket        = var.bucket_name
  force_destroy = true
  tags = {
    lab  = var.lab
  }
}

resource "aws_s3_object" "bucket_folder" {
  bucket = aws_s3_bucket.bucket_with_folders.id

  key    = var.bucket_folder_structure
  acl    = var.bucket_acl
}
