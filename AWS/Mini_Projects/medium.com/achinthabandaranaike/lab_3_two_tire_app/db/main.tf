resource "aws_db_instance" "main_db" {
  allocated_storage           = 5
  storage_type                = "gp2"
  engine                      = "mysql"
  engine_version              = "5.7"
  instance_class              = "db.t3.micro"
  vpc_security_group_ids      = [var.db_sg_id]
  db_subnet_group_name        = var.db_subnet_group_name
  parameter_group_name        = "default.mysql5.7"
  db_name                     = "main"
  username                    = "admin"
  password                    = "password"
  allow_major_version_upgrade = true
  auto_minor_version_upgrade  = true
  backup_retention_period     = 2
  multi_az                    = false
  skip_final_snapshot         = true
}