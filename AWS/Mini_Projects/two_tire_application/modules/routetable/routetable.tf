resource "aws_route_table" "public_rt_1" {
  vpc_id = aws_vpc.t_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aws_igw.id
  }

  tags =  {
    Name = "Public Route Table 1"
  }
}

resource "aws_route_table" "private_rt_1" {
  vpc_id = aws_vpc.t_vpc.id
  
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.t_nat.id
  }

  tags = {
    Name = "Private Route Table 1"
  }
}

resource "aws_route_table_association" "public_rt_sub_1_association" {
  route_table_id = aws_route_table.public_rt_1.id
  subnet_id = aws_subnet.public_subnet_1.id
}

resource "aws_route_table_association" "public_rt_sub_2_association" {
  route_table_id = aws_route_table.public_rt_1.id
  subnet_id = aws_subnet.public_subnet_2.id
}

resource "aws_route_table_association" "private_rt_1_associateion" {
  route_table_id = aws_route_table.private_rt_1.id
  subnet_id = aws_subnet.private_subnet_1.id
}