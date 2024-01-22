variable "security_group_name" {
  type        = string
  description = "The name of the security group"
}

variable "subnet_name" {
  type        = string
  description = "The name of the subnet"
}

variable "subnet_cidr" {
  type        = string
  description = "The CIDR block for the subnet"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the associated VPC"
}

variable "vpc_name" {
  type        = string
  description = "The name of the VPC"
}

variable "vpc_cidr" {
  type        = string
  description = "The CIDR block for the VPC"
}


variable "access_key" {}
variable "secret_key" {}