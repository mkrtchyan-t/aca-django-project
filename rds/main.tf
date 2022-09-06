provider "aws" {
  region = var.aws_region
}
##
# VPC
##
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name        = "my-vpc"
    Environment = var.environment
  }
}
##
# Subnet
##
resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "my-subnet"
  }
}
resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "my-subnet1"
  }
}
##
# Internet Gateway
##
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "my-igw"
  }
}
##
# Route Table
##
resource "aws_route_table" "route-table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "my-route-table"
  }
}
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.route-table.id
}
##
# Public Security Group
##
resource "aws_security_group" "public" {
  name        = "my-public-sg"
  description = "Public internet access"
  vpc_id      = aws_vpc.vpc.id
  tags = {
    Name      = "my-public-sg"
    Role      = "public"
    ManagedBy = "terraform"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group_rule" "public_in_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public.id
}
resource "aws_security_group_rule" "public_in_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public.id
}
resource "aws_security_group_rule" "postgres" {
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public.id
}
resource "tls_private_key" "aws-terraform-test-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "aws-terraform-key-pair" {
  key_name   = "aws-terraform-key"
  public_key = tls_private_key.aws-terraform-test-key.public_key_openssh
  provisioner "local-exec" { # Create "myKey.pem" to your computer!!
    command = "echo '${tls_private_key.aws-terraform-test-key.private_key_pem}' > ./aws-terraform-key.pem"
  }
}
##
# Instance
##
resource "aws_instance" "app_server" {
  ami           = var.ami
  instance_type = "t2.micro"
  subnet_id = aws_subnet.subnet.id
  security_groups             = ["${aws_security_group.public.id}"]
  associate_public_ip_address = true
  key_name = aws_key_pair.aws-terraform-key-pair.key_name
  tags = {
    Name = "ExampleAppServerInstance"
  }
}
