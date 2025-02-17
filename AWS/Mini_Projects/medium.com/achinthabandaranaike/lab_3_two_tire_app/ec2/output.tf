output "instance_id" {
  value = aws_instance.web_1.id
}

output "web_1_pubic_ip" {
  value = aws_instance.web_1.public_ip
}

output "web_2_pubic_ip" {
  value = aws_instance.web_2.public_ip
}