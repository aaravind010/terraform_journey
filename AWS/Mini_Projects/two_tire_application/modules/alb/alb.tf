resource "aws_alb" "t_alb" {
  internal = false
  security_groups = [ aws_security_group.alb_sg.id ]
  subnets = [ aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id ] 
}

