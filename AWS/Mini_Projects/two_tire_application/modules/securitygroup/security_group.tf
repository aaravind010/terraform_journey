module "vpc_id" {
  source = "../vpc"
}

resource "aws_security_group" "alb_sg" {
  vpc_id = module.vpc_id.vpc_id
  ingress {
    description = "Port 80"
    protocol = "tcp"
    from_port = 80
    to_port = 80
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  egress {
    description = "Outbound rule"
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 0
    to_port = 0
    protocol = -1
  }
  tags = {
    Name = "ALB SG"
  }
}

resource "aws_security_group" "bastion_sg" {
  vpc_id = aws_vpc.t_vpc.id
  ingress {
    description = "Port 22"
    protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  ingress {
    description = "Port 80"
    protocol = "tcp"
    from_port = 80
    to_port = 80
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  egress {
    description = "Outbound rule"
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 0
    to_port = 0
    protocol = -1
  }
  tags = {
    Name = "Bastion SG"
  }
}

resource "aws_security_group" "rds_sg" {
  vpc_id = aws_vpc.t_vpc.id
  ingress {
    description = "3306 from bastion only"
    protocol = "tcp"
    from_port = 3306
    to_port = 3306
    security_groups = [ aws_security_group.bastion_sg.id ]
  }
  egress {
    description = "Outbound rule"
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 0
    to_port = 0
    protocol = -1
  }
  tags = {
    Name = "RDS SG"
  }
}

output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}

output "bastion_sg_id" {
  value = aws_security_group.bastion_sg.id
}

output "rds_sg_id" {
  value = aws_security_group.rds_sg.id
}