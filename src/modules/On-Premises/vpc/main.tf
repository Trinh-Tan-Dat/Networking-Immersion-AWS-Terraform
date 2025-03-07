provider "aws" {
  region = local.region
}

data "aws_availability_zones" "available" {}

locals {
  region = "us-east-1"

  vpc_cidr = "172.16.0.0/16"

  azs      = slice(data.aws_availability_zones.available.names, 0, 2)

  tags = {
    GithubRepo = "terraform-aws-vpc"
    GithubOrg  = "terraform-aws-modules"
  }
}


# resource "aws_route" "vpcA_to_vpcB" {
#   route_table_id         = module.on_premises.private_route_table_ids[0]
#   destination_cidr_block = "10.1.0.0/16"
#   transit_gateway_id     = var.transit_gateway_id
# }


# resource "aws_route" "vpcB_to_vpcA" {
#   route_table_id         = module.vpcB.private_route_table_ids[0]
#   destination_cidr_block = "10.0.0.0/16"
#   transit_gateway_id     = var.transit_gateway_id
# }


################################################################################
# VPC Module
################################################################################

module "vpc_on_premises" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc_on_premises"
  cidr = local.vpc_cidr

  azs                 = local.azs
  private_subnets     = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
  public_subnets      = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 4)]

  create_database_subnet_route_table    = true
  create_elasticache_subnet_route_table = true
  create_redshift_subnet_route_table    = true

  single_nat_gateway = true
  enable_nat_gateway = true

  tags = local.tags
}

