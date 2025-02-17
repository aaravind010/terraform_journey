module "sg" {
  source = "../security"
}

module "ec2" {
  source = "../ec2"
}

# VPC 
resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    "Name" = main_vpc
  }
}

# PUBLIC SUBNET 
resource "aws_subnet" "pub_sub_1" {
 vpc_id = aws_vpc.main_vpc.id
 cidr_block = var.pub_subnet["pub_sub_1"]
 map_public_ip_on_launch = true
 availability_zone = "us-east-1a"

 tags = {
   "Name" = pub_sub_1
 }
}

resource "aws_subnet" "pub_sub_2" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.pub_subnet["pub_sub_2"]
  map_public_ip_on_launch = true
  availability_zone = "us-east-1b"

  tags = {
    "Name" = pub_sub_2
  }
}

# PRIVATE SUBNET
resource "aws_subnet" "pri_sub_1" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.pri_subnet["pri_sub_1"]
  map_public_ip_on_launch = false
  availability_zone = "us-east-1a"

  tags = {
    "Name" = pri_sub_1
  }
}

resource "aws_subnet" "pri_sub_2" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.pri_subnet["pri_sub_2"]
  map_public_ip_on_launch = false
  availability_zone = "us-east-1b"

  tags = {
    "Name" = pri_sub_2
  }
}

# INTERNET GATEWAY
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    "Name" = internet_gateway
  }
}

# EIP
resource "aws_eip" "eip" {
  domain = "vpc"
}

# NAT GATEWAY
resource "aws_nat_gateway" "ngw" {
  subnet_id = aws_subnet.pub_sub_1.id
}

# PUBLIC ROUTE TABLE
resource "aws_route_table" "pub_rt_1" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    "Name" = pub_rt_1
  }
}

resource "aws_route_table" "pub_rt_2" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    "Name" = pub_rt_2
  }
}

# PUBLIC ROUTE TABLE ASSOCIATION
resource "aws_route_table_association" "pub_rt_1_ass" {
  route_table_id = aws_route_table.pub_rt_1.id
  subnet_id = aws_subnet.pub_sub_1
}

resource "aws_route_table_association" "pub_rt_2_ass" {
  route_table_id = aws_route_table.pub_rt_2.id
  subnet_id = aws_subnet.pub_sub_2.id
}

# PRIVATE ROUTE TABLE
resource "aws_route_table" "pri_rt_1" {
  vpc_id = aws_vpc.main_vpc.id
  route {
     cidr_block = "0.0.0.0/0"
     nat_gateway_id = aws_nat_gateway.ngw.id
  }
  tags = {
    "Name" = pri_rt_1
  }
}

resource "aws_route_table" "pri_rt_2" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    "Name" = pri_rt_2
  }
}

# PRIVATE ROUTE TABLE ASSOCIATION
resource "aws_route_table_association" "pri_rt_1_ass" {
  route_table_id = aws_route_table.pri_rt_1.id
  subnet_id = aws_subnet.pri_sub_1.id
}

resource "aws_route_table_association" "pri_rt_2_ass" {
  route_table_id = aws_route_table.pri_rt_2.id
  subnet_id = aws_subnet.pri_sub_2.id
}

# APPLICAITON LOAD BALANCER
resource "aws_lb" "pub_alb" {
  name = "main_alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [module.sg.alb_sg_id]
  subnets = [ aws_subnet.pub_sub_1.id, aws_subnet.pub_sub_2.id ]
}


resource "aws_lb_target_group" "pub_alb_tg_1" {
  name = "target"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.main_vpc.id
}

resource "aws_lb_target_group_attachment" "pub_alb_tg_1_att" {
  target_group_arn = aws_lb_target_group.pub_alb_tg_1.arn
  target_id = module.ec2.instance_id
  port = 80
}

resource "aws_lb_listener" "pub_alb_list" {
  load_balancer_arn = aws_lb.pub_alb.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.pub_alb_tg_1.arn
  }
}

# RDS SUBNET GROUP
resource "aws_db_subnet_group" "db_subnet_group" {
  subnet_ids = [ aws_subnet.pri_sub_1.id, aws_subnet.pri_sub_2.id ]
  name = "db_subnet_group"
}