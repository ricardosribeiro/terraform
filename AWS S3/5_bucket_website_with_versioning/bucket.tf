resource "aws_s3_bucket" "bucket_website" {
  bucket = var.bucket_name

  # Permite destruir bucket mesmo com versionamento habilitado
  force_destroy = true
  lifecycle {
    prevent_destroy = false
  }
  
  tags = {
    name = var.bucket_name
    lab  = var.lab
  }
}
