output "vpc_id" {
  value = aws_vpc.vpc_1.id
}

output "pub_sub_id" {
  value = aws_subnet.public.id
}