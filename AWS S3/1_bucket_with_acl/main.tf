terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      owner       = "Ricardo Carvalhaes Ribeiro",
      owner_email = "ricardo.sribeiro@outlook.com",
      purpose     = "Curso Terraform Udemy"
    }
  }
}

