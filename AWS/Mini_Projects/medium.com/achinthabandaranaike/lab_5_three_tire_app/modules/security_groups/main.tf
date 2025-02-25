resource "aws_security_group" "bastion_sg" {
  vpc_id = var.vpc_id
  ingress {
    cidr_blocks = "0.0.0.0/0"
    protocol = "tcp"
    from_port = 22
    to_port = 22
    description = "Port 22 from Bastion SG"
  }
  egress {
    cidr_blocks = [ "0.0.0.0/0" ]
    protocol = "-1"
    from_port = 0
    to_port = 0
  }
}

resource "aws_security_group" "web_sg" {
  vpc_id = var.vpc_id
  ingress {
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 80
    to_port = 80
    protocol = "tcp"
    description = "HTTP connection"
  }
  ingress {
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 443
    to_port = 443
    protocol = "tcp"
    description = "HTTPS connection"
  }
  ingress {
    security_groups = [aws_security_group.bastion_sg.id]
    from_port = 22
    to_port = 22
    protocol = "tcp"
    description = "SSH Connection from Bastion host"
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port = 0
    protocol = "-1"
  }
}

resource "aws_security_group" "app_sg" {
  vpc_id = var.vpc_id
  ingress {
    security_groups = [aws_security_group.bastion_sg.id]
    from_port = 22
    to_port = 22
    protocol = "tcp"
    description = "SSH Connection from Bastion host"
  }
  ingress {
    security_groups = [aws_security_group.web_sg.id]
    from_port = 0
    to_port = 0
    protocol = "-1"
    description = "All traffic from web-sg"
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port = 0
    protocol = "-1"
  }
}

resource "aws_security_group" "db_sg" {
  vpc_id = var.vpc_id
  ingress {
    description = "SSH from Bastion host"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }
  ingress {
    description = "3306 from all the SG assoicated resouces"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    security_groups = [aws_security_group.app_sg.id, aws_security_group.web_sg.id, aws_security_group.bastion_sg.id]
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port = 0
    protocol = "-1"
  }
}

resource "aws_security_group" "alb_sg" {
  vpc_id = var.vpc_id
  ingress {
    protocol = "tcp"
    from_port = 80
    to_port = 80
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  ingress {
    protocol = "tcp"
    from_port = 443
    to_port = 443
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  egress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}

resource "aws_security_group" "app_alb_sg" {
  vpc_id = var.vpc_id
  ingress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    security_groups = [aws_security_group.web_sg.id]
  }
  egress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}