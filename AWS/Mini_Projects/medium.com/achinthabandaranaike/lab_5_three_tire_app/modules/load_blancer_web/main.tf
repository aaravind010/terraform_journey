resource "aws_lb" "web_alb" {
  internal = false
  security_groups = [ var.alb_sg_id ]
  load_balancer_type = "application"
  subnets = [ var.public_subnet_1_id, var.public_subnet_2_id ]
  name = "web_alb"
  tags = {
    "Name" = "web_alb"
  }
}

resource "aws_lb_target_group" "web_alb_tg" {
  vpc_id = var.vpc_id
  port = 80
  protocol = "http"
  name = "web_alb_tg"
}

resource "aws_lb_listener" "web_alb_lis" {
  load_balancer_arn = aws_lb.web_alb.arn
  port = 80
  protocol = "http"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.web_alb_tg.arn
  }
}

resource "aws_autoscaling_attachment" "web_asg_attach" {
  autoscaling_group_name = var.asg_name
  lb_target_group_arn = aws_lb_target_group.web_alb_tg.arn
}