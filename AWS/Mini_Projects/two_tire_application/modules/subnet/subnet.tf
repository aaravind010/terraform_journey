resource "aws_subnet" "public_subnet_1" {
  vpc_id = aws_vpc.t_vpc.id
  cidr_block = var.Public_Subnets_CIDR["pub_1"]
  availability_zone = var.Public_Subnets_AZ["pub_1"]
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet 1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id = aws_vpc.t_vpc.id
  cidr_block = var.Public_Subnets_CIDR["pub_2"]
  availability_zone = var.Public_Subnets_AZ["pub_2"]
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet 2"
  } 
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id = aws_vpc.t_vpc.id
  cidr_block = var.Private_Subnets_CIDR["pri_1"]
  availability_zone = var.Private_Subnets_AZ["pri_1"]
  
  tags = {
    Name = "Private Subnet 1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id = aws_vpc.t_vpc.id
  cidr_block = var.Private_Subnets_CIDR["pri_2"]
  availability_zone = var.Private_Subnets_AZ["pri_2"]
  
  tags = {
    Name = "Private Subnet 2"
  }
}

output "public_subnet_1_id" {
  value = aws_subnet.public_subnet_1.id
}

output "public_subnet_2_id" {
  value = aws_subnet.public_subnet_2.id
}

output "private_subnet_1_id" {
  value = aws_subnet.private_subnet_1.id
}

output "private_subnet_2_id" {
  value = aws_subnet.private_subnet_2.id
}

