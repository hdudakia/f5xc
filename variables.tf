// AWS 
variable "security_group_name" { type = string }
variable "subnet_name" { type = string }
variable "availability_zone" { type = string }
variable "subnet_cidr" { type = string }
variable "vpc_name" { type = string }
variable "vpc_cidr" { type = string }
variable "region" {}
variable "access_key" {}
variable "secret_key" {}

// F5
variable "p12_file" {}
variable "f5xc_api_url" {}
variable "f5xc_aws_cred" {}
variable "f5xc_namespace" {}
variable "f5xc_aws_vpc_az_nodes" { type = string }
variable "f5xc_aws_vpc_use_http_https_port" { type = bool }
variable "f5xc_aws_vpc_use_http_https_port_sli" { type = bool }
variable "ssh_public_key" {}
variable "f5xc_aws_vpc_no_worker_nodes" { type = bool }
//variable "f5xc_aws_vpc_existing_id" { type = string }
variable "f5xc_tf_wait_for_action" { type = bool }

variable "f5xc_aws_vpc_site_name" {
  type = string
  validation {
    condition     = length(var.f5xc_aws_vpc_site_name) <= 64
    error_message = format("Max length for f5xc_aws_vpc_site_name ist 64 characters")
  }

}

variable "f5xc_aws_region" {
  type = string
  validation {
    condition = contains([
      "us-east-2", "us-east-1", "us-west-1", "us-west-2", "af-south-1", "ap-east-1", "ap-southeast-3", "ap-south-1",
      "ap-northeast-3", "ap-northeast-2", "ap-southeast-1", "ap-southeast-2", "ap-northeast-1", "ca-central-1", "eu-central-1",
      "eu-west-1", "eu-west-2", "eu-south-1", "eu-west-3", "eu-north-1", "me-south-1", "sa-east-1"
    ], var.f5xc_aws_region)
    error_message = format("Valid values for f5xc_aws_region: us-east-2, us-east-1, us-west-1, us-west-2, af-south-1, ap-east-1, ap-southeast-3, ap-south-1, ap-northeast-3, ap-northeast-2, ap-southeast-1, ap-southeast-2, ap-northeast-1, ca-central-1, eu-central-1, eu-west-1, eu-west-2, eu-south-1, eu-west-3, eu-north-1,  me-south-1, sa-east-1")
  }
}

variable "f5xc_aws_ce_gw_type" {
  type    = string
  default = "single_nic"
  validation {
    condition     = contains(["multi_nic", "single_nic"], var.f5xc_aws_ce_gw_type)
    error_message = format("Valid values for f5xc_aws_ce_gw_type: multi_nic, single_nic")
  }
}

variable "f5xc_tf_params_action" {
  type = string
  validation {
    condition     = contains(["apply", "plan"], var.f5xc_tf_params_action)
    error_message = format("Valid values for f5xc_tf_params_action: apply, plan")
  }
}