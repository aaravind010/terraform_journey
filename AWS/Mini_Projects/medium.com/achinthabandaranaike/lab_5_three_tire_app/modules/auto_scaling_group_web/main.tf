resource "aws_autoscaling_group" "web_asg" {
  launch_template {
    id = var.lt_id
  }
  min_size = 2
  max_size = 3
  desired_capacity = 2
  vpc_zone_identifier = [ var.public_subnet_1_id, var.public_subnet_2_id ]
  name = "web_asg"
}