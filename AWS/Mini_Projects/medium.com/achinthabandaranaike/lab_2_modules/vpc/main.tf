resource "aws_vpc" "vpc_1" {
  cidr_block           = var.cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.vpc_1.id
  cidr_block              = var.pub_sub
  map_public_ip_on_launch = true
  tags = {
    "Name" = "Pub Sub "
  }
}