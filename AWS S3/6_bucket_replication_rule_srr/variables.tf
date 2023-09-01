variable "bucket_source_name" {
  description = "Nome do bucket de origem"
  type        = string
  default     = "default"
}

variable "bucket_target_name" {
  description = "Nome do bucket de destino"
  type        = string
  default     = "default"
}

variable "lab" {
  description = "Proposito do laboratório"
  type        = string
  default     = "Criação de dois bucket com Replication Rule"
}