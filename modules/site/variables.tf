variable "f5xc_api_url" {}
variable "f5xc_aws_cred" {}
variable "f5xc_namespace" {}

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

variable "f5xc_aws_vpc_primary_ipv4" {
  type    = string
  default = ""
}

variable "f5xc_aws_vpc_az_nodes" {
  type = number
}

variable "f5xc_aws_ce_gw_type" {
  type    = string
  default = "multi_nic"

  validation {
    condition     = contains(["multi_nic", "single_nic"], var.f5xc_aws_ce_gw_type)
    error_message = format("Valid values for f5xc_aws_ce_gw_type: multi_nic, single_nic")
  }
}

variable "f5xc_aws_ce_certified_hw" {
  type    = map(string)
  default = {
    multi_nic  = "aws-byol-multi-nic-voltmesh"
    single_nic = "aws-byol-voltmesh"
    app_stack  = "aws-byol-voltstack-combo"
  }
}

variable "f5xc_aws_site_kind" {
  type    = string
  default = "aws_vpc_site"
}

variable "ssh_public_key" {}

variable "f5xc_aws_vpc_ce_instance_type" {
  type    = string
  default = "t3.xlarge"
}

variable "f5xc_aws_vpc_worker_nodes_per_az" {
  type    = number
  default = 0
}

variable "f5xc_aws_vpc_total_worker_nodes" {
  type    = number
  default = 0
}

variable "f5xc_aws_vpc_no_worker_nodes" {
  type = bool
}

variable "f5xc_aws_vpc_use_http_https_port" {
  type = bool
}

variable "f5xc_aws_vpc_use_http_https_port_sli" {
  type = bool
}

variable "f5xc_aws_vpc_logs_streaming_disabled" {
  type    = bool
  default = true
}

variable "f5xc_aws_vpc_existing_id" {
  type    = string
  default = ""
}

variable "f5xc_nic_type_single_nic" {
  type    = string
  default = "single_nic"
}

variable "f5xc_nic_type_multi_nic" {
  type    = string
  default = "multi_nic"
}

variable "f5xc_tf_params_action" {
  type    = string
  default = "apply"

  validation {
    condition     = contains(["apply", "plan"], var.f5xc_tf_params_action)
    error_message = format("Valid values for f5xc_tf_params_action: apply, plan")
  }
}

variable "f5xc_tf_wait_for_action" {
  type    = bool
  default = true
}

variable "f5xc_labels" {
  type    = map(string)
  default = {}
}

variable "custom_tags" {
  description = "Custom tags to set on resources"
  type        = map(string)
  default     = {}
}

variable "f5xc_aws_vpc_enable_internet_vip" {
  type    = bool
  default = false
}

variable "is_sensitive" {
  type    = bool
  default = false
}

variable "f5xc_aws_vpc_local_existing_subnet_id" {}