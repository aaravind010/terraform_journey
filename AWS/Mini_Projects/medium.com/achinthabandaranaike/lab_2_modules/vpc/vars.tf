variable "cidr" {
  default = "192.168.0.0/16"
}

variable "vpc_id" {
  type = string
}

variable "pub_sub" {
  default = "192.168.1.0/24"
}