# modules/subnet/main.tf

variable "subnet_name" {
  type        = string
  description = "The name of the subnet"
}

variable "cidr_block" {
  type        = string
  description = "The CIDR block for the subnet"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the associated VPC"
}

resource "aws_subnet" "main" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr_block
  availability_zone       = "us-east-1a"  # Change to your desired availability zone
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet_name
  }
}