# Terraform Settings Block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.15"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.5"
    }
  }

}

# Terraform AWS Provider Block
provider "aws" {
  region = var.aws_region
}

