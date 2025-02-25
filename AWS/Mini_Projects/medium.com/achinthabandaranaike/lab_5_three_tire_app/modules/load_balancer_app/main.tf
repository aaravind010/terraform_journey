resource "aws_lb" "app_alb" {
    internal = true
    name = "app_alb"
    load_balancer_type = "application"
    security_groups = [ var.app_alb_sg_id ]
    subnets = [ var.private_subnet_1_id, var.private_subnet_2_id ]
}