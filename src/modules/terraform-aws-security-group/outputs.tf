output "sg_vpcA" {
    value = module.sg_vpcA 
}

output "sg_vpcB" {
    value = module.sg_vpcB
  
}

# output "security_group_ids_vpcA" {
#     value = [module.sg_vpcA.security_group_id]
# }

# output "security_group_ids_vpcB" {
#     value = [module.sg_vpcB.security_group_id]
# }

output "security_group_ids_vpcA" {
  value = [aws_security_group.service_one_vpcA.id]
}

output "security_group_ids_vpcB" {
  value = [aws_security_group.service_one_vpcB.id]
}
