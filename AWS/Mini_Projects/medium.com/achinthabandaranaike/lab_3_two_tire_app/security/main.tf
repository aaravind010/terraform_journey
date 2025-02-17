module "vpc" {
  source = "../network"
  vpc_id = module.vpc.vpc_id
}

resource "aws_security_group" "ec2_sg" {
  vpc_id = module.vpc.vpc_id
  name = "ec2-sg"
  ingress {
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }
  ingress {
    security_groups = [ aws_security_group.alb_sg.id ]
    from_port = 80
    to_port = 80
    protocol = "tcp"
  }
  egress {
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 0
    to_port = 0
    protocol = -1
  }
}

resource "aws_security_group" "alb_sg" {
  vpc_id = module.vpc.vpc_id
  name = "alb_sg"
  ingress {
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 80
    to_port = 80
    protocol = "tcp"
  }
  egress {
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 0
    to_port = 0
    protocol = -1
  }
}

resource "aws_security_group" "db_sg" {
  vpc_id = module.vpc.vpc_id
  name = "db_sg"
  ingress {
    security_groups = [ aws_security_group.ec2_sg.id ]
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = [ aws_security_group.ec2_sg.id ]
  }
  egress {
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 0
    to_port = 0
    protocol = -1
  }
}