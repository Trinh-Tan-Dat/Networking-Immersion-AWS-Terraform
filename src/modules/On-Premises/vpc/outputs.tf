output "vpc_on_premises_id" {
  value = module.vpc_on_premises.vpc_id
}

output "public_subnet_on_premises" {
  value = module.vpc_on_premises.public_subnets
}

output "private_subnet_on_premises" {
  value = module.vpc_on_premises.private_subnets
}