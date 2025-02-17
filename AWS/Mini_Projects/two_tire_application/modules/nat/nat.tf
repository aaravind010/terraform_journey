module "subnet" {
  source = "../subnet"
}

module "eip" {
  source = "../eip"
}

resource "aws_nat_gateway" "t_nat" {
  subnet_id = module.subnet.public_subnet_1_id
  allocation_id = module.eip.eip_id

  tags = {
    Name = "T NAT"
  }
}

output "nat_id" {
  value = aws_nat_gateway.t_nat.id
}