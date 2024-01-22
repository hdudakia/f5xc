# modules/subnet/outputs.tf

output "subnet_id" {
  description = "The ID of the created subnet"
  value       = aws_subnet.main.id
}

output "subnet_cidr_block" {
  description = "The CIDR block of the created subnet"
  value       = aws_subnet.main.cidr_block
}
