variable "bucket_name" {
  description = "Nome do Bucket"
  type        = string
  default     = "default"
}

variable "bucket_acl" {
  description = "Tipo de ACL do Bucket"
  type        = string
  default     = "private"
}

variable "bucket_folder_structure" {
  description = "Estrutura de pastas do Bucket"
  type        = string
  default     = "folder/subfolder"
}

variable "lab" {
  description = "Proposito do laboratório"
  type        = string
  default     = "Criação de um bucket com uma estrutura de diretórios"
}
