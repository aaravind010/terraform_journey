variable "vpc_id" {
  type = string
}

variable "public_subnet" {
    type = map(string)
    default = {
      "pub_sub_1" = "10.0.1.0/24"
      "pub_sub_2" = "10.0.2.0/24"
    }
}

variable "private_subnet" {
  type = map(string)
  default = {
    "pri_sub_1" = "10.0.3.0/24"
    "pri_sub_2" = "10.0.4.0/24"
    "pri_sub_3" = "10.0.5.0/24"
    "pri_sub_4" = "10.0.6.0/24"
  }
}