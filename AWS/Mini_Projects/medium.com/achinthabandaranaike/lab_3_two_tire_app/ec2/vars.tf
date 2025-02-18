variable "ami" {
  default = "ami-053a45fff0a704a47"
}

variable "instance_type" {
  default = "t2.medium"
}

variable "ec2_sg_id" {
  type = string
}

variable "pub_sub_1_id" {
  type = string
}

variable "pub_sub_2_id" {
  type = string
}


variable "vpc_id" {
  type = string
}