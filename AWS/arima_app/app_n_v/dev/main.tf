resource "aws_vpc" "arima_vpc" {
  cidr_block = var.arima_vpc_cidr
  tags = {
    Name = "Arima VPC DEV"
  }
}

resource "aws_subnet" "arima_public_subnet_1" {
  vpc_id                  = aws_vpc.arima_vpc.id
  cidr_block              = var.arima_public_subnet_1
  availability_zone       = var.arima_public_subnet_az_1
  map_public_ip_on_launch = true
  tags = {
    Name = "Public Subnet 1"
  }
}

resource "aws_subnet" "arima_public_subnet_2" {
  vpc_id                  = aws_vpc.arima_vpc.id
  cidr_block              = var.arima_public_subnet_2
  availability_zone       = var.arima_public_subnet_az_2
  map_public_ip_on_launch = true
  tags = {
    Name = "Public Subnet 2"
  }
}

resource "aws_internet_gateway" "arima_IGW" {
  vpc_id = aws_vpc.arima_vpc.id
  tags = {
    Name = "Arima IGW"
  }
}

resource "aws_route_table" "arima_public_rt_1" {
  vpc_id = aws_vpc.arima_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.arima_IGW.id
  }
}

resource "aws_route_table_association" "public_rt_1_association" {
  route_table_id = aws_route_table.arima_public_rt_1.id
  subnet_id      = aws_subnet.arima_public_subnet_1.id
}


resource "aws_subnet" "arima_private_subnet_1" {
  vpc_id            = aws_vpc.arima_vpc.id
  cidr_block        = var.arima_private_subnet_1
  availability_zone = var.arima_private_subnet_az_1
  tags = {
    Name = "Private Subnet 1"
  }
}

resource "aws_subnet" "arima_private_subnet_2" {
  vpc_id            = aws_vpc.arima_vpc.id
  cidr_block        = var.arima_private_subnet_2
  availability_zone = var.arima_private_subnet_az_2
  tags = {
    Name = "Private Subnet 2"
  }
}

resource "aws_eip" "arima_eip_nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "arima_nat_gw" {
  subnet_id     = aws_subnet.arima_public_subnet_1.id
  allocation_id = aws_eip.arima_eip_nat.id

  tags = {
    Name = "Arima NAT GW"
  }
}
resource "aws_route_table" "arima_private_rt_1" {
  vpc_id = aws_vpc.arima_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.arima_nat_gw.id
  }
}

resource "aws_route_table_association" "private_rt_1_association" {
  route_table_id = aws_route_table.arima_private_rt_1.id
  subnet_id      = aws_subnet.arima_private_subnet_1.id
}
