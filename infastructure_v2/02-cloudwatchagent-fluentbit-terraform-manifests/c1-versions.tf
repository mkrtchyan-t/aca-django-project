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
    http = {
      source  = "hashicorp/http"
      version = "~> 2.1"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }
  }

}

