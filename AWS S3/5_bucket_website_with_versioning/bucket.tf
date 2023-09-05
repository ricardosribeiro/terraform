# 1 - Create bucket
resource "aws_s3_bucket" "bucket_website" {
  bucket = var.bucket_name

# 1.1 - Allow destroy bucket with versioning enabled
  force_destroy = true
  lifecycle {
    prevent_destroy = false
  }
  
  tags = {
    name = var.bucket_name
    lab  = var.lab
  }
}

# 2 - Disable ACLs
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.bucket_website.id

  block_public_acls       = false
  block_public_policy     = false
  restrict_public_buckets = false
  ignore_public_acls      = false
}

# 3 - Create bucket policy
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket_website.id
  # # 3.1 - Get policy documents from data souce
  policy = data.aws_iam_policy_document.policy_document.json
}

# 4 - Enable e configure website hosting
resource "aws_s3_bucket_website_configuration" "website_configuration" {
  bucket = aws_s3_bucket.bucket_website.id
  
  # # 4.1 - Define name of index website
  index_document {
    suffix = "index.html"
  }
  # # 4.2 - Define name of erro page
  error_document {
    key = "error.html"
  }
}

