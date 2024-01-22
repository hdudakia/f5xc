# ./modules/aws/vpc/outputs.tf

output "vpc_id" {
  description = "The ID of the created VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the created VPC"
  value       = aws_vpc.main.cidr_block
}

output "vpc_dns_support" {
  description = "Whether DNS support is enabled for the VPC"
  value       = aws_vpc.main.enable_dns_support
}

output "vpc_dns_hostnames" {
  description = "Whether DNS hostnames are enabled for the VPC"
  value       = aws_vpc.main.enable_dns_hostnames
}
