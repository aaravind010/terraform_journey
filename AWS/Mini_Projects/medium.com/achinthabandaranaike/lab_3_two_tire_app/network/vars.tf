variable "vpc_cidr" {
  default = "192.168.0.0/16"
}

variable "vpc_id" {
  type = string
}

variable "pub_subnet" {
  type = map(string)
  default = {
    "pub_sub_1" = "192.168.1.0/24"
    "pub_sub_2" = "192.168.2.0/24"
  }
}

variable "pri_subnet" {
  type = map(string)
  default = {
    "pri_sub_1" = "192.168.3.0/24"
    "pri_sub_2" = "192.168.4.0/24"
  }
}