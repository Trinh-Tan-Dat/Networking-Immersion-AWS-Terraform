output "security_group_id_one"{
    description = "Security group ID to associate with instances"
    value       = aws_security_group.service_one.id
}

output "vpc_id" {
    description = "VPC ID"
    # value       = module.vpc.vpc_id
    value = var.vpc_id
}

output "security_group_id_two"{
    description = "Security group ID to associate with instances"
    value       = aws_security_group.service_two.id
}