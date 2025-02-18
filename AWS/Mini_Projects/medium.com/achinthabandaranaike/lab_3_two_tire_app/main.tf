module "vpc" {
  source            = "./network"
  vpc_id            = module.vpc.vpc_id
  alb_sg_id         = module.sg.alb_sg_id
  instance_id_web_1 = module.ec2.instance_id_web_1
  instance_id_web_2 = module.ec2.instance_id_web_2
}

module "sg" {
  source = "./security"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source       = "./ec2"
  vpc_id       = module.vpc.vpc_id
  ec2_sg_id    = module.sg.ec2_sg_id
  pub_sub_1_id = module.vpc.pub_sub_1_id
  pub_sub_2_id = module.vpc.pub_sub_2_id
}

module "db" {
  source               = "./db"
  db_sg_id             = module.sg.db_sg_id
  db_subnet_group_name = module.vpc.db_subnet_group_name
}