# ./modules/aws/vpc/variables.tf

variable "vpc_name" {
  type        = string
  description = "The name of the VPC"
}

variable "vpc_cidr" {
  type        = string
  description = "The CIDR block for the VPC"
}
