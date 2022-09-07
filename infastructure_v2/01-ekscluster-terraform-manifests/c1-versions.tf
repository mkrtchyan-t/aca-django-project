# Terraform Settings Block
terraform {
  required_version = "~> 1.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.29"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.13"
    }
  }

}

# Terraform Provider Block
provider "aws" {
  region = var.aws_region
}
