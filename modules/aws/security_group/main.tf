# modules/security_group/main.tf

variable "security_group_name" {
  type        = string
  description = "The name of the security group"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the associated VPC"
}

resource "aws_security_group" "main" {
  name        = var.security_group_name
  vpc_id      = var.vpc_id
  description = "Security group for MyApplication"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
