output "ip_address_public"{
    value = module.ec2_instance.public_ip
    description = "The IP address of the EC2 instance"
}
output "ip_address_private"{
    value = module.ec2_instance.private_ip
    description = "The private IP address of the EC2 instance"
}