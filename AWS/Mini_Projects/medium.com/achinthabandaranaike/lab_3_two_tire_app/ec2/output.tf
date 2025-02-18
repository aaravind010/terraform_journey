output "instance_id_web_1" {
  value = aws_instance.web_1.id
}

output "instance_id_web_2" {
  value = aws_instance.web_2.id
}

output "web_1_pubic_ip" {
  value = aws_instance.web_1.public_ip
}

output "web_2_pubic_ip" {
  value = aws_instance.web_2.public_ip
}