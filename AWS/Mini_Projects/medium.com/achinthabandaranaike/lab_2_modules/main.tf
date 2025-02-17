module "vpc" {
  source = "./vpc"
  vpc_id = module.vpc.vpc_id
}

module "sg" {
  source = "./security_groups"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source            = "./ec2"
  vpc_id            = module.vpc.vpc_id
  subnet_id         = module.vpc.pub_sub_id
  Security_group_id = module.sg.sg_id
}