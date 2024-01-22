variable "vpc_name" {
  type    = string
  description = "The name of the VPC"
}

variable "cidr_block" {
  type        = string
  description = "The CIDR block for the VPC"
}