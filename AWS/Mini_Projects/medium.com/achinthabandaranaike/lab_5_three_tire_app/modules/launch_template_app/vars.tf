variable "ami" {
  default = "ami-053a45fff0a704a47"
}

variable "instance_type" {
  default = "t3.small"
}

variable "key_pair_name" {
  type = string
}

variable "app_sg_id" {
  type = string
}