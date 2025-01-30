variable "VPC_CIDR" {
  description = "VPC CIDR block value"
  type = string
  default = "192.168.0.0/16"
}

variable "VPC_Tags" {
  description = "VPC tag values"
  type = map(string)
  default = {
    "Name" = "T_VPC"
  }
}