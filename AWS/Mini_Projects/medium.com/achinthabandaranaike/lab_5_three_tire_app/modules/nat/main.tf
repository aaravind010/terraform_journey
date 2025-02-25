resource "aws_nat_gateway" "nat_gw" {
  subnet_id = var.public_subnet_1_id
  allocation_id = var.eip_allocation_id
}