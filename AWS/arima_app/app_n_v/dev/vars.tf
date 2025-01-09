variable "arima_vpc_cidr" {
  description = "CIDR value for arima app VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "arima_public_subnet_1" {
  description = "CIDR value for public subnet"
  type        = string
  default     = "10.0.1.0/24"

}

variable "arima_public_subnet_2" {
  description = "CIDR value for public subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "arima_private_subnet_1" {
  description = "CIDE value for private subnet"
  type        = string
  default     = "us-east-1c"
}

variable "arima_private_subnet_2" {
  description = "CIDE value for private subnet"
  type        = string
  default     = "us-east-1d"
}

variable "arima_public_subnet_az_1" {
  description = "Public subnet AZs"
  type        = string
  default     = "us-east-1a"
}

variable "arima_public_subnet_az_2" {
  description = "Public subnet AZs"
  type        = string
  default     = "us-east-1b"
}

variable "arima_private_subnet_az_1" {
  description = "Private subnet AZs"
  type        = string
  default     = "us-east-1c"
}

variable "arima_private_subnet_az_2" {
  description = "Private subnet AZs"
  type        = string
  default     = "us-east-1d"
}