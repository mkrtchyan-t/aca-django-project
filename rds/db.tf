resource "aws_db_subnet_group" "website" {
  name       = "db_subnet"
  subnet_ids = [aws_subnet.subnet.id, aws_subnet.subnet1.id]
  tags = {
    Name = "My DB subnet group"
  }
}
resource "aws_db_parameter_group" "website" {
  name   = "website"
  family = "postgres11"
  parameter {
    name  = "log_connections"
    value = "1"
  }
}
resource "aws_db_instance" "website" {
  identifier             = "website"
  db_name                = "websitedb"
  instance_class         = "db.t2.micro"
  allocated_storage      = 20
  engine                 = "postgres"
  engine_version         = "11.16"
  username               = "django"
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.website.name
  vpc_security_group_ids = [aws_security_group.public.id]
  parameter_group_name   = aws_db_parameter_group.website.name
  publicly_accessible    = true
  skip_final_snapshot    = true
}













