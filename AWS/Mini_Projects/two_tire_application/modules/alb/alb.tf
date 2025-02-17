module "vpc" {
  source = "../vpc"
}

module "security_groups" {
  source = "../securitygroup"
}

resource "aws_lb_target_group" "alb_tg_1" {
  name = "target-group-1"
  port = 80
  protocol = "HTTP"
  vpc_id = module.vpc.vpc_id
}

resource "aws_lb_target_group_attachment" "alb_tg_attach" {
  target_group_arn = aws_lb_target_group.alb_tg_1.arn
  target_id = [aws_instance.bastion_web_2.id, aws_instance.bastion_web_1.id]
}

resource "aws_lb" "aws-alb" {
  name = "aws_alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [ module.security_groups.alb_sg_id ]
}

resource "aws_lb_listener" "alb_listioner" {
  load_balancer_arn = aws_lb.aws-alb.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.alb_tg_1.arn
  }
}