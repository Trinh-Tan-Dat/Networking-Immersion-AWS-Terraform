output "vpcB_private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpcB.private_subnets
}

output "vpcB_public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpcB.public_subnets
}

output "vpcB_id" {
  description = "ID of the VPC"
  value       = module.vpcB.vpc_id
}