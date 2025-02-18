output "web_1_public_ip" {
  value = module.ec2.web_1_pubic_ip
}

output "web_2_public_ip" {
  value = module.ec2.web_2_pubic_ip
}

output "db_endpoint" {
  value = module.db.endpoint
}