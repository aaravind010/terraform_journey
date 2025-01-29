variable "arima_vpc_cidr" {
  description = "CIDR value for arima app VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "arima_public_subnet" {
  description = "CIDR value for Public subnets"
  type        = map(string)
  default = {
    "pub_1" = "10.0.1.0/24"
    "pub_2" = "10.0.2.0/24"
  }
}

variable "arima_private_subnet" {
  description = "CIDR value for private subnet"
  type        = map(string)
  default = {
    "pri_1" = "10.0.3.0/24"
    "pri_2" = "10.0.4.0/24"
  }
}

variable "arima_public_azs" {
  description = "AZ for public subnet"
  type        = map(string)
  default = {
    "pub_1" = "us-east-1a"
    "pub_2" = "us-east-2a"
  }
}

variable "arima_private_azs" {
  description = "AZ for private subnet"
  type        = map(string)
  default = {
    "pri_1" = "us-east-1c"
    "pri_2" = "us-east-1d"
  }
}


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