output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpcA.private_subnets
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpcA.public_subnets
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpcA.vpc_id
}