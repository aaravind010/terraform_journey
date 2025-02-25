resource "aws_route_table" "web_public_rt_1" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }
  tags = {
    "Name" = "web_public_rt_1"
  }
}

resource "aws_route_table" "app_private_rt_1" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = var.nat_id
  }
  tags = {
    "Name" = "app_private_rt_1"
  }
}

resource "aws_route_table_association" "web_public_rt_1_asso_1" {
  route_table_id = aws_route_table.web_public_rt_1.id
  subnet_id = var.public_subnet_1_id
}

resource "aws_route_table_association" "web_public_rt_1_asso_2" {
  route_table_id = aws_route_table.web_public_rt_1.id
  subnet_id = var.public_subnet_2_id
}

resource "aws_route_table_association" "app_private_rt_1_asso_1" {
  route_table_id = aws_route_table.app_private_rt_1.id
  subnet_id = var.private_subnet_1_id
}

resource "aws_route_table_association" "app_private_rt_1_asso_2" {
  route_table_id = aws_route_table.app_private_rt_1.id
  subnet_id = var.private_subnet_2_id
}

resource "aws_route_table_association" "app_private_rt_1_asso_3" {
  route_table_id = aws_route_table.app_private_rt_1.id
  subnet_id = var.private_subnet_3_id
}

resource "aws_route_table_association" "app_private_rt_1_asso_4" {
  route_table_id = aws_route_table.app_private_rt_1.id
  subnet_id = var.private_subnet_4_id
}