# Enable WebSite hosting configuration
resource "aws_s3_bucket_website_configuration" "website_configuration" {
  bucket = aws_s3_bucket.bucket_website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}
