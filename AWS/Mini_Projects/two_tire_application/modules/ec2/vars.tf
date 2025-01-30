variable "ec2_ami_type" {
  description = "EC2 AMI values"
  type        = map(string)
  default = {
    "pub" = "ami-01816d07b1128cd2d"
    "pri" = "ami-04b4f1a9cf54c11d0"
  }
}
variable "ec2_instance_type" {
  description = "EC2 instance types"
  type        = map(string)
  default = {
    "pub" = "t3.medium"
    "pri" = "t2.medium"
  }
}