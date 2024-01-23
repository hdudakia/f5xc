# modules/subnet/variables.tf

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

variable "availability_zone" {
  type = string
}