output "security_group_id"{
    description = "Security group ID to associate with instances"
    value       = aws_security_group.service_one.id
}

output "vpc_id" {
    description = "VPC ID"
    # value       = module.vpc.vpc_id
    value = var.vpc_id
}
