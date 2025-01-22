output "vpcC_private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpcC.private_subnets
}

output "vpcC_public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpcC.public_subnets
}

output "vpcC_id" {
  description = "ID of the VPC"
  value       = module.vpcC.vpc_id
}