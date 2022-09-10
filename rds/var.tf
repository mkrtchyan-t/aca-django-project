variable "aws_region" {
  default     = "us-east-1"
  description = "aws region"
}
variable "ami" {
  default     = "ami-052efd3df9dad4825"
  description = "ami ID"
}
variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "cidr for vpc"
}
variable "environment" {
  default = "My"
}
variable "db_password" {
  description = "RDS root user password"
  type        = string
  sensitive   = true
}












