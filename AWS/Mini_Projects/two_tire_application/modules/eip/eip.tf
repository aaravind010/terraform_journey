resource "aws_eip" "t_eip" {
  domain = "vpc"
}

output "eip_id" {
  value = aws_eip.t_eip.id
}