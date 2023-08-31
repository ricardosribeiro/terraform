variable "bucket_name" {
  description = " Nome do Bucket"
  type        = string
  default     = "default"
}

variable "aws_s3_bucket_arn" {
  description = "ARN do Bucket"
  type        = string
  default     = "default"
}

variable "lab" {
  description = "Proposito do laboratório"
  type        = string
  default     = "Criação de um bucket com acesso público"
}
