output "public_subnet_ids" {
  description = "List of public subnets"
  value       = module.vpc.public_subnets
  
}

output "private_subnet_ids" {
  description = "List of private subnets"
  value       = module.vpc.private_subnets
  
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

# output "nat_gateway_ids"{
#   description = "Ids of NAT Gateway IDs"
#   value       = module.vpc.nat_gateway_ids
# }

output "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  value       = module.vpc.vpc_cidr_block
}