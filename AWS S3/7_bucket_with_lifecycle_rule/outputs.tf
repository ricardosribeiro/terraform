output "bucket_arn" {
  value = aws_s3_bucket.bucket_with_lifecycle.arn
}

output "bucket_id" {
  value = aws_s3_bucket.bucket_with_lifecycle.id
}
