provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/terraform-aws-vpc"
  transit_gateway_id = module.transit_gateway.transit_gateway_id
}


locals {
  tags = {
    GithubRepo = "terraform-aws-vpc"
    GithubOrg  = "terraform-aws-modules"
  }
}

module "security_group" {
  source = "./modules/terraform-aws-security-group"
  vpcA_id = module.vpc.vpcA_id
  vpcB_id = module.vpc.vpcB_id
}

module "ec2" {
  source = "./modules/terraform-aws-ec2"
  public_subnets_vpcA = module.vpc.public_subnets_vpcA[0]
  public_subnets_vpcB = module.vpc.public_subnets_vpcB[0]
  security_group_ids_vpcA = module.security_group.security_group_ids_vpcA
  security_group_ids_vpcB = module.security_group.security_group_ids_vpcB
  private_subnets_vpcA = module.vpc.private_subnets_vpcA[0]
  private_subnets_vpcB = module.vpc.private_subnets_vpcB[0]
}

module "transit_gateway" {
  source = "./modules/terraform-aws-transit-gateway"
  private_subnets_vpcA = module.vpc.private_subnets_vpcA
  private_subnets_vpcB = module.vpc.private_subnets_vpcB
  vpcA_id = module.vpc.vpcA_id
  vpcB_id = module.vpc.vpcB_id
}




///////////////////////////////////////////////////
//On-Premises
# ///////////////////////////////////////////////////


# module "vpc_on_premises" {
#   source = "./modules/On-Premises/vpc"

# }

# module "security_group_on_premises" {
#   source = "./modules/On-Premises/security-group"
#   vpc_on_premises_id = module.vpc_on_premises.vpc_on_premises_id
# }

# module "ec2_on_premises" {
#   source = "./modules/On-Premises/ec2"
#   public_subnet_on_premises = module.vpc_on_premises.public_subnet_on_premises[0]
#   sg_on_premises_id = module.security_group_on_premises.sg_on_premises_id
# }