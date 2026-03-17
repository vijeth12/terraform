provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source      = "./modules/vpc"
  vpc_cidr    = "10.0.0.0/16"
  subnet_cidr = "10.0.1.0/24"
}

module "sg" {
  source = "./modules/security-group"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source         = "./modules/ec2"
  ami            = "ami-0f58b397bc5c1f2e8"
  instance_type  = "t2.micro"
  subnet_id      = module.vpc.subnet_id
  sg_id          = module.sg.sg_id
}
