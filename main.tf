//AWS Resources

provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

module "my_vpc" {
  source   = "./modules/aws/vpc"
  vpc_name = var.vpc_name
  vpc_cidr = var.vpc_cidr
}

module "my_subnet" {
  source            = "./modules/aws/subnet"
  subnet_name       = var.subnet_name
  subnet_cidr       = var.subnet_cidr
  availability_zone = var.availability_zone
  vpc_id            = module.my_vpc.vpc_id
  depends_on        = [module.my_vpc]
}

module "my_security_group" {
  source              = "./modules/aws/security_group"
  security_group_name = var.security_group_name
  vpc_id              = module.my_vpc.vpc_id
  depends_on          = [module.my_subnet]
}


// F5 Site

terraform {
  required_providers {
    volterra = {
      source  = "volterraedge/volterra"
      version = ">= 0.11.22"
    }
  }
}
provider "volterra" {
  api_p12_file = var.p12_file
  url          = var.f5xc_api_url

}

module "my_site" {
  source                                = "./modules/site"
  f5xc_api_url                          = var.f5xc_api_url
  f5xc_namespace                        = var.f5xc_namespace
  f5xc_aws_region                       = var.f5xc_aws_region
  f5xc_aws_cred                         = var.f5xc_aws_cred
  f5xc_aws_vpc_site_name                = var.f5xc_aws_vpc_site_name
  f5xc_aws_vpc_total_worker_nodes       = 0
  f5xc_aws_ce_gw_type                   = var.f5xc_aws_ce_gw_type
  f5xc_aws_vpc_existing_id              = module.my_vpc.vpc_id
  f5xc_aws_vpc_local_existing_subnet_id = module.my_subnet.subnet_id
  f5xc_aws_vpc_az_nodes                 = 1
  f5xc_aws_vpc_no_worker_nodes          = false
  f5xc_aws_vpc_use_http_https_port      = true
  f5xc_aws_vpc_use_http_https_port_sli  = true
  ssh_public_key                        = "ssh-rsa xyz"
  f5xc_tf_wait_for_action               = var.f5xc_tf_wait_for_action

  depends_on = [module.my_subnet]
}