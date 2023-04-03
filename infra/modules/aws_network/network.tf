#____________________________________________Create VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.environment_name}-VPC"
  }
}

#____________________________________________Internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.environment_name}-Internet-Gateway"
  }
}

#____________________________________________Public
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  count             = length(var.zones)
  cidr_block        = cidrsubnet(var.vpc_cidr, 3, count.index * 2)
  availability_zone = element(var.zones, count.index)

  tags = {
    Name = "${var.environment_name}-Public-Subnet"
  }
}

#____________________________________________Private
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  count             = length(var.zones)
  cidr_block        = cidrsubnet(var.vpc_cidr, 3, count.index * 2 + 1)
  availability_zone = element(var.zones, count.index)

  tags = {
    Name = "${var.environment_name}-Private-Subnet"
  }
}
