variable "ami" {
  default = "ami-053a45fff0a704a47"
}

variable "instance_type" {
  default = "t2.medium"
}

variable "vpc_id" {
  type = string
}

variable "Security_group_id" {
  type = string
}

variable "subnet_id" {
  type = string
}