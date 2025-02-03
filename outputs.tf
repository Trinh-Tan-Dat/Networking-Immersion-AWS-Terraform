# output "security_group_vpcB_id" {
#   value = module.security_group_vpcB.security_group_id
#   description = "The ID of the security group in VPC B"
# }

# output "instance_ids_vpcB" {
#   value = module.auto_scaling.instance_ids
#   description = "The IDs of the instances in VPC B"
# }
output "security_group_vpcB_id" {
  value = module.security_group_vpcB.security_group_id
  description = "The ID of the security group in VPC B"
}
output "instance_ids_vpcB" {
  value = module.auto_scaling.instance_ids
  description = "The IDs of the instances in VPC B"
}
output "public_ec2_vpcA" {
  value = module.ec2_instance.ip_address_public
  description = "The IP addresses of the EC2 instances in VPC A"
}
output "private_ec2_vpcA" {
  value = module.ec2_instance.ip_address_private
  description = "The IP addresses of the EC2 instances in VPC A"
}
output "public_ec2_vpcB" {
  value = module.ec2_instance_vpcB.ip_address_public
  description = "The IP addresses of the EC2 instances in VPC B"
}
output "private_ec2_vpcB" {
  value = module.ec2_instance_vpcB.ip_address_private
  description = "The IP addresses of the EC2 instances in VPC B"
}
output "public_ec2_vpc_on_prem" {
  value = module.ec2_instance_on_prem.ip_address_public
  description = "The IP address of the EC2 instance in the on-premises VPC"
}
output "private_ec2_vpc_on_prem" {
  value = module.ec2_instance_on_prem.ip_address_public
  description = "The IP address of the EC2 instance in the on-premises VPC"
}
output "transit_gateway_id" {
  value = module.transit_gateway.transit_gateway_id
  description = "The ID of the Transit Gateway"
}
output "kms_endpoint_dns"{
  description = "DNS name of the KMS interface endpoint"
  value       = module.vpcB.kms_endpoint_dns
}
# output "public_ec2_ip_address_vpcC" {
#   value = module.auto_scaling.ip_addresses
#   description = "The IP addresses of the EC2 instances in VPC C"
# }
output "nlb_dns_name"{
  description = "DNS name of the Network Load Balancer"
  value       = module.network_load_balancer.nlb_dns_name
}