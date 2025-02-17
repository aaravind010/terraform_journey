module "subnet" {
  source = "../subnet"
}

module "securitygroup" {
  source = "../securitygroup"
}

resource "aws_db_instance" "t_db_1" {
  instance_class = "db.t3.micro"
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "5.7"
  username             = "admin"
  password             = "password"
  parameter_group_name = "default.mysql5.7"
  db_subnet_group_name = module.subnet.private_subnet_1_id
  vpc_security_group_ids = [ module.securitygroup.rds_sg_id ]
  skip_final_snapshot  = true
}