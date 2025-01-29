output "Subnet_name" {
  value = aws_subnet.arima_private_subnet_1.tags
}

output "ec2_public_ip" {
  value = aws_instance.tera_inst.public_ip
}