output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpcB.private_subnets
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpcB.public_subnets
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpcB.vpc_id
}
output "kms_endpoint_dns"{
  description = "DNS name of the KMS interface endpoint"
  value       = aws_vpc_endpoint.kms_interface.dns_entry[0].dns_name
}