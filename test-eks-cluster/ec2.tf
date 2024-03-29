resource "aws_instance" "ec2" {
  ami                         = "ami-052efd3df9dad4825"
  instance_type               = var.instance_type
  key_name                    = "${var.key_name}-keypair"
  security_groups             = ["${aws_security_group.public.id}"]
  subnet_id                   = aws_subnet.public.id
  associate_public_ip_address = true
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    "Name" = "${var.key_name}-ec2"
  }
}
