resource "aws_subnet" "public_subnet_1" {
  vpc_id = var.vpc_id
  cidr_block = var.public_subnet["pub_sub_1"]
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    "Name" = "public_subnet_1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id = var.vpc_id
  cidr_block = var.public_subnet["pub_sub_2"]
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    "Name" = "public_subnet_2"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id = var.vpc_id
  cidr_block = var.private_subnet["pri_sub_1"]
  availability_zone = "us-east-1c"
  map_public_ip_on_launch = false

  tags = {
    "Name" = "private_subnet_1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id = var.vpc_id
  cidr_block = var.private_subnet["pri_sub_2"]
  availability_zone = "us-east-1d"
  map_public_ip_on_launch = false

  tags = {
    "Name" = "private_subnet_2"
  }
}

resource "aws_subnet" "private_subnet_3" {
  vpc_id = var.vpc_id
  cidr_block = var.private_subnet["pri_sub_3"]
  availability_zone = "us-east-1d"
  map_public_ip_on_launch = false

  tags = {
    "Name" = "private_subnet_3"
  }
}

resource "aws_subnet" "private_subnet_4" {
  vpc_id = var.vpc_id
  cidr_block = var.private_subnet["pri_sub_4"]
  availability_zone = "us-east-1e"
  map_public_ip_on_launch = false

  tags = {
    "Name" = "private_subnet_4"
  }
}