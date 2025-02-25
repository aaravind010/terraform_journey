resource "aws_autoscaling_group" "app_asg" {
  name = "app_asg"
  launch_template {
    id = var.app_lt_id
  }
  vpc_zone_identifier = [ var.private_subnet_1_id, var.private_subnet_2_id ]
  min_size = 2
  max_size = 3
  desired_capacity = 2
}