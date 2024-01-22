output "vpc_id" {
  value = module.my_vpc.vpc_id
}

output "subnet_id" {
  value = module.my_subnet.subnet_id
}

output "security_group_id" {
  value = module.my_security_group.security_group_id
}