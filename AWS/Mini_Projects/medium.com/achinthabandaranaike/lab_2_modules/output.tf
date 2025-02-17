output "pub_ip" {
  value = module.ec2.public_ip
}

output "sub_id" {
  value = module.vpc.pub_sub_id
}