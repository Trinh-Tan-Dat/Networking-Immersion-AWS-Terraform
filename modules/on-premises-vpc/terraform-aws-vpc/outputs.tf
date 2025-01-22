output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc_on_prem.private_subnets
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc_on_prem.public_subnets
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc_on_prem.vpc_id
}