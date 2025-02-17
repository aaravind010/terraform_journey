module "vpc" {
  source = "../vpc"
}

module "igw" {
  source = "../igw"
}

module "nat" {
  source = "../nat"
}

module "subnet" {
  source = "../subnet"
}


resource "aws_route_table" "public_rt_1" {
  vpc_id = module.vpc.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = module.igw.aws_igw_id
  }

  tags =  {
    Name = "Public Route Table 1"
  }
}

resource "aws_route_table" "private_rt_1" {
  vpc_id = module.vpc.vpc_id
  
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = module.nat.nat_id
  }

  tags = {
    Name = "Private Route Table 1"
  }
}

resource "aws_route_table_association" "public_rt_sub_1_association" {
  route_table_id = aws_route_table.public_rt_1.id
  subnet_id = module.subnet.public_subnet_1_id
}

resource "aws_route_table_association" "public_rt_sub_2_association" {
  route_table_id = aws_route_table.public_rt_1.id
  subnet_id = module.subnet.public_subnet_2_id
}

resource "aws_route_table_association" "private_rt_1_associateion" {
  route_table_id = aws_route_table.private_rt_1.id
  subnet_id = module.subnet.private_subnet_1_id
}