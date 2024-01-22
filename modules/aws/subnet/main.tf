resource "aws_subnet" "main" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr_block
  availability_zone       = "us-east-1a"  # Change to your desired availability zone
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet_name
  }
}