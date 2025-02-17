module "sg" {
  source = "../security"
}

module "nw" {
  source = "../network"
}

resource "aws_db_instance" "main_db" {
  allocated_storage = 5
  storage_type = "gp3"
  engine = "mysql"
  engine_version = "5.7"
  instance_class = "db.t2.micro"
  vpc_security_group_ids = [ module.sg.db_sg_id ]
  db_subnet_group_name = module.nw.db_subnet_group_name
  db_name = "main"
  username = "admin"
  password = "password"
  allow_major_version_upgrade = true
  auto_minor_version_upgrade = true
  backup_retention_period = 2
  multi_az = false
  skip_final_snapshot = true
}