output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "pub_sub_1_id" {
  value = aws_subnet.pub_sub_1.id
}

output "pub_sub_2_id" {
  value = aws_subnet.pub_sub_2.id
}

output "pri_sub_1_id" {
  value = aws_subnet.pri_sub_1.id
}

output "pri_sub_2_id" {
  value = aws_subnet.pri_sub_2.id
}

output "eip_ip" {
  value = aws_eip.eip.public_ip
}

output "pub_rt_1_id" {
  value = aws_route_table.pub_rt_1.id
}

output "pub_rt_2_id" {
  value = aws_route_table.pub_rt_2.id
}

output "pri_rt_1_id" {
  value = aws_route_table.pri_rt_1.id
}

output "pri_rt_2_id" {
  value = aws_route_table.pri_rt_2.id
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.db_subnet_group.name
}