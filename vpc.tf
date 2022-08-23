resource "aws_vpc" "vpc" {
	cidr_block = "${var.vpc-cidr}"
	enable_dns_hostnames = true
	tags = {
		Name = "${var.key_name}-vpc"
	}
}

resource "aws_subnet" "public-subnet" {
	vpc_id = aws_vpc.vpc.id
	cidr_block = "${var.public-subnet}"
	availability_zone = "us-east-1a"
	map_public_ip_on_launch = true
	tags = {
		Name = "${var.key_name}-subnet"
	}
}

resource "aws_internet_gateway" "internet-gateway" {
	vpc_id = aws_vpc.vpc.id
	tags = {
		Name = "${var.key_name}-ig"
	}
}

resource "aws_route_table" "public-route-table" {
	vpc_id = aws_vpc.vpc.id
	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = aws_internet_gateway.internet-gateway.id
	}
	tags = {
		Name = "${var.key_name}-rt"
	}
}

resource "aws_route_table_association" "subnet-route-table-association" {
	subnet_id = aws_subnet.public-subnet.id
	route_table_id = aws_route_table.public-route-table.id
}
