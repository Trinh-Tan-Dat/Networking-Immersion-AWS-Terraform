data "aws_instances" "asg_instances" {
  filter {
    name   = "tag:Environment"
    values = ["dev"]
  }
}

# output "instance_ids" {
#   value = data.aws_instances.asg_instances.ids
#   # value = module.asg.instance_ids
# }
output "instance_ids" {
  value       = data.aws_instances.vpcC_instances.ids
  description = "Danh sách EC2 instance IDs trong VPC C"
}



# output "instance_ids_asg" {
#     value = module.asg.
# }
output "ip_addresses" {
  value = data.aws_instances.asg_instances.public_ips
}
