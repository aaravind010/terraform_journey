resource "aws_nat_gateway" "t_nat" {
  subnet_id = aws_subnet.public_subnet_1.id
  allocation_id = aws_eip.t_eip.id

  tags = {
    Name = "T NAT"
  }
}