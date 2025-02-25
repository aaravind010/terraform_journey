output "eip" {
  value = aws_eip.nat_eip.address
}

output "eip_allocation_id" {
  value = aws_eip.nat_eip.allocation_id
}