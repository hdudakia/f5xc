provider "aws" {
  region     = "us-east-1"  # Change to your desired AWS region
  access_key = var.access_key
  secret_key = var.secret_key
}

module "my_vpc" {
  source     = "./modules/aws/vpc"
  vpc_name   = var.vpc_name
  vpc_cidr = var.vpc_cidr
}

module "my_subnet" {
  source       = "./modules/aws/subnet"
  subnet_name  = var.subnet_name
  subnet_cidr   = var.subnet_cidr
  vpc_id       = module.my_vpc.vpc_id
}

module "my_security_group" {
  source                = "./modules/aws/security_group"
  security_group_name   = var.security_group_name
  vpc_id                = module.my_vpc.vpc_id
}