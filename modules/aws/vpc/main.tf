variable "vpc_name" {
  type    = string
  description = "The name of the VPC"
}

variable "cidr_block" {
  type        = string
  description = "The CIDR block for the VPC"
}

resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}