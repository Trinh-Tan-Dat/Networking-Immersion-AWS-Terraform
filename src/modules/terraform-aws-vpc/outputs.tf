
output "vpcA" {
  value = module.vpcA
}

output "vpcB" {
  value = module.vpcB
}

output "vpcA_id" {
  value = module.vpcA.vpc_id
}

output "vpcB_id" {
  value = module.vpcB.vpc_id
}

output "vpc_cidrA" {
  value = local.vpc_cidrA
}

output "vpc_cidrB"{
  value = local.vpc_cidrB
}

output "private_subnets_vpcA" {
  value = module.vpcA.private_subnets
}

output "private_subnets_vpcB" {
  value = module.vpcB.private_subnets
}

output "public_subnets_vpcA" {
  value = module.vpcA.public_subnets
}

output "public_subnets_vpcB" {
  value = module.vpcB.public_subnets
}