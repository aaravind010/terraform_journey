resource "aws_vpc" "t_vpc" {
  cidr_block = var.VPC_CIDR
  enable_dns_hostnames = true
  tags = var.VPC_Tags
}

output "vpc_id" {
  value = aws_vpc.t_vpc.id
}