variable "Public_Subnets_CIDR" {
  description = "Public subnet CIDR values"
  type = map(string)
  default = {
    "pub_1" = "192.168.1.0/24"
    "pub_2" = "192.196.2.0/24"
  }
}

variable "Public_Subnets_AZ" {
  description = "Public Subnet AZ"
  type = map(string)
  default = {
    "pub_1" = "us-east-1a"
    "pub_2" = "us-east-1b"
  }
}

variable "Private_Subnets_CIDR" {
  description = "Private subnet CIDR values"
  type = map(string)
  default = {
    "pri_1" = "192.168.3.0/24"
    "pri_2" = "192.196.4.0/24"
  }
}

variable "Private_Subnets_AZ" {
  description = "Private Subnet AZ"
  type = map(string)
  default = {
    "pri_1" = "us-east-1c"
    "pri_2" = "us-east-1d"
  }
}