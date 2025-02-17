module "vpc" {
  source = "./modules/vpc"
}

module "subnet" {
  source = "./modules/subnet"
}

module "security_groups" {
  source = "./modules/securitygroup"
}

module "route_table" {
  source = "./modules/routetable"
}

module "igw" {
  source = "./modules/igw"
}

module "eip" {
  source = "./modules/eip"
}

module "nat" {
  source = "./modules/nat"
}

module "key_pair" {
  source = "./modules/key_pair"
}

module "ec2" {
  source = "./modules/ec2"
}

module "alb" {
  source = "./modules/alb"
}

module "rds" {
  source = "./modules/rds"
}