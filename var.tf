variable "region" {
  description = "instance region"
  default     = "us-east-1"
}

variable "cluster" {
  description = "Name of eks cluster"
  default     = "django-cluster"
}

variable "cluster_version" {
  description = "cluster kube version"
  default     = "1.22"
}

variable "cidr" {
  description = "vpc cidr_block"
  default     = "10.0.0.0/16"
}

variable "public-subnet" {
  default     = "10.0.0.0/24"
  description = "public-subnet"
}

variable "ssh-location" {
  default     = "0.0.0.0/0"
  description = "SSH variable"
}

variable "instance_type" {
  default = "t2.large"
}

variable "key_name" {
  default = "aca-django"
}
