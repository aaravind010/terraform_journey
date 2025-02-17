module "vpc" {
  source = "./network"
}

module "sg" {
  source = "./security"
  
}

module "ec2" {
  source = "./ec2"

}