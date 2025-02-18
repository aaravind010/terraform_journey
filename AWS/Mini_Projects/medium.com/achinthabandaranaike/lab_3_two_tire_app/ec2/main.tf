resource "aws_instance" "web_1" {
  ami             = var.ami
  instance_type   = var.instance_type
  security_groups = [var.ec2_sg_id]
  subnet_id       = var.pub_sub_1_id
  user_data       = <<EOF
  #!/bin/bash
  sudo yum update -y
  sudo amazon-linux-extras install nginx1 -y 
  sudo systemctl enable nginx
  sudo systemctl start nginx
  EOF
}

resource "aws_instance" "web_2" {
  ami             = var.ami
  instance_type   = var.instance_type
  security_groups = [var.ec2_sg_id]
  subnet_id       = var.pub_sub_2_id
  user_data       = <<EOF
  #!/bin/bash
  sudo yum update -y
  sudo amazon-linux-extras install nginx1 -y 
  sudo systemctl enable nginx
  sudo systemctl start nginx
  EOF
}