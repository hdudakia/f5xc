provider "aws" {
  region     = "us-east-1"  # Change to your desired AWS region

  # AWS credentials (replace with your own credentials)
  access_key = "your_access_key"
  secret_key = "your_secret_key"
}

module "my_vpc" {
  source     = "./modules/aws/vpc"
  vpc_name   = "MyVPC"
  cidr_block = "10.0.0.0/16"  # Replace with your desired CIDR block for VPC
}

module "my_subnet" {
  source       = "./modules/aws/subnet"
  subnet_name  = "MySubnet"
  cidr_block   = "10.0.1.0/24"  # Replace with your desired CIDR block for Subnet
  vpc_id       = module.my_vpc.aws_vpc.main.id
}

module "my_security_group" {
  source                = "./modules/aws/security_group"
  security_group_name   = "MySecurityGroup"
  vpc_id                = module.my_vpc.aws_vpc.main.id
}

output "vpc_id" {
  value = module.my_vpc.aws_vpc.main.id
}

output "subnet_id" {
  value = module.my_subnet.subnet_id
}

output "security_group_id" {
  value = module.my_security_group.security_group_id
}