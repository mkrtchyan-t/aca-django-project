# Terraform Settings Block
terraform {
  required_version = "~> 1.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.29"
    }
  }

}

# Terraform Provider Block
provider "aws" {
  region = var.aws_region
}
