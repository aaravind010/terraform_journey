resource "aws_internet_gateway" "aws_igw" {
  vpc_id = aws_vpc.t_vpc.id

  tags = {
    Name = "AWS IGW"
  }
}

output "aws_igw_id" {
  value = aws_internet_gateway.aws_igw.id
}